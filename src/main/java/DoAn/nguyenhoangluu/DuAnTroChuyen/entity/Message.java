package DoAn.nguyenhoangluu.DuAnTroChuyen.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Entity
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String noiDung;

    private LocalDateTime thoiGian;

    private String fileUrl;

    private String fileType;

    private String fileName;

    private boolean seen;

    private LocalDateTime seenAt;

    @ManyToOne
    @JoinColumn(name = "mssv")
    private SinhVien nguoiGui;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private ChatRoom room;

    public Message() {
    }

    public Long getId() {
        return id;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public LocalDateTime getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(LocalDateTime thoiGian) {
        this.thoiGian = thoiGian;
    }

    public SinhVien getNguoiGui() {
        return nguoiGui;
    }

    public void setNguoiGui(SinhVien nguoiGui) {
        this.nguoiGui = nguoiGui;
    }

    public ChatRoom getRoom() {
        return room;
    }

    public void setRoom(ChatRoom room) {
        this.room = room;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public boolean isSeen() {
        return seen;
    }

    public void setSeen(boolean seen) {
        this.seen = seen;
    }

    public LocalDateTime getSeenAt() {
        return seenAt;
    }

    public void setSeenAt(LocalDateTime seenAt) {
        this.seenAt = seenAt;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
