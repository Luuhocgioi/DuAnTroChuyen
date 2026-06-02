package DoAn.nguyenhoangluu.DuAnTroChuyen.controllers;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.SinhVien;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.SinhVienRepository;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private SinhVienRepository sinhVienRepository;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam("mssv") String mssv,
            @RequestParam("password") String password,
            Model model,
            HttpSession session
    ) {

        SinhVien sv =
                sinhVienRepository.findByMssvAndPassword(
                        mssv,
                        password
                );

        if (sv != null) {

            sv.setOnline(true);
            sv.setLastSeen(LocalDateTime.now());
            sinhVienRepository.save(sv);
            session.setAttribute("user", sv);
            messagingTemplate.convertAndSend("/topic/presence",
                    (Object) java.util.Map.of("mssv", sv.getMssv(), "online", true));

            return "redirect:/home";
        }

        model.addAttribute(
                "error",
                "Sai MSSV hoặc password"
        );

        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        SinhVien sv = (SinhVien) session.getAttribute("user");
        if (sv != null) {
            ChatController.removePresenceUser(sv.getMssv());
            sv.setOnline(false);
            sv.setLastSeen(LocalDateTime.now());
            sinhVienRepository.save(sv);
            messagingTemplate.convertAndSend("/topic/presence",
                    (Object) java.util.Map.of("mssv", sv.getMssv(), "online", false));
        }
        session.invalidate();
        return "redirect:/login";
    }
}
