-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 02, 2026 lúc 03:15 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `chat`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chat_room`
--

CREATE TABLE `chat_room` (
  `id` bigint(20) NOT NULL,
  `loai_room` varchar(255) DEFAULT NULL,
  `ten_room` varchar(255) DEFAULT NULL,
  `ma_khoa` varchar(255) DEFAULT NULL,
  `ma_lop` varchar(255) DEFAULT NULL,
  `user1` varchar(255) DEFAULT NULL,
  `user2` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `chat_room`
--

INSERT INTO `chat_room` (`id`, `loai_room`, `ten_room`, `ma_khoa`, `ma_lop`, `user1`, `user2`) VALUES
(1, 'KHOA', 'Khoa CNTT', NULL, NULL, NULL, NULL),
(2, 'LOP', 'Lop CNTT1', NULL, NULL, NULL, NULL),
(3, 'GROUP', 'Room QTKD', 'QTKD', NULL, NULL, NULL),
(4, 'KHOA', 'Khoa Công nghệ thông tin', 'CNTT', NULL, NULL, NULL),
(5, 'LOP', 'CNTT-1', NULL, 'CNTT1', NULL, NULL),
(6, 'LOP', 'QTKD-1', NULL, 'QTKD1', NULL, NULL),
(7, 'LOP', 'CNTT-2', NULL, 'CNTT2', NULL, NULL),
(12, 'PRIVATE', 'Nguyen Hoang Luu - Le Thu Ha', NULL, NULL, '65131861', '65130003'),
(13, 'KHOA', 'Khoa Quản trị kinh doanh', 'QTKD', NULL, NULL, NULL),
(14, 'PRIVATE', 'Nguyen Hoang Luu - Pham Gia Bao', NULL, NULL, '65131861', '65130004'),
(15, 'KHOA', 'Khoa Kế toán', 'KT', NULL, NULL, NULL),
(16, 'LOP', 'KT-1', NULL, 'KT1', NULL, NULL),
(17, 'PRIVATE', 'Nguyen Hoang Luu - Vo Ngoc Anh', NULL, NULL, '65131861', '65130005'),
(18, 'PRIVATE', 'Nguyen Hoang Luu - Phan Nhật Quang', NULL, NULL, '65131861', '65130012'),
(19, 'LOP', 'KT-2', NULL, 'KT2', NULL, NULL),
(20, 'PRIVATE', 'Nguyen Hoang Luu - Phạm Nhật Nam', NULL, NULL, '65131861', '65130019'),
(21, 'KHOA', 'Khoa Ngôn ngữ Anh', 'NN', NULL, NULL, NULL),
(22, 'LOP', 'NN-2', NULL, 'NN2', NULL, NULL),
(23, 'PRIVATE', 'Nguyen Hoang Luu - Phạm Mỹ Duyên', NULL, NULL, '65131861', '65130041'),
(24, 'LOP', 'QTKD-2', NULL, 'QTKD2', NULL, NULL),
(25, 'PRIVATE', 'Nguyen Hoang Luu - Phạm Gia Minh', NULL, NULL, '65131861', '65130058'),
(26, 'PRIVATE', 'Nguyen Hoang Luu - Phạm Hoàng Long', NULL, NULL, '65131861', '65130066'),
(27, 'KHOA', 'Khoa Du lịch', 'DL', NULL, NULL, NULL),
(28, 'LOP', 'DL-2', NULL, 'DL2', NULL, NULL),
(29, 'PRIVATE', 'Nguyen Hoang Luu - Phạm Hoàng Anh', NULL, NULL, '65131861', '65130073'),
(30, 'PRIVATE', 'Nguyen Hoang Luu - Phạm Văn Thành', NULL, NULL, '65131861', '65130087'),
(31, 'PRIVATE', 'Nguyen Hoang Luu - Huỳnh Thanh Tùng', NULL, NULL, '65131861', '65130094'),
(32, 'PRIVATE', 'Nguyen Hoang Luu - Phạm Gia Hân', NULL, NULL, '65131861', '65130095'),
(33, 'PRIVATE', 'Nguyen Hoang Luu - Phan Đức Long', NULL, NULL, '65131861', '65130156');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `friend_request`
--

CREATE TABLE `friend_request` (
  `id` bigint(20) NOT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `nguoi_gui_mssv` varchar(255) DEFAULT NULL,
  `nguoi_nhan_mssv` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `friend_request`
--

INSERT INTO `friend_request` (`id`, `trang_thai`, `nguoi_gui_mssv`, `nguoi_nhan_mssv`) VALUES
(8, 'ACCEPTED', '65131861', '65132222'),
(9, 'REJECTED', '65131861', '65131111'),
(10, 'REJECTED', '65131861', '65131111'),
(11, 'REJECTED', '65131861', '65131111'),
(12, 'ACCEPTED', '65131861', '65130003'),
(13, 'REJECTED', '65130003', '65131861'),
(14, 'ACCEPTED', '65131861', '65130004'),
(15, 'ACCEPTED', '65131861', '65130005'),
(16, 'ACCEPTED', '65131861', '65130012'),
(17, 'ACCEPTED', '65131861', '65130019'),
(18, 'ACCEPTED', '65131861', '65130041'),
(19, 'ACCEPTED', '65131861', '65130058'),
(20, 'ACCEPTED', '65131861', '65130066'),
(21, 'ACCEPTED', '65131861', '65130073'),
(22, 'ACCEPTED', '65131861', '65130087'),
(23, 'ACCEPTED', '65131861', '65130094'),
(24, 'ACCEPTED', '65131861', '65130095'),
(25, 'ACCEPTED', '65131861', '65130156'),
(26, 'REJECTED', '65130073', '65130087');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khoa`
--

