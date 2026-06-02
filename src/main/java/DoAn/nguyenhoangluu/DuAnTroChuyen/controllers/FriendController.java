package DoAn.nguyenhoangluu.DuAnTroChuyen.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.*;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.*;

import jakarta.servlet.http.HttpSession;

@Controller
public class FriendController {
	@Autowired
	private SimpMessagingTemplate messagingTemplate;
    @Autowired
    private SinhVienRepository sinhVienRepository;

    @Autowired
    private FriendRequestRepository friendRequestRepository;

    @Autowired
    private ChatRoomRepository chatRoomRepository;

    @GetMapping("/friends")
    public String friends(Model model,
                          HttpSession session) {

        SinhVien sv =
                (SinhVien) session.getAttribute("user");
        if (sv == null) return "redirect:/login";

        model.addAttribute(
                "requests",

                friendRequestRepository
                .findByNguoiNhanAndTrangThai(
                        sv,
                        "PENDING"
                )
        );
        model.addAttribute("sv", sv);

        return "friends";
    }

    @PostMapping("/friends/add")
    public String addFriend(
            @RequestParam("mssv") String mssv,
            HttpSession session
    ) {
        SinhVien nguoiGui = (SinhVien) session.getAttribute("user");
        if (nguoiGui == null) return "redirect:/login";

        // Không tự kết bạn với chính mình
        if (nguoiGui.getMssv().equals(mssv)) return "redirect:/friends";

        SinhVien nguoiNhan = sinhVienRepository.findByMssv(mssv);
        if (nguoiNhan == null) return "redirect:/friends";

        ChatRoom existingRoom = chatRoomRepository.findByUser1AndUser2(nguoiGui, nguoiNhan);
        if (existingRoom == null) {
            existingRoom = chatRoomRepository.findByUser2AndUser1(nguoiGui, nguoiNhan);
        }
        if (existingRoom != null) return "redirect:/friends";

        boolean daGui = friendRequestRepository
                .existsByNguoiGuiAndNguoiNhanAndTrangThaiNot(nguoiGui, nguoiNhan, "REJECTED");
        boolean daNhan = friendRequestRepository
                .existsByNguoiGuiAndNguoiNhanAndTrangThaiNot(nguoiNhan, nguoiGui, "REJECTED");

        if (daGui || daNhan) return "redirect:/friends";

     // Tìm bản ghi REJECTED cũ nếu có, cập nhật lại thay vì tạo mới
        FriendRequest request = friendRequestRepository
                .findByNguoiGuiAndNguoiNhan(nguoiGui, nguoiNhan)
                .orElse(new FriendRequest());

        request.setNguoiGui(nguoiGui);
        request.setNguoiNhan(nguoiNhan);
        request.setTrangThai("PENDING");
        friendRequestRepository.save(request);
        // Gửi JSON String tường minh — tránh lỗi "ambiguous method"
        String payload = String.format(
                "{\"id\":%d,\"hoTen\":\"%s\",\"mssv\":\"%s\"}",
                request.getId(),
                nguoiGui.getHoTen().replace("\"", "\\\""),
                nguoiGui.getMssv()
        );
        messagingTemplate.convertAndSend(
                "/topic/friend/" + nguoiNhan.getMssv(),
                payload
        );
        messagingTemplate.convertAndSend(
                "/topic/notify/" + nguoiNhan.getMssv(),
                (Object) Map.of("type", "FRIEND_REQUEST",
                       "senderMssv", nguoiGui.getMssv(),
                       "senderName", nguoiGui.getHoTen(),
                       "preview", "Co loi moi ket ban")
        );
        return "redirect:/friends";
    }

    @GetMapping("/friends/accept/{id}")
    public String accept(@PathVariable("id") Long id) {

        FriendRequest request = friendRequestRepository.findById(id).orElse(null);
        if (request == null) return "redirect:/friends";

        request.setTrangThai("ACCEPTED");
        friendRequestRepository.save(request);

        // ✅ Kiểm tra đã có room chưa trước khi tạo
        ChatRoom existing = chatRoomRepository
                .findByUser1AndUser2(request.getNguoiGui(), request.getNguoiNhan());
        if (existing == null) {
            existing = chatRoomRepository
                    .findByUser2AndUser1(request.getNguoiGui(), request.getNguoiNhan());
        }

        if (existing == null) {
            ChatRoom room = new ChatRoom();
            room.setTenRoom(request.getNguoiGui().getHoTen() + " - " + request.getNguoiNhan().getHoTen());
            room.setLoaiRoom("PRIVATE");
            room.setUser1(request.getNguoiGui());
            room.setUser2(request.getNguoiNhan());
            chatRoomRepository.save(room);
        }

        return "redirect:/friends";
    }

    @GetMapping("/friends/reject/{id}")
    public String reject(
            @PathVariable("id") Long id
    ) {

        FriendRequest request =
                friendRequestRepository
                .findById(id)
                .orElse(null);

        if (request != null) {

            request.setTrangThai("REJECTED");

            friendRequestRepository.save(request);
        }

        return "redirect:/friends";
    }
}
