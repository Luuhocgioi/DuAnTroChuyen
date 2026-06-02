package DoAn.nguyenhoangluu.DuAnTroChuyen.controllers;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import DoAn.nguyenhoangluu.DuAnTroChuyen.dto.MessageDTO;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.ChatRoom;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.Message;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.SinhVien;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.ChatRoomRepository;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.MessageRepository;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.SinhVienRepository;

@Controller
public class SocketChatController {

    @Autowired private SimpMessagingTemplate messagingTemplate;
    @Autowired private MessageRepository messageRepository;
    @Autowired private ChatRoomRepository chatRoomRepository;
    @Autowired private SinhVienRepository sinhVienRepository;

    @MessageMapping("/sendMessage")
    public void sendMessage(MessageDTO dto) {

        SinhVien sv = sinhVienRepository.findById(dto.getNguoiGui()).orElse(null);
        ChatRoom room = chatRoomRepository.findById(dto.getRoomId()).orElse(null);

        // Chỉ lưu DB nếu là tin nhắn TEXT (file đã lưu ở /upload rồi)
        if (dto.getFileUrl() == null) {
            Message message = new Message();
            message.setNguoiGui(sv);
            message.setRoom(room);
            message.setThoiGian(LocalDateTime.now());
            message.setNoiDung(dto.getNoiDung());
            messageRepository.save(message);
            dto.setId(message.getId());
        }

        dto.setNguoiGuiMssv(sv != null ? sv.getMssv() : dto.getNguoiGui());
        dto.setNguoiGui(sv != null ? sv.getHoTen() : dto.getNguoiGui());
        messagingTemplate.convertAndSend("/topic/room/" + dto.getRoomId(), dto);
        sendMessageNotifications(room, sv, dto);
    }

    @MessageMapping("/seen")
    @Transactional
    public void seen(Map<String, String> payload) {
        Long roomId = Long.valueOf(payload.get("roomId"));
        String viewerMssv = payload.get("viewerMssv");
        SinhVien viewer = sinhVienRepository.findByMssv(viewerMssv);
        if (viewer == null) return;

        int updated = messageRepository.markSeenByRoomAndViewer(roomId, viewerMssv, LocalDateTime.now());
        if (updated > 0) {
            messagingTemplate.convertAndSend("/topic/room/" + roomId + "/seen",
                    (Object) Map.of("roomId", roomId, "viewerMssv", viewerMssv, "viewerName", viewer.getHoTen()));
        }
    }

    @MessageMapping("/presence")
    public void presence(Map<String, String> payload) {
        String mssv = payload.get("mssv");
        String clientId = payload.get("clientId");
        SinhVien sv = sinhVienRepository.findByMssv(mssv);
        if (sv == null) return;

        boolean online = true;
        ChatController.presenceHeartbeat(sv.getMssv(), clientId);
        sv.setOnline(true);
        sv.setLastSeen(LocalDateTime.now());
        sinhVienRepository.save(sv);
        messagingTemplate.convertAndSend("/topic/presence",
                (Object) Map.of("mssv", sv.getMssv(), "online", online));
    }

    private void sendMessageNotifications(ChatRoom room, SinhVien sender, MessageDTO dto) {
        if (room == null || sender == null) return;

        List<SinhVien> receivers = new ArrayList<>();
        if ("PRIVATE".equals(room.getLoaiRoom())) {
            if (room.getUser1() != null && !room.getUser1().getMssv().equals(sender.getMssv())) receivers.add(room.getUser1());
            if (room.getUser2() != null && !room.getUser2().getMssv().equals(sender.getMssv())) receivers.add(room.getUser2());
        } else if ("KHOA".equals(room.getLoaiRoom()) && room.getKhoa() != null) {
            receivers.addAll(sinhVienRepository.findByKhoa(room.getKhoa()));
        } else if ("LOP".equals(room.getLoaiRoom()) && room.getLop() != null) {
            receivers.addAll(sinhVienRepository.findByLop(room.getLop()));
        }

        String preview = dto.getNoiDung();
        if (preview == null || preview.isBlank()) preview = dto.getFileName() != null ? dto.getFileName() : "Tin nhan moi";

        Map<String, Object> notification = Map.of(
                "type", "MESSAGE",
                "roomId", room.getId(),
                "roomName", room.getTenRoom(),
                "senderMssv", sender.getMssv(),
                "senderName", sender.getHoTen(),
                "preview", preview
        );

        for (SinhVien receiver : receivers) {
            if (!receiver.getMssv().equals(sender.getMssv())) {
                messagingTemplate.convertAndSend("/topic/notify/" + receiver.getMssv(), (Object) notification);
            }
        }
    }
}
