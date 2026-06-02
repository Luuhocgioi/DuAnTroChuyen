package DoAn.nguyenhoangluu.DuAnTroChuyen.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.ChatRoom;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.Khoa;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.Lop;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.SinhVien;

public interface ChatRoomRepository
        extends JpaRepository<ChatRoom, Long> {

    // Tìm room theo Khoa (GROUP)
	// ChatRoomRepository — thêm loaiRoom vào query
	Optional<ChatRoom> findByKhoaAndLoaiRoom(Khoa khoa, String loaiRoom);
	Optional<ChatRoom> findByLopAndLoaiRoom(Lop lop, String loaiRoom);

    // Tìm room 1-1 theo 2 user (2 chiều)
    ChatRoom findByUser1AndUser2(SinhVien user1, SinhVien user2);
    ChatRoom findByUser2AndUser1(SinhVien user2, SinhVien user1);

    // Lấy tất cả room PRIVATE của một sinh viên (2 chiều)
    @Query("SELECT r FROM ChatRoom r WHERE r.loaiRoom = 'PRIVATE' " +
           "AND (r.user1 = :sv OR r.user2 = :sv)")
    List<ChatRoom> findPrivateRooms(@Param("sv") SinhVien sv);

    // Lấy tất cả room GROUP (theo Khoa hoặc Lớp) của một sinh viên
    @Query("SELECT r FROM ChatRoom r WHERE r.loaiRoom != 'PRIVATE' " +
           "AND (r.khoa = :khoa OR r.lop = :lop)")
    List<ChatRoom> findGroupRooms(@Param("khoa") Khoa khoa,
                                  @Param("lop") Lop lop);
}