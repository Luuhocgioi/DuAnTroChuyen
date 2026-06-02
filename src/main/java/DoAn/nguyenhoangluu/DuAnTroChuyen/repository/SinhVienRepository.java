package DoAn.nguyenhoangluu.DuAnTroChuyen.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.Khoa;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.Lop;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.SinhVien;
public interface SinhVienRepository
extends JpaRepository<SinhVien, String> {

SinhVien findByMssvAndPassword(
    String mssv,
    String passwordS
    
);
SinhVien findByMssv(String mssv);

@Query("SELECT s FROM SinhVien s WHERE " +
       "LOWER(s.mssv) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
       "LOWER(s.hoTen) LIKE LOWER(CONCAT('%', :keyword, '%'))")
List<SinhVien> searchByMssvOrHoTen(@Param("keyword") String keyword);

@Query("SELECT s FROM SinhVien s WHERE s.khoa = :khoa OR s.lop.khoa = :khoa")
List<SinhVien> findByKhoa(@Param("khoa") Khoa khoa);

List<SinhVien> findByLop(Lop lop);
}