CREATE TABLE `khoa` (
  `ma_khoa` varchar(255) NOT NULL,
  `ten_khoa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `khoa`
--

INSERT INTO `khoa` (`ma_khoa`, `ten_khoa`) VALUES
('CNTT', 'Công nghệ thông tin'),
('DL', 'Du lịch'),
('KT', 'Kế toán'),
('NN', 'Ngôn ngữ Anh'),
('QTKD', 'Quản trị kinh doanh');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lop`
--

CREATE TABLE `lop` (
  `ma_lop` varchar(255) NOT NULL,
  `ten_lop` varchar(255) DEFAULT NULL,
  `ma_khoa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `lop`
--

INSERT INTO `lop` (`ma_lop`, `ten_lop`, `ma_khoa`) VALUES
('CNTT1', 'CNTT-1', 'CNTT'),
('CNTT2', 'CNTT-2', 'CNTT'),
('CNTT3', 'CNTT-3', 'CNTT'),
('DL1', 'DL-1', 'DL'),
('DL2', 'DL-2', 'DL'),
('KT1', 'KT-1', 'KT'),
('KT2', 'KT-2', 'KT'),
('NN1', 'NN-1', 'NN'),
('NN2', 'NN-2', 'NN'),
('QTKD1', 'QTKD-1', 'QTKD'),
('QTKD2', 'QTKD-2', 'QTKD');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `message`
--

CREATE TABLE `message` (
  `id` bigint(20) NOT NULL,
  `noi_dung` varchar(255) DEFAULT NULL,
  `thoi_gian` datetime(6) DEFAULT NULL,
  `mssv` varchar(255) DEFAULT NULL,
  `room_id` bigint(20) DEFAULT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `seen` bit(1) NOT NULL,
  `seen_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `message`
--

INSERT INTO `message` (`id`, `noi_dung`, `thoi_gian`, `mssv`, `room_id`, `file_type`, `file_url`, `file_name`, `seen`, `seen_at`) VALUES
(1, 'hụ', '2026-05-25 03:17:27.000000', '65131861', 1, NULL, NULL, NULL, b'0', NULL),
(2, 'xin chào', '2026-05-25 03:17:30.000000', '65131861', 1, NULL, NULL, NULL, b'0', NULL),
(3, 'chào', '2026-05-25 03:18:28.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(4, 'chào', '2026-05-25 03:21:38.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(5, '', '2026-05-25 03:21:41.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(6, '', '2026-05-25 03:21:43.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(7, '', '2026-05-25 03:21:44.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(8, '', '2026-05-25 03:22:59.000000', '65131861', 1, NULL, NULL, NULL, b'0', NULL),
(9, 's', '2026-05-25 03:23:00.000000', '65131861', 1, NULL, NULL, NULL, b'0', NULL),
(10, 'chào', '2026-05-25 03:23:07.000000', '65131861', 1, NULL, NULL, NULL, b'0', NULL),
(11, '', '2026-05-25 03:23:10.000000', '65131861', 1, NULL, NULL, NULL, b'0', NULL),
(12, 'chào', '2026-05-25 03:25:47.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(13, '', '2026-05-25 03:30:21.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(14, 's', '2026-05-25 03:30:23.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(15, 's', '2026-05-25 03:30:30.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(16, 'hi', '2026-05-25 03:30:34.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(17, 'chào', '2026-05-25 03:30:40.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(18, 'tôi là', '2026-05-25 03:30:49.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(19, 'Lưu', '2026-05-25 03:30:51.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(20, 'Bạn', '2026-05-25 03:30:53.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(21, 'là AI', '2026-05-25 03:30:54.000000', '65130003', 1, NULL, NULL, NULL, b'0', NULL),
(22, 'Chào bạn', '2026-05-25 03:31:07.000000', '65130003', 2, NULL, NULL, NULL, b'0', NULL),
(23, 'hi', '2026-05-25 03:51:34.000000', '65131861', 4, NULL, NULL, NULL, b'1', '2026-05-30 01:12:12.000000'),
(24, 'hi', '2026-05-25 03:51:37.000000', '65131861', 4, NULL, NULL, NULL, b'1', '2026-05-30 01:12:12.000000'),
(25, 'hi', '2026-05-25 03:52:02.000000', '65130003', 4, NULL, NULL, NULL, b'1', '2026-05-30 01:10:55.000000'),
(26, 'chào bạn', '2026-05-25 03:52:07.000000', '65131861', 4, NULL, NULL, NULL, b'1', '2026-05-30 01:12:12.000000'),
(27, 'chào', '2026-05-25 03:54:13.000000', '65131861', 5, NULL, NULL, NULL, b'0', NULL),
(28, NULL, '2026-05-28 01:42:05.000000', '65131861', 12, 'IMAGE', '/uploads/74b206bc-01b4-4e2f-9907-ff687dcc8b01_ChatGPT Image May 27, 2026, 03_34_29 AM.png', 'ChatGPT Image May 27, 2026, 03_34_29 AM.png', b'1', '2026-05-30 01:09:50.000000'),
(29, NULL, '2026-05-28 01:51:16.000000', '65131861', 12, 'IMAGE', '/uploads/5ebcc8b0-d3e3-4522-9c5d-844d0f6b6e2a_ChatGPT Image May 27, 2026, 03_34_29 AM.png', 'ChatGPT Image May 27, 2026, 03_34_29 AM.png', b'1', '2026-05-30 01:09:50.000000'),
(30, NULL, '2026-05-28 01:53:43.000000', '65131861', 12, 'FILE', '/uploads/190b1b33-8e64-4df4-8ac8-7a24ca92896b_ElevenLabs_Host_You_ever_see_someone_put_their_.mp3', 'ElevenLabs_Host_You_ever_see_someone_put_their_.mp3', b'1', '2026-05-30 01:09:50.000000'),
(31, NULL, '2026-05-29 01:35:38.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:09:55.000000'),
(32, 'hi', '2026-05-29 01:35:44.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:09:55.000000'),
(33, NULL, '2026-05-29 01:35:48.000000', '65130003', 12, 'IMAGE', '/uploads/82c7320d-d90f-4e71-ac02-0abc8aead697_ChatGPT Image May 27, 2026, 03_09_13 AM.png', 'ChatGPT Image May 27, 2026, 03_09_13 AM.png', b'1', '2026-05-30 01:09:55.000000'),
(34, NULL, '2026-05-29 01:35:48.000000', '65130003', 12, 'IMAGE', '/uploads/82c7320d-d90f-4e71-ac02-0abc8aead697_ChatGPT Image May 27, 2026, 03_09_13 AM.png', 'ChatGPT Image May 27, 2026, 03_09_13 AM.png', b'1', '2026-05-30 01:09:55.000000'),
(35, 'hi', '2026-05-29 01:38:52.000000', '65130003', 4, NULL, NULL, NULL, b'1', '2026-05-30 01:10:55.000000'),
(36, 'bạn là ai', '2026-05-29 01:38:55.000000', '65130003', 4, NULL, NULL, NULL, b'1', '2026-05-30 01:10:55.000000'),
(37, 'Tôi là tôi', '2026-05-29 01:38:58.000000', '65130003', 4, NULL, NULL, NULL, b'1', '2026-05-30 01:10:55.000000'),
(38, 'chào', '2026-05-29 01:39:07.000000', '65130003', 7, NULL, NULL, NULL, b'0', NULL),
(39, 'chào', '2026-05-29 01:39:13.000000', '65130003', 7, NULL, NULL, NULL, b'0', NULL),
(40, 'hu', '2026-05-29 03:12:27.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:09:50.000000'),
(41, 'hi', '2026-05-30 01:09:52.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:09:55.000000'),
(42, 'gì thế ạ', '2026-05-30 01:10:11.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:10:25.000000'),
(43, 'ko có gì', '2026-05-30 01:10:34.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:10:34.000000'),
(44, 'thật ko', '2026-05-30 01:10:41.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:10:45.000000'),
(45, 'hello', '2026-05-30 01:13:06.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:16:35.000000'),
(46, 'hi', '2026-05-30 01:13:50.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:16:35.000000'),
(47, 'hi', '2026-05-30 01:16:21.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:16:35.000000'),
(48, 'hi', '2026-05-30 01:16:32.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:16:35.000000'),
(49, 'hi', '2026-05-30 01:16:42.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:17:40.000000'),
(50, 'hi', '2026-05-30 01:17:38.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:17:40.000000'),
(51, 'hi', '2026-05-30 01:20:30.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(52, 'ád', '2026-05-30 01:20:32.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(53, 'ád', '2026-05-30 01:20:32.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(54, 'ád', '2026-05-30 01:20:33.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(55, 'ád', '2026-05-30 01:20:33.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(56, 'ád', '2026-05-30 01:20:34.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(57, 'ád', '2026-05-30 01:20:34.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(58, 'á', '2026-05-30 01:20:34.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(59, 'da', '2026-05-30 01:20:34.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(60, 'sd', '2026-05-30 01:20:35.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(61, 'á', '2026-05-30 01:20:35.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(62, 'da', '2026-05-30 01:20:35.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(63, 'sd', '2026-05-30 01:20:40.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(64, 'ád', '2026-05-30 01:20:40.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(65, 'ád', '2026-05-30 01:20:41.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(66, 'ád', '2026-05-30 01:20:41.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(67, 'ád', '2026-05-30 01:20:42.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(68, 'ád', '2026-05-30 01:20:42.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(69, 'ád', '2026-05-30 01:20:43.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:20:47.000000'),
(70, 'hi', '2026-05-30 01:21:12.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:22:48.000000'),
(71, 'hi', '2026-05-30 01:21:12.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:22:48.000000'),
(72, 'ghghgfghfg', '2026-05-30 01:21:14.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:22:48.000000'),
(73, 'hi', '2026-05-30 01:23:51.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:24:34.000000'),
(74, 'hi', '2026-05-30 01:24:32.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:24:34.000000'),
(75, 'hi', '2026-05-30 01:30:20.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:30:29.000000'),
(76, 'hi', '2026-05-30 01:30:21.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:30:29.000000'),
(77, 'hi', '2026-05-30 01:30:22.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:30:29.000000'),
(78, 'hi', '2026-05-30 01:30:22.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:30:29.000000'),
(79, 'hi', '2026-05-30 01:30:23.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:30:29.000000'),
(80, 'hi', '2026-05-30 01:30:23.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:30:29.000000'),
(81, 'hi', '2026-05-30 01:30:27.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:30:29.000000'),
(82, 'hi', '2026-05-30 01:39:12.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:39:42.000000'),
(83, 'chào', '2026-05-30 01:39:16.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:39:42.000000'),
(84, 'hi', '2026-05-30 01:39:42.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:39:42.000000'),
(85, 'hi', '2026-05-30 01:39:45.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:39:45.000000'),
(86, 'hi', '2026-05-30 01:39:49.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:39:56.000000'),
(87, 'hi', '2026-05-30 01:39:56.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:39:56.000000'),
(88, 'hi', '2026-05-30 01:44:56.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:49:14.000000'),
(89, 'hi', '2026-05-30 01:46:10.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:49:14.000000'),
(90, 'hi', '2026-05-30 01:46:40.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:49:14.000000'),
(91, 'hi', '2026-05-30 01:46:59.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:49:14.000000'),
(92, 'hi', '2026-05-30 01:47:00.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:49:14.000000'),
(93, 'hi', '2026-05-30 01:49:05.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:49:14.000000'),
(94, 'hi', '2026-05-30 01:49:10.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:49:14.000000'),
(95, 'xin chào', '2026-05-30 01:49:12.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:49:14.000000'),
(96, 'hi', '2026-05-30 01:49:59.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:50:01.000000'),
(97, 'xin chào', '2026-05-30 01:50:04.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:50:04.000000'),
(98, 'xin chào', '2026-05-30 01:50:09.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:50:12.000000'),
(99, 'hi', '2026-05-30 01:53:30.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 01:53:31.000000'),
(100, 'hi', '2026-05-30 01:53:34.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(101, 'hi', '2026-05-30 01:53:35.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(102, 'hi', '2026-05-30 01:54:06.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(103, 'hi', '2026-05-30 01:54:58.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(104, 'hi', '2026-05-30 01:55:05.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(105, 'hi', '2026-05-30 01:55:07.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(106, 'hi', '2026-05-30 01:55:08.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(107, 'hi', '2026-05-30 01:55:09.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(108, 'sa', '2026-05-30 01:55:10.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(109, 'sa', '2026-05-30 01:55:11.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(110, 'A', '2026-05-30 01:55:12.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(111, 'XZCV', '2026-05-30 01:55:18.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(112, 'XCV', '2026-05-30 01:55:18.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(113, 'XCV', '2026-05-30 01:55:19.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(114, 'zx', '2026-05-30 01:55:20.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:52.000000'),
(115, 'HI', '2026-05-30 02:01:55.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:01:55.000000'),
(116, 'hi', '2026-05-30 02:06:37.000000', '65130003', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:06:38.000000'),
(117, 'hi', '2026-05-30 02:07:56.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:07:57.000000'),
(118, 'hi', '2026-05-30 02:15:20.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:15:29.000000'),
(119, 'hi', '2026-05-30 02:15:25.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:15:29.000000'),
(120, 'hi', '2026-05-30 02:15:27.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:15:29.000000'),
(121, 'chào', '2026-05-30 02:15:33.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:22:47.000000'),
(122, 'làm bt', '2026-05-30 02:15:34.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:22:47.000000'),
(123, 'chưa', '2026-05-30 02:15:35.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:22:47.000000'),
(124, 'hả', '2026-05-30 02:15:37.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:22:47.000000'),
(125, 'hi', '2026-05-30 02:22:54.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:23:09.000000'),
(126, 'hi', '2026-05-30 02:22:59.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:23:09.000000'),
(127, 'hi', '2026-05-30 02:23:00.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:23:09.000000'),
(128, 'hi', '2026-05-30 02:23:01.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:23:09.000000'),
(129, 'hi', '2026-05-30 02:23:02.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:23:09.000000'),
(130, 'hi', '2026-05-30 02:23:02.000000', '65131861', 12, NULL, NULL, NULL, b'1', '2026-05-30 02:23:09.000000'),
(131, NULL, '2026-05-30 02:23:28.000000', '65130003', 12, 'IMAGE', '/uploads/d19de442-403e-468b-a9a9-f91babcede6a_187_fading-silhouette-continuing-to-walk-forward-while_a.jpg', '187_fading-silhouette-continuing-to-walk-forward-while_a.jpg', b'1', '2026-05-30 02:23:28.000000'),
(132, NULL, '2026-05-31 00:27:12.000000', '65131861', 12, 'FILE', '/uploads/4f6a29ef-a09c-4e6a-aa10-bfb5e467f94d_CapCut_7645405273661816852_installer (1).exe', 'CapCut_7645405273661816852_installer (1).exe', b'1', '2026-05-31 00:28:01.000000'),
(133, NULL, '2026-05-31 00:27:51.000000', '65131861', 12, 'FILE', '/uploads/c5a9421d-8e86-4a18-b74d-c643ad4aa03e_Codex Installer.exe', 'Codex Installer.exe', b'1', '2026-05-31 00:28:01.000000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sinh_vien`
--

CREATE TABLE `sinh_vien` (
  `mssv` varchar(255) NOT NULL,
  `ho_ten` varchar(255) DEFAULT NULL,
  `khoa` varchar(255) DEFAULT NULL,
  `lop` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `ma_khoa` varchar(255) DEFAULT NULL,
  `ma_lop` varchar(255) DEFAULT NULL,
  `last_seen` datetime(6) DEFAULT NULL,
  `online` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sinh_vien`
--

INSERT INTO `sinh_vien` (`mssv`, `ho_ten`, `khoa`, `lop`, `password`, `ma_khoa`, `ma_lop`, `last_seen`, `online`) VALUES
('65130003', 'Le Thu Ha', NULL, NULL, '123', 'CNTT', 'CNTT2', '2026-06-02 08:09:37.000000', b'0'),
('65130004', 'Pham Gia Bao', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65130005', 'Vo Ngoc Anh', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65130012', 'Phan Nhật Quang', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65130019', 'Phạm Nhật Nam', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65130041', 'Phạm Mỹ Duyên', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65130058', 'Phạm Gia Minh', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65130066', 'Phạm Hoàng Long', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65130073', 'Phạm Hoàng Anh', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65130087', 'Phạm Văn Thành', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65130094', 'Huỳnh Thanh Tùng', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65130095', 'Phạm Gia Hân', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65130156', 'Phan Đức Long', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65131111', 'Nguyễn Văn Thiện', '', '', '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65131124', 'Phan Quốc Thái', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65131139', 'Phan Tú Uyên', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65131142', 'Võ Mỹ Tiên', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65131158', 'Phan Minh Tài', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65131167', 'Phan Minh Châu', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65131173', 'Phan Hoàng Sơn', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65131183', 'Phan Quốc Huy', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65131195', 'Phan Gia Linh', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65131284', 'Nguyễn Văn An', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65131861', 'Nguyen Hoang Luu', NULL, NULL, '123', 'CNTT', 'CNTT1', '2026-05-31 00:28:31.000000', b'1'),
('65132207', 'Đặng Minh Tâm', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65132216', 'Lê Khánh Linh', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65132222', 'Nguyễn Văn Thiện', '', '', '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65132234', 'Trần Minh Tâm', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65132240', 'Đặng Gia Phúc', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65132255', 'Đặng Ngọc Mai', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65132264', 'Đặng Kim Ngân', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65132278', 'Trần Gia Linh', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65132280', 'Đặng Quốc Cường', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65132291', 'Đặng Hoàng Vũ', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65133344', 'Phạm Quốc Trung', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65133489', 'Bùi Thanh Phong', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65134412', 'Ngô Đức Huy', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65134418', 'Đặng Tuấn Anh', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65134421', 'Trần Quốc Việt', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65134439', 'Trần Thị Yến', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65134450', 'Trần Anh Khoa', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65134461', 'Trần Ngọc Mai', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65134465', 'Bùi Khánh Toàn', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65134474', 'Trần Minh Phúc', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65134477', 'Nguyễn Thị Mai', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65134499', 'Trần Quốc Khải', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65134765', 'Lê Hoàng Nam', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65135511', 'Nguyễn Thảo Vy', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65135515', 'Nguyễn Đức Huy', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65135528', 'Huỳnh Gia Bảo', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65135533', 'Nguyễn Quốc Bảo', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65135548', 'Nguyễn Thanh Hà', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65135562', 'Võ Minh Nhật', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65135574', 'Nguyễn Ngọc Trâm', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65135583', 'Nguyễn Thu Trang', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65135590', 'Nguyễn Thành Công', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65135597', 'Huỳnh Quốc Khánh', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65136542', 'Phạm Gia Huy', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65136603', 'Đặng Minh Hiếu', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65136611', 'Bùi Thanh Sơn', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65136628', 'Bùi Thảo Nhi', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65136632', 'Bùi Mỹ Linh', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65136644', 'Bùi Văn Đức', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65136655', 'Bùi Minh Khôi', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65136671', 'Bùi Công Thành', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65136678', 'Bùi Hoàng Sơn', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65136690', 'Bùi Gia Khánh', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65137654', 'Đặng Tuấn Kiệt', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65137706', 'Lê Thanh Thảo', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65137717', 'Lê Minh Tài', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65137729', 'Phan Minh Đức', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65137739', 'Lê Minh Tuấn', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65137748', 'Lê Thảo Nguyên', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65137754', 'Lê Quốc Hùng', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65137763', 'Lê Nhật Trường', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65137780', 'Lê Minh Hoàng', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65137788', 'Ngô Thanh Bình', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65137890', 'Phạm Thu Hà', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65138743', 'Ngô Nhật Minh', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65138805', 'Huỳnh Đức Anh', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65138819', 'Huỳnh Ngọc Ánh', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65138825', 'Võ Thành Đạt', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65138833', 'Huỳnh Minh Tân', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65138842', 'Huỳnh Minh Triết', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65138857', 'Huỳnh Gia Hân', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65138863', 'Đặng Quốc Việt', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65138874', 'Huỳnh Tú Anh', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65138888', 'Huỳnh Nhật Minh', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65138920', 'Võ Kim Anh', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65138947', 'Võ Thanh Sang', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65138951', 'Võ Minh Quý', NULL, NULL, '123', 'KT', 'KT1', NULL, b'0'),
('65138973', 'Võ Minh Châu', NULL, NULL, '123', 'NN', 'NN1', NULL, b'0'),
('65138984', 'Võ Đức Tài', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65138991', 'Nguyễn Hải Đăng', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65138995', 'Võ Nhật Hào', NULL, NULL, '123', 'DL', 'DL1', NULL, b'0'),
('65139017', 'Võ Quốc Bảo', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65139821', 'Trần Minh Quân', NULL, NULL, '123', 'CNTT', 'CNTT1', NULL, b'0'),
('65139903', 'Ngô Hải Yến', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65139917', 'Lê Ngọc Hân', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65139929', 'Ngô Quốc An', NULL, NULL, '123', 'QTKD', 'QTKD2', NULL, b'0'),
('65139937', 'Ngô Quốc Hưng', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0'),
('65139945', 'Trần Ngọc Anh', NULL, NULL, '123', 'QTKD', 'QTKD1', NULL, b'0'),
('65139952', 'Ngô Thanh Vy', NULL, NULL, '123', 'NN', 'NN2', NULL, b'0'),
('65139960', 'Ngô Thanh Tâm', NULL, NULL, '123', 'KT', 'KT2', NULL, b'0'),
('65139966', 'Ngô Minh Quân', NULL, NULL, '123', 'CNTT', 'CNTT2', NULL, b'0'),
('65139981', 'Ngô Quốc Việt', NULL, NULL, '123', 'DL', 'DL2', NULL, b'0');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chat_room`
--
ALTER TABLE `chat_room`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKacecis7yd88kogr6j5wtxqe4h` (`ma_khoa`),
  ADD KEY `FKl83tesb4h70jjp0nv8g9jb4jd` (`ma_lop`),
  ADD KEY `FKp7qgehjmxuak8s8vgw121de13` (`user1`),
  ADD KEY `FK4r5gne8gcahapgt9nqfu5igr3` (`user2`);

--
-- Chỉ mục cho bảng `friend_request`
--
ALTER TABLE `friend_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKpr71micik58og9wse2ru6h65g` (`nguoi_gui_mssv`),
  ADD KEY `FKsqse8n8wj4xkb5hqw7txkiupj` (`nguoi_nhan_mssv`);

--
-- Chỉ mục cho bảng `khoa`
--
ALTER TABLE `khoa`
  ADD PRIMARY KEY (`ma_khoa`);

--
-- Chỉ mục cho bảng `lop`
--
ALTER TABLE `lop`
  ADD PRIMARY KEY (`ma_lop`),
  ADD KEY `FKloatoucsuw1w5v2yksiis5nw3` (`ma_khoa`);

--
-- Chỉ mục cho bảng `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK4kf29eendptky5sqfuxpifsuu` (`mssv`),
  ADD KEY `FKq97urb0l1mxmmjl54tmlya11f` (`room_id`);

--
-- Chỉ mục cho bảng `sinh_vien`
--
ALTER TABLE `sinh_vien`
  ADD PRIMARY KEY (`mssv`),
  ADD KEY `FKmqb2v7wsy27x8qg150vx61pha` (`ma_khoa`),
  ADD KEY `FKd6wx9fjodxfkjcdmm3biqagie` (`ma_lop`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `chat_room`
--
ALTER TABLE `chat_room`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT cho bảng `friend_request`
--
ALTER TABLE `friend_request`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT cho bảng `message`
--
ALTER TABLE `message`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chat_room`
--
ALTER TABLE `chat_room`
  ADD CONSTRAINT `FK4r5gne8gcahapgt9nqfu5igr3` FOREIGN KEY (`user2`) REFERENCES `sinh_vien` (`mssv`),
  ADD CONSTRAINT `FKacecis7yd88kogr6j5wtxqe4h` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`),
  ADD CONSTRAINT `FKl83tesb4h70jjp0nv8g9jb4jd` FOREIGN KEY (`ma_lop`) REFERENCES `lop` (`ma_lop`),
  ADD CONSTRAINT `FKp7qgehjmxuak8s8vgw121de13` FOREIGN KEY (`user1`) REFERENCES `sinh_vien` (`mssv`);

--
-- Các ràng buộc cho bảng `friend_request`
--
ALTER TABLE `friend_request`
  ADD CONSTRAINT `FKpr71micik58og9wse2ru6h65g` FOREIGN KEY (`nguoi_gui_mssv`) REFERENCES `sinh_vien` (`mssv`),
  ADD CONSTRAINT `FKsqse8n8wj4xkb5hqw7txkiupj` FOREIGN KEY (`nguoi_nhan_mssv`) REFERENCES `sinh_vien` (`mssv`);

--
-- Các ràng buộc cho bảng `lop`
--
ALTER TABLE `lop`
  ADD CONSTRAINT `FKloatoucsuw1w5v2yksiis5nw3` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`);

--
-- Các ràng buộc cho bảng `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `FK4kf29eendptky5sqfuxpifsuu` FOREIGN KEY (`mssv`) REFERENCES `sinh_vien` (`mssv`),
  ADD CONSTRAINT `FKq97urb0l1mxmmjl54tmlya11f` FOREIGN KEY (`room_id`) REFERENCES `chat_room` (`id`);

--
-- Các ràng buộc cho bảng `sinh_vien`
--
ALTER TABLE `sinh_vien`
  ADD CONSTRAINT `FKd6wx9fjodxfkjcdmm3biqagie` FOREIGN KEY (`ma_lop`) REFERENCES `lop` (`ma_lop`),
  ADD CONSTRAINT `FKmqb2v7wsy27x8qg150vx61pha` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
