package DoAn.nguyenhoangluu.DuAnTroChuyen.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class SinhVien {

    @Id
    private String mssv;

    private String hoTen;

    private String password;

    private boolean online;

    private LocalDateTime lastSeen;

    @ManyToOne
    @JoinColumn(name = "ma_khoa")
    private Khoa khoa;

    @ManyToOne
    @JoinColumn(name = "ma_lop")
    private Lop lop;

    public SinhVien() {
    }

    public String getMssv() {
        return mssv;
    }

    public void setMssv(String mssv) {
        this.mssv = mssv;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    public LocalDateTime getLastSeen() {
        return lastSeen;
    }

    public void setLastSeen(LocalDateTime lastSeen) {
        this.lastSeen = lastSeen;
    }

    public Khoa getKhoa() {
        return khoa;
    }

    public void setKhoa(Khoa khoa) {
        this.khoa = khoa;
    }

    public Lop getLop() {
        return lop;
    }

    public void setLop(Lop lop) {
        this.lop = lop;
    }
}
