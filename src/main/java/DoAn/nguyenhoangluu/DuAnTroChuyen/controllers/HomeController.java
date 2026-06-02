package DoAn.nguyenhoangluu.DuAnTroChuyen.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.ChatRoom;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.SinhVien;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.ChatRoomRepository;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.SinhVienRepository;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    @Autowired
    private ChatRoomRepository chatRoomRepository;

    @Autowired
    private SinhVienRepository sinhVienRepository;

    @GetMapping("/home")
    public String home(Model model, HttpSession session) {

        SinhVien sv = (SinhVien) session.getAttribute("user");

        if (sv == null) return "redirect:/login";

        // ===== ROOM KHOA =====
        ChatRoom khoaRoom = chatRoomRepository.findByKhoaAndLoaiRoom(sv.getLop().getKhoa(), "KHOA")
                .orElse(null);

        if (khoaRoom == null) {
            khoaRoom = new ChatRoom();
            khoaRoom.setTenRoom("Khoa " + sv.getLop().getKhoa().getTenKhoa());
            khoaRoom.setLoaiRoom("KHOA");
            khoaRoom.setKhoa(sv.getLop().getKhoa());
            chatRoomRepository.save(khoaRoom);
        }

        // ===== ROOM LOP =====
        ChatRoom lopRoom = chatRoomRepository.findByLopAndLoaiRoom(sv.getLop(), "LOP")
                .orElse(null);

        if (lopRoom == null) {
            lopRoom = new ChatRoom();
            lopRoom.setTenRoom(sv.getLop().getTenLop());
            lopRoom.setLoaiRoom("LOP");
            lopRoom.setLop(sv.getLop());
            chatRoomRepository.save(lopRoom);
        }

        // ===== ROOM PRIVATE (chat 1-1 với bạn bè) =====
        List<ChatRoom> privateRooms = chatRoomRepository.findPrivateRooms(sv);

        // ===== Gộp tất cả rooms =====
        List<ChatRoom> rooms = new ArrayList<>();
        rooms.add(khoaRoom);
        rooms.add(lopRoom);
        List<Long> sidebarRoomIds = new ArrayList<>();
        rooms.forEach(r -> sidebarRoomIds.add(r.getId()));
        privateRooms.forEach(r -> sidebarRoomIds.add(r.getId()));

        model.addAttribute("sv", sv);
        model.addAttribute("rooms", rooms);
        model.addAttribute("privateRooms", privateRooms);
        model.addAttribute("allStudents", sinhVienRepository.findAll());
        model.addAttribute("sidebarRoomIds", sidebarRoomIds);

        return "home";
    }
}
