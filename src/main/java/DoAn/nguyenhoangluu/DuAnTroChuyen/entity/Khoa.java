package DoAn.nguyenhoangluu.DuAnTroChuyen.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Khoa {

    @Id
    private String maKhoa;

    private String tenKhoa;

    public Khoa() {
    }

    public String getMaKhoa() {
        return maKhoa;
    }

    public void setMaKhoa(String maKhoa) {
        this.maKhoa = maKhoa;
    }

    public String getTenKhoa() {
        return tenKhoa;
    }

    public void setTenKhoa(String tenKhoa) {
        this.tenKhoa = tenKhoa;
    }
}
