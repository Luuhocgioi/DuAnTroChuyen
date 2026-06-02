package DoAn.nguyenhoangluu.DuAnTroChuyen.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.FriendRequest;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.SinhVien;

public interface FriendRequestRepository
extends JpaRepository<FriendRequest, Long> {

List<FriendRequest> findByNguoiNhanAndTrangThai(
    SinhVien nguoiNhan, String trangThai);


// ✅ Thêm cái này — Controller và Service đang dùng
boolean existsByNguoiGuiAndNguoiNhan(
    SinhVien nguoiGui, SinhVien nguoiNhan);

// Giữ cái này nếu cần dùng sau
boolean existsByNguoiGuiAndNguoiNhanAndTrangThaiNot(
    SinhVien nguoiGui, SinhVien nguoiNhan, String trangThai);

@Query("SELECT f FROM FriendRequest f " +
   "WHERE (f.nguoiGui = :sv OR f.nguoiNhan = :sv) " +
   "AND f.trangThai = 'ACCEPTED'")
List<FriendRequest> findBanBe(@Param("sv") SinhVien sv);
Optional<FriendRequest> findByNguoiGuiAndNguoiNhan(
        SinhVien nguoiGui, SinhVien nguoiNhan);
}