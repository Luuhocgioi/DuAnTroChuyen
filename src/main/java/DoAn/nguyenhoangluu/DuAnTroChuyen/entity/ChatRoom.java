package DoAn.nguyenhoangluu.DuAnTroChuyen.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class ChatRoom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String tenRoom;

    private String loaiRoom;

    @ManyToOne
    @JoinColumn(name = "ma_khoa")
    private Khoa khoa;

    @ManyToOne
    @JoinColumn(name = "ma_lop")
    private Lop lop;

    // CHAT 1-1
    @ManyToOne
    @JoinColumn(name = "user1")
    private SinhVien user1;

    @ManyToOne
    @JoinColumn(name = "user2")
    private SinhVien user2;

    public ChatRoom() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTenRoom() {
        return tenRoom;
    }

    public void setTenRoom(String tenRoom) {
        this.tenRoom = tenRoom;
    }

    public String getLoaiRoom() {
        return loaiRoom;
    }

    public void setLoaiRoom(String loaiRoom) {
        this.loaiRoom = loaiRoom;
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

    public SinhVien getUser1() {
        return user1;
    }

    public void setUser1(SinhVien user1) {
        this.user1 = user1;
    }

    public SinhVien getUser2() {
        return user2;
    }

    public void setUser2(SinhVien user2) {
        this.user2 = user2;
    }
}