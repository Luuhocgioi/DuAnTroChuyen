package DoAn.nguyenhoangluu.DuAnTroChuyen.entity;

import jakarta.persistence.*;

@Entity
public class FriendRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private SinhVien nguoiGui;

    @ManyToOne
    private SinhVien nguoiNhan;

    private String trangThai;

    public FriendRequest() {
    }

    public Long getId() {
        return id;
    }

    public SinhVien getNguoiGui() {
        return nguoiGui;
    }

    public void setNguoiGui(SinhVien nguoiGui) {
        this.nguoiGui = nguoiGui;
    }

    public SinhVien getNguoiNhan() {
        return nguoiNhan;
    }

    public void setNguoiNhan(SinhVien nguoiNhan) {
        this.nguoiNhan = nguoiNhan;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
}