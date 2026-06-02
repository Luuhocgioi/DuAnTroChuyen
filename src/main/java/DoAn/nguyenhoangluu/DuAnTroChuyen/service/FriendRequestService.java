package DoAn.nguyenhoangluu.DuAnTroChuyen.service;

import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.FriendRequest;
import DoAn.nguyenhoangluu.DuAnTroChuyen.entity.SinhVien;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.FriendRequestRepository;
import DoAn.nguyenhoangluu.DuAnTroChuyen.repository.SinhVienRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FriendRequestService {

    private final FriendRequestRepository friendRequestRepository;
    private final SinhVienRepository sinhVienRepository;

    public FriendRequestService(FriendRequestRepository friendRequestRepository,
                                SinhVienRepository sinhVienRepository) {
        this.friendRequestRepository = friendRequestRepository;
        this.sinhVienRepository = sinhVienRepository;
    }

    // Gửi lời mời kết bạn
    public void guiLoiMoi(SinhVien nguoiGui, String mssvNguoiNhan) {

        // Không tự kết bạn với chính mình
        if (nguoiGui.getMssv().equals(mssvNguoiNhan)) return;

        SinhVien nguoiNhan = sinhVienRepository.findByMssv(mssvNguoiNhan);
        if (nguoiNhan == null) return;

        // Kiểm tra đã gửi lời mời chưa (2 chiều)
        boolean daGuiRoi = friendRequestRepository
                .existsByNguoiGuiAndNguoiNhan(nguoiGui, nguoiNhan);
        boolean daNhanRoi = friendRequestRepository
                .existsByNguoiGuiAndNguoiNhan(nguoiNhan, nguoiGui);

        if (daGuiRoi || daNhanRoi) return;

        FriendRequest request = new FriendRequest();
        request.setNguoiGui(nguoiGui);
        request.setNguoiNhan(nguoiNhan);
        request.setTrangThai("PENDING");

        friendRequestRepository.save(request);
    }

    // Lấy danh sách lời mời đang chờ (gửi đến mình)
    public List<FriendRequest> layLoiMoiDen(SinhVien nguoiNhan) {
        return friendRequestRepository
                .findByNguoiNhanAndTrangThai(nguoiNhan, "PENDING");
    }

    // Chấp nhận lời mời
    public void chapNhan(Long requestId) {
        Optional<FriendRequest> opt = friendRequestRepository.findById(requestId);
        if (opt.isEmpty()) return;

        FriendRequest request = opt.get();
        request.setTrangThai("ACCEPTED");
        friendRequestRepository.save(request);
    }

    // Từ chối lời mời
    public void tuChoi(Long requestId) {
        Optional<FriendRequest> opt = friendRequestRepository.findById(requestId);
        if (opt.isEmpty()) return;

        FriendRequest request = opt.get();
        request.setTrangThai("REJECTED");
        friendRequestRepository.save(request);
    }

    // Lấy danh sách bạn bè (2 chiều)
    public List<FriendRequest> layDanhSachBanBe(SinhVien sv) {
        return friendRequestRepository.findBanBe(sv);
    }
}