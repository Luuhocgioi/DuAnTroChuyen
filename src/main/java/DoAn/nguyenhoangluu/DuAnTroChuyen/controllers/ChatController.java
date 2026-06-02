package DoAn.nguyenhoangluu.DuAnTroChuyen.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

import DoAn.nguyenhoangluu.DuAnTroChuyen.dto.MessageDTO;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.*;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {

    private static final long MAX_UPLOAD_SIZE = 10L * 1024L * 1024L;
    private static final Set<String> ALLOWED_EXTENSIONS = Set.of("jpg", "jpeg", "png", "pdf", "docx", "zip");
    private static final Set<String> ALLOWED_CONTENT_TYPES = Set.of(
            "image/jpeg",
            "image/png",
            "application/pdf",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/zip",
            "application/x-zip-compressed"
    );

    @Autowired private ChatRoomRepository chatRoomRepository;
    @Autowired private MessageRepository messageRepository;
    @Autowired private SinhVienRepository sinhVienRepository;
    @Autowired private SimpMessagingTemplate messagingTemplate;

    private static final Duration PRESENCE_TTL = Duration.ofSeconds(30);
    private static final Map<String, Map<String, Instant>> ACTIVE_CLIENTS = new ConcurrentHashMap<>();

    public static boolean presenceHeartbeat(String mssv, String clientId) {
        if (mssv == null || mssv.isBlank() || clientId == null || clientId.isBlank()) return false;
        cleanupPresence();
        ACTIVE_CLIENTS.computeIfAbsent(mssv, key -> new ConcurrentHashMap<>()).put(clientId, Instant.now());
        return true;
    }

    public static boolean removePresenceClient(String mssv, String clientId) {
        if (mssv == null || clientId == null) return false;
        Map<String, Instant> clients = ACTIVE_CLIENTS.get(mssv);
        if (clients == null) return false;
        clients.remove(clientId);
        if (clients.isEmpty()) ACTIVE_CLIENTS.remove(mssv);
        return isPresenceOnline(mssv);
    }

    public static void removePresenceUser(String mssv) {
        if (mssv != null) ACTIVE_CLIENTS.remove(mssv);
    }

    public static boolean isPresenceOnline(String mssv) {
        cleanupPresence(mssv);
        Map<String, Instant> clients = ACTIVE_CLIENTS.get(mssv);
        return clients != null && !clients.isEmpty();
    }

    private static void cleanupPresence() {
        new ArrayList<>(ACTIVE_CLIENTS.keySet()).forEach(ChatController::cleanupPresence);
    }

    private static void cleanupPresence(String mssv) {
        Map<String, Instant> clients = ACTIVE_CLIENTS.get(mssv);
        if (clients == null) return;
        Instant expiredBefore = Instant.now().minus(PRESENCE_TTL);
        clients.entrySet().removeIf(entry -> entry.getValue().isBefore(expiredBefore));
        if (clients.isEmpty()) ACTIVE_CLIENTS.remove(mssv);
    }

    // ── GET /room/{id} ─────────────────────────────────────
    @GetMapping("/room/{id}")
    @Transactional
    public String room(@PathVariable("id") Long id, Model model, HttpSession session) {

        SinhVien sv = (SinhVien) session.getAttribute("user");
        if (sv == null) return "redirect:/login";

        ChatRoom room = chatRoomRepository.findById(id).orElse(null);
        if (room == null) return "redirect:/home";

        if (room.getKhoa() != null)
            if (!room.getKhoa().getMaKhoa().equals(sv.getKhoa().getMaKhoa()))
                return "redirect:/home";

        if (room.getLop() != null)
            if (!room.getLop().getMaLop().equals(sv.getLop().getMaLop()))
                return "redirect:/home";

        if ("PRIVATE".equals(room.getLoaiRoom())) {
            boolean ok = (room.getUser1() != null && room.getUser1().getMssv().equals(sv.getMssv()))
                      || (room.getUser2() != null && room.getUser2().getMssv().equals(sv.getMssv()));
            if (!ok) return "redirect:/home";
        }

        ChatRoom khoaRoom = chatRoomRepository
                .findByKhoaAndLoaiRoom(sv.getLop().getKhoa(), "KHOA")
                .orElse(null);
        ChatRoom lopRoom = chatRoomRepository
                .findByLopAndLoaiRoom(sv.getLop(), "LOP")
                .orElse(null);

        List<ChatRoom> rooms = new ArrayList<>();
        if (khoaRoom != null) rooms.add(khoaRoom);
        if (lopRoom  != null) rooms.add(lopRoom);
        List<ChatRoom> privateRooms = chatRoomRepository.findPrivateRooms(sv);
        List<Long> sidebarRoomIds = new ArrayList<>();
        rooms.forEach(r -> sidebarRoomIds.add(r.getId()));
        privateRooms.forEach(r -> sidebarRoomIds.add(r.getId()));
        markRoomSeen(id, sv);

        model.addAttribute("sv", sv);
        model.addAttribute("room", room);
        model.addAttribute("rooms", rooms);
        model.addAttribute("privateRooms", privateRooms);
        model.addAttribute("messages", messageRepository.findByRoomId(id));
        model.addAttribute("allStudents", sinhVienRepository.findAll());
        model.addAttribute("sidebarRoomIds", sidebarRoomIds);

        return "room";
    }

    @GetMapping("/api/sidebar/unread")
    @ResponseBody
    public ResponseEntity<Map<String, Long>> unreadCounts(
            @RequestParam("roomIds") String roomIds,
            HttpSession session
    ) {
        SinhVien sv = (SinhVien) session.getAttribute("user");
        if (sv == null) return ResponseEntity.status(401).build();

        Map<String, Long> result = new HashMap<>();
        for (String value : roomIds.split(",")) {
            if (value == null || value.isBlank()) continue;
            Long roomId = Long.valueOf(value.trim());
            result.put(String.valueOf(roomId),
                    messageRepository.countByRoomIdAndNguoiGuiMssvNotAndSeenFalse(roomId, sv.getMssv()));
        }
        return ResponseEntity.ok(result);
    }

    @GetMapping("/api/sidebar/presence")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> presence(
            @RequestParam("mssvs") String mssvs,
            HttpSession session
    ) {
        SinhVien sv = (SinhVien) session.getAttribute("user");
        if (sv == null) return ResponseEntity.status(401).build();

        Map<String, Boolean> result = new HashMap<>();
        for (String value : mssvs.split(",")) {
            if (value == null || value.isBlank()) continue;
            String mssv = value.trim();
            result.put(mssv, isPresenceOnline(mssv));
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/api/presence/heartbeat")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> heartbeat(
            @RequestParam(name = "clientId", required = false) String clientId,
            HttpSession session
    ) {
        SinhVien sv = (SinhVien) session.getAttribute("user");
        if (sv == null) return ResponseEntity.status(401).build();

        String activeClientId = clientId != null && !clientId.isBlank() ? clientId : session.getId();
        presenceHeartbeat(sv.getMssv(), activeClientId);
        sv.setOnline(true);
        sv.setLastSeen(LocalDateTime.now());
        sinhVienRepository.save(sv);
        messagingTemplate.convertAndSend("/topic/presence",
                (Object) Map.of("mssv", sv.getMssv(), "online", true));
        return ResponseEntity.ok(Map.of("mssv", sv.getMssv(), "online", true));
    }

    @RequestMapping(value = "/api/presence/offline", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ResponseEntity<Map<String, Object>> offline(
            @RequestParam(name = "clientId", required = false) String clientId,
            HttpSession session
    ) {
        SinhVien sv = (SinhVien) session.getAttribute("user");
        if (sv == null) return ResponseEntity.ok(Map.of("online", false));

        boolean stillOnline = removePresenceClient(sv.getMssv(), clientId);
        if (!stillOnline) {
            sv.setOnline(false);
            sv.setLastSeen(LocalDateTime.now());
            sinhVienRepository.save(sv);
        }
        messagingTemplate.convertAndSend("/topic/presence",
                (Object) Map.of("mssv", sv.getMssv(), "online", stillOnline));
        return ResponseEntity.ok(Map.of("mssv", sv.getMssv(), "online", stillOnline));
    }

    @RequestMapping(value = "/api/room/{id}/seen", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    @Transactional
    public ResponseEntity<Map<String, Object>> seenRoom(
            @PathVariable("id") Long id,
            HttpSession session
    ) {
        SinhVien sv = (SinhVien) session.getAttribute("user");
        if (sv == null) return ResponseEntity.status(401).build();

        int updated = markRoomSeen(id, sv);
        return ResponseEntity.ok(Map.of("roomId", id, "updated", updated));
    }

    @Transactional
    protected int markRoomSeen(Long roomId, SinhVien viewer) {
        int updated = messageRepository.markSeenByRoomAndViewer(roomId, viewer.getMssv(), LocalDateTime.now());
        if (updated > 0) {
            messagingTemplate.convertAndSend("/topic/room/" + roomId + "/seen",
                    (Object) Map.of("roomId", roomId,
                                    "viewerMssv", viewer.getMssv(),
                                    "viewerName", viewer.getHoTen()));
        }
        return updated;
    }

    // ── POST /room/{id}/upload — upload file, trả về JSON ──
    @PostMapping("/room/{id}/upload")
    @ResponseBody
    public ResponseEntity<MessageDTO> uploadFile(
            @PathVariable("id") Long id,
            @RequestParam("file") MultipartFile file,
            HttpSession session
    ) throws IOException {

        SinhVien sv = (SinhVien) session.getAttribute("user");
        if (sv == null) return ResponseEntity.status(401).build();
        if (file == null || file.isEmpty()) return ResponseEntity.badRequest().build();
        if (file.getSize() > MAX_UPLOAD_SIZE) return ResponseEntity.status(413).build();

        String originalName = file.getOriginalFilename();
        String extension = getFileExtension(originalName);
        String contentType = file.getContentType();
        if (!ALLOWED_EXTENSIONS.contains(extension)
                || contentType == null
                || !ALLOWED_CONTENT_TYPES.contains(contentType)) {
            return ResponseEntity.status(415).build();
        }

        String uploadDir = System.getProperty("user.dir") + "/uploads/";
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        String fileName = UUID.randomUUID() + "." + extension;
        file.transferTo(new File(uploadDir + fileName));

        String fileUrl  = "/uploads/" + fileName;
        String fileType = (file.getContentType() != null && file.getContentType().startsWith("image/"))
                          ? "IMAGE" : "FILE";

        // Lưu message vào DB
        ChatRoom room = chatRoomRepository.findById(id).orElse(null);
        Message message = new Message();
        message.setNguoiGui(sv);
        message.setRoom(room);
        message.setThoiGian(LocalDateTime.now());
        message.setFileName(originalName);
        message.setFileUrl(fileUrl);
        message.setFileType(fileType);
        messageRepository.save(message);

        // Trả về DTO để JS gửi qua STOMP
        MessageDTO dto = new MessageDTO();
        dto.setRoomId(id);
        dto.setNguoiGui(sv.getMssv());
        dto.setNguoiGuiMssv(sv.getMssv());
        dto.setId(message.getId());
        dto.setFileName(originalName);
        dto.setFileUrl(fileUrl);
        dto.setFileType(fileType);

        return ResponseEntity.ok(dto);
    }

    private String getFileExtension(String fileName) {
        if (fileName == null) return "";
        int dot = fileName.lastIndexOf('.');
        if (dot < 0 || dot == fileName.length() - 1) return "";
        return fileName.substring(dot + 1).toLowerCase(Locale.ROOT);
    }
}
