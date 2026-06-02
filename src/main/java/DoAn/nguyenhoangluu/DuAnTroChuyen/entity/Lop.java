package DoAn.nguyenhoangluu.DuAnTroChuyen.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Lop {

    @Id
    private String maLop;

    private String tenLop;

    @ManyToOne
    @JoinColumn(name = "ma_khoa")
    private Khoa khoa;

    public Lop() {
    }

    public String getMaLop() {
        return maLop;
    }

    public void setMaLop(String maLop) {
        this.maLop = maLop;
    }

    public String getTenLop() {
        return tenLop;
    }

    public void setTenLop(String tenLop) {
        this.tenLop = tenLop;
    }

    public Khoa getKhoa() {
        return khoa;
    }

    public void setKhoa(Khoa khoa) {
        this.khoa = khoa;
    }
}