package DoAn.nguyenhoangluu.DuAnTroChuyen.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.Message;

public interface MessageRepository
        extends JpaRepository<Message, Long> {

    List<Message> findByRoomId(Long roomId);

    @Modifying
    @Query("UPDATE Message m SET m.seen = true, m.seenAt = :seenAt " +
           "WHERE m.room.id = :roomId AND m.nguoiGui.mssv <> :viewerMssv AND m.seen = false")
    int markSeenByRoomAndViewer(@Param("roomId") Long roomId,
                                @Param("viewerMssv") String viewerMssv,
                                @Param("seenAt") LocalDateTime seenAt);

    long countByRoomIdAndNguoiGuiMssvNotAndSeenFalse(Long roomId, String viewerMssv);

}
