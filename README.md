# Hệ Thống Trò Chuyện Sinh Viên NTU - NTU CHAT

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Web-0ea5e9.svg?style=for-the-badge" alt="Platform">
  <img src="https://img.shields.io/badge/Java-17-f97316.svg?style=for-the-badge&logo=openjdk" alt="Java 17">
  <img src="https://img.shields.io/badge/Spring%20Boot-4.0.6-6db33f.svg?style=for-the-badge&logo=springboot" alt="Spring Boot">
  <img src="https://img.shields.io/badge/Database-MySQL-4479a1.svg?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Realtime-WebSocket%20%7C%20STOMP-22c55e.svg?style=for-the-badge" alt="WebSocket STOMP">
  <img src="https://img.shields.io/badge/View-Thymeleaf-005f0f.svg?style=for-the-badge&logo=thymeleaf" alt="Thymeleaf">
  <img src="https://img.shields.io/badge/Build-Gradle-02303a.svg?style=for-the-badge&logo=gradle" alt="Gradle">
</p>

**NTU CHAT** là ứng dụng web trò chuyện thời gian thực dành cho sinh viên, được xây dựng bằng **Spring Boot**, **Thymeleaf**, **MySQL** và **WebSocket/STOMP**. Hệ thống cho phép sinh viên đăng nhập bằng MSSV, tham gia phòng chat theo **Khoa**, **Lớp**, nhắn tin riêng sau khi kết bạn, gửi ảnh/file, theo dõi trạng thái online/offline và nhận thông báo tin nhắn mới theo thời gian thực.

Dự án phù hợp cho đồ án môn học, bài thực hành Spring Boot hoặc nền tảng mở rộng thành hệ thống giao tiếp nội bộ trong môi trường trường đại học.

---

## Mục Lục

- [Tính năng nổi bật](#tính-năng-nổi-bật)
- [Kiến trúc tổng quan](#kiến-trúc-tổng-quan)
- [Công nghệ sử dụng](#công-nghệ-sử-dụng)
- [Cấu trúc thư mục](#cấu-trúc-thư-mục)
- [Mô hình dữ liệu](#mô-hình-dữ-liệu)
- [Luồng hoạt động chính](#luồng-hoạt-động-chính)
- [WebSocket và API realtime](#websocket-và-api-realtime)
- [Cài đặt và chạy dự án](#cài-đặt-và-chạy-dự-án)
- [Dữ liệu mẫu](#dữ-liệu-mẫu)
- [Upload file](#upload-file)
- [Kiểm thử](#kiểm-thử)
- [Ghi chú bảo mật](#ghi-chú-bảo-mật)
- [Hướng phát triển](#hướng-phát-triển)

---

## Tính Năng Nổi Bật

### 1. Đăng nhập sinh viên bằng MSSV

- Sinh viên đăng nhập bằng **MSSV** và **mật khẩu** đã có trong database.
- Thông tin người dùng được lưu trong `HttpSession`.
- Khi đăng nhập thành công, hệ thống cập nhật trạng thái `online = true` và phát sự kiện presence qua WebSocket.
- Khi đăng xuất, hệ thống cập nhật `online = false`, lưu `lastSeen` và thông báo realtime cho các client khác.

### 2. Phòng chat theo Khoa và Lớp

- Mỗi sinh viên tự động có hai nhóm chat chính:
  - **Phòng Khoa**: dành cho sinh viên cùng khoa.
  - **Phòng Lớp**: dành cho sinh viên cùng lớp.
- Nếu phòng Khoa hoặc Lớp chưa tồn tại, hệ thống tự tạo khi sinh viên truy cập `/home`.
- Controller kiểm tra quyền truy cập phòng dựa trên `Khoa`, `Lop` và loại phòng để tránh sinh viên vào nhầm phòng không thuộc phạm vi của mình.

### 3. Chat riêng 1-1 sau khi kết bạn

- Sinh viên gửi lời mời kết bạn bằng MSSV.
- Người nhận có thể **chấp nhận** hoặc **từ chối** lời mời.
- Khi lời mời được chấp nhận, hệ thống tạo phòng chat riêng loại `PRIVATE`.
- Hệ thống kiểm tra hai chiều để tránh tạo trùng phòng riêng giữa cùng hai sinh viên.

### 4. Nhắn tin realtime bằng WebSocket/STOMP

- Tin nhắn text được gửi qua STOMP destination `/app/sendMessage`.
- Server lưu tin nhắn vào MySQL rồi broadcast tới `/topic/room/{roomId}`.
- Client trong cùng phòng nhận tin nhắn ngay lập tức mà không cần reload trang.
- Sidebar cũng subscribe các phòng liên quan để hiển thị thông báo tin nhắn mới.

### 5. Gửi ảnh và file trong phòng chat

- Hỗ trợ upload:
  - Ảnh: `jpg`, `jpeg`, `png`
  - Tài liệu: `pdf`, `docx`
  - Tệp nén: `zip`
- File được lưu tại thư mục `uploads/` trong root project.
- File được public qua route `/uploads/**`.
- Ảnh hiển thị trực tiếp trong khung chat, hỗ trợ xem lớn bằng lightbox và tải xuống.
- File tài liệu hiển thị dạng thẻ download.

### 6. Trạng thái online/offline và heartbeat

- Client gửi heartbeat định kỳ về `/api/presence/heartbeat`.
- Server lưu trạng thái hoạt động theo từng `clientId`, tránh lỗi một sinh viên mở nhiều tab nhưng đóng một tab đã bị tính offline.
- Presence có TTL 30 giây, tự dọn các client không còn heartbeat.
- Trạng thái online/offline được broadcast qua `/topic/presence`.

### 7. Tin nhắn chưa đọc và trạng thái đã xem

- Hệ thống đếm số tin chưa đọc theo phòng bằng repository query.
- Sidebar hiển thị badge số tin chưa đọc, giới hạn hiển thị tối đa `+5`.
- Khi người dùng vào phòng, server đánh dấu các tin nhắn của người khác là đã xem.
- Sự kiện đã xem được gửi tới `/topic/room/{roomId}/seen`.

### 8. Thông báo realtime

- Lời mời kết bạn được đẩy realtime tới `/topic/friend/{mssv}`.
- Tin nhắn mới được đẩy tới `/topic/notify/{mssv}`.
- Giao diện hiển thị toast nhỏ ở góc màn hình khi có tin nhắn hoặc lời mời mới.

---

## Kiến Trúc Tổng Quan

```text
Browser
  |
  | HTTP GET/POST
  v
Spring MVC Controllers
  |
  | Render HTML
  v
Thymeleaf Templates

Browser
  |
  | SockJS + STOMP
  v
WebSocket Endpoint /chat
  |
  | /app/sendMessage, /app/seen, /app/presence
  v
SocketChatController
  |
  | Save / query
  v
Spring Data JPA Repositories
  |
  v
MySQL Database

Uploaded files
  |
  v
uploads/ folder -> served by /uploads/**
```

Các lớp chính:

- `LoginController`: xử lý đăng nhập, đăng xuất và cập nhật presence ban đầu.
- `HomeController`: tạo/lấy phòng Khoa, phòng Lớp và danh sách phòng riêng.
- `ChatController`: render phòng chat, upload file, unread count, seen state, heartbeat online/offline.
- `SocketChatController`: xử lý tin nhắn realtime, seen event, presence event và notification.
- `FriendController`: gửi, nhận, chấp nhận và từ chối lời mời kết bạn.
- `WebSocketConfig`: cấu hình SockJS/STOMP endpoint `/chat`, broker `/topic`, prefix `/app`.
- `FileConfig`: public thư mục upload qua `/uploads/**`.

---

## Công Nghệ Sử Dụng

| Nhóm | Công nghệ |
|---|---|
| Ngôn ngữ | Java 17 |
| Framework chính | Spring Boot 4.0.6 |
| Web MVC | Spring Web MVC |
| View template | Thymeleaf |
| Realtime | Spring WebSocket, SockJS, STOMP |
| Database | MySQL |
| ORM | Spring Data JPA, Hibernate |
| Validation | Spring Boot Starter Validation |
| Security | Spring Security |
| Build tool | Gradle |
| Frontend | HTML, CSS, JavaScript thuần |
| Upload | Spring MultipartFile |
| Test | JUnit Platform, Spring Boot Test starters |

---

## Cấu Trúc Thư Mục

```text
DuAnTroChuyen/
├── build.gradle
├── settings.gradle
├── gradlew
├── gradlew.bat
├── uploads/
│   └── ...                         # File người dùng upload
└── src/
    ├── main/
    │   ├── java/
    │   │   └── DoAn/nguyenhoangluu/DuAnTroChuyen/
    │   │       ├── DuAnTroChuyenApplication.java
    │   │       ├── config/
    │   │       │   ├── FileConfig.java
    │   │       │   ├── SecurityConfig.java
    │   │       │   └── WebSocketConfig.java
    │   │       ├── controllers/
    │   │       │   ├── ChatController.java
    │   │       │   ├── FriendController.java
    │   │       │   ├── HomeController.java
    │   │       │   ├── LoginController.java
    │   │       │   └── SocketChatController.java
    │   │       ├── dto/
    │   │       │   └── MessageDTO.java
    │   │       ├── entity/
    │   │       │   ├── ChatRoom.java
    │   │       │   ├── FriendRequest.java
    │   │       │   ├── Khoa.java
    │   │       │   ├── Lop.java
    │   │       │   ├── Message.java
    │   │       │   └── SinhVien.java
    │   │       ├── repository/
    │   │       │   ├── ChatRoomRepository.java
    │   │       │   ├── FriendRequestRepository.java
    │   │       │   ├── KhoaRepository.java
    │   │       │   ├── LopRepository.java
    │   │       │   ├── MessageRepository.java
    │   │       │   └── SinhVienRepository.java
    │   │       └── service/
    │   │           └── FriendRequestService.java
    │   └── resources/
    │       ├── application.properties
    │       └── templates/
    │           ├── friends.html
    │           ├── home.html
    │           ├── login.html
    │           └── room.html
    └── test/
        └── java/
            └── DoAn/nguyenhoangluu/DuAnTroChuyen/
                └── DuAnTroChuyenApplicationTests.java
```

---

## Mô Hình Dữ Liệu

### `SinhVien`

Đại diện cho tài khoản sinh viên.

| Trường | Kiểu | Ý nghĩa |
|---|---|---|
| `mssv` | `String` | Mã số sinh viên, khóa chính |
| `hoTen` | `String` | Họ tên sinh viên |
| `password` | `String` | Mật khẩu đăng nhập |
| `online` | `boolean` | Trạng thái đang online |
| `lastSeen` | `LocalDateTime` | Lần hoạt động gần nhất |
| `khoa` | `Khoa` | Khoa của sinh viên |
| `lop` | `Lop` | Lớp của sinh viên |

### `Khoa`

| Trường | Kiểu | Ý nghĩa |
|---|---|---|
| `maKhoa` | `String` | Mã khoa, khóa chính |
| `tenKhoa` | `String` | Tên khoa |

### `Lop`

| Trường | Kiểu | Ý nghĩa |
|---|---|---|
| `maLop` | `String` | Mã lớp, khóa chính |
| `tenLop` | `String` | Tên lớp |
| `khoa` | `Khoa` | Khoa quản lý lớp |

### `ChatRoom`

| Trường | Kiểu | Ý nghĩa |
|---|---|---|
| `id` | `Long` | ID phòng chat |
| `tenRoom` | `String` | Tên phòng |
| `loaiRoom` | `String` | `KHOA`, `LOP` hoặc `PRIVATE` |
| `khoa` | `Khoa` | Khoa sở hữu phòng nhóm |
| `lop` | `Lop` | Lớp sở hữu phòng nhóm |
| `user1`, `user2` | `SinhVien` | Hai sinh viên trong phòng riêng |

### `Message`

| Trường | Kiểu | Ý nghĩa |
|---|---|---|
| `id` | `Long` | ID tin nhắn |
| `noiDung` | `String` | Nội dung text |
| `thoiGian` | `LocalDateTime` | Thời điểm gửi |
| `fileUrl` | `String` | URL file upload |
| `fileType` | `String` | `IMAGE` hoặc `FILE` |
| `fileName` | `String` | Tên file gốc |
| `seen` | `boolean` | Đã xem hay chưa |
| `seenAt` | `LocalDateTime` | Thời điểm đã xem |
| `nguoiGui` | `SinhVien` | Người gửi |
| `room` | `ChatRoom` | Phòng chứa tin nhắn |

### `FriendRequest`

| Trường | Kiểu | Ý nghĩa |
|---|---|---|
| `id` | `Long` | ID lời mời |
| `nguoiGui` | `SinhVien` | Người gửi lời mời |
| `nguoiNhan` | `SinhVien` | Người nhận lời mời |
| `trangThai` | `String` | `PENDING`, `ACCEPTED`, `REJECTED` |

---

## Luồng Hoạt Động Chính

### Luồng đăng nhập

1. Người dùng mở `/login`.
2. Form gửi `POST /login` với `mssv` và `password`.
3. `SinhVienRepository.findByMssvAndPassword(...)` kiểm tra thông tin.
4. Nếu hợp lệ:
   - Lưu `SinhVien` vào `HttpSession`.
   - Cập nhật `online = true`.
   - Gửi presence tới `/topic/presence`.
   - Redirect tới `/home`.
5. Nếu sai thông tin, trang login hiển thị lỗi.

### Luồng vào trang chủ

1. Người dùng truy cập `/home`.
2. `HomeController` lấy sinh viên từ session.
3. Hệ thống tìm hoặc tạo phòng:
   - `Khoa {tenKhoa}`
   - `{tenLop}`
4. Lấy danh sách phòng chat riêng của sinh viên.
5. Render `home.html` với sidebar, phòng nhóm, phòng riêng và badge chưa đọc.

### Luồng gửi tin nhắn text

1. Client gửi STOMP message tới `/app/sendMessage`.
2. `SocketChatController.sendMessage(...)` nhận `MessageDTO`.
3. Server lưu tin nhắn vào bảng `message`.
4. Server broadcast tin nhắn tới `/topic/room/{roomId}`.
5. Các client trong phòng nhận và render tin nhắn mới.
6. Server gửi notification tới người nhận qua `/topic/notify/{mssv}`.

### Luồng upload file

1. Client chọn file trong `room.html`.
2. JavaScript gửi `POST /room/{id}/upload`.
3. `ChatController.uploadFile(...)` kiểm tra:
   - Người dùng đã đăng nhập.
   - File không rỗng.
   - Kích thước không vượt 10MB.
   - Extension và content type hợp lệ.
4. Server lưu file vào thư mục `uploads/`.
5. Server tạo một bản ghi `Message` có `fileUrl`, `fileName`, `fileType`.
6. Client gửi DTO file qua STOMP để broadcast realtime.

### Luồng kết bạn

1. Sinh viên vào `/friends`.
2. Nhập MSSV người muốn kết bạn và gửi `POST /friends/add`.
3. Server kiểm tra:
   - Không tự kết bạn với chính mình.
   - MSSV người nhận tồn tại.
   - Hai người chưa có phòng riêng.
   - Chưa có lời mời pending/accepted hai chiều.
4. Server tạo `FriendRequest` trạng thái `PENDING`.
5. Người nhận thấy lời mời realtime qua `/topic/friend/{mssv}`.
6. Khi chấp nhận `/friends/accept/{id}`, server tạo phòng `PRIVATE`.

---

## WebSocket Và API Realtime

### Cấu hình WebSocket

| Thành phần | Giá trị |
|---|---|
| SockJS endpoint | `/chat` |
| Client gửi message | `/app/**` |
| Server broadcast | `/topic/**` |
| Broker | Simple broker trong Spring |

### STOMP destinations

| Destination | Chiều | Chức năng |
|---|---|---|
| `/app/sendMessage` | Client -> Server | Gửi tin nhắn text hoặc DTO file |
| `/app/seen` | Client -> Server | Đánh dấu phòng đã xem |
| `/app/presence` | Client -> Server | Gửi trạng thái online |
| `/topic/room/{roomId}` | Server -> Client | Broadcast tin nhắn trong phòng |
| `/topic/room/{roomId}/seen` | Server -> Client | Broadcast trạng thái đã xem |
| `/topic/presence` | Server -> Client | Broadcast online/offline |
| `/topic/friend/{mssv}` | Server -> Client | Lời mời kết bạn realtime |
| `/topic/notify/{mssv}` | Server -> Client | Thông báo tin nhắn/lời mời |

### HTTP routes chính

| Method | Route | Chức năng |
|---|---|---|
| `GET` | `/login` | Trang đăng nhập |
| `POST` | `/login` | Xử lý đăng nhập |
| `GET` | `/logout` | Đăng xuất |
| `GET` | `/home` | Trang tổng quan phòng chat |
| `GET` | `/room/{id}` | Vào phòng chat |
| `POST` | `/room/{id}/upload` | Upload file trong phòng |
| `GET` | `/friends` | Trang kết bạn |
| `POST` | `/friends/add` | Gửi lời mời kết bạn |
| `GET` | `/friends/accept/{id}` | Chấp nhận lời mời |
| `GET` | `/friends/reject/{id}` | Từ chối lời mời |
| `GET` | `/api/sidebar/unread` | Lấy số tin chưa đọc |
| `GET` | `/api/sidebar/presence` | Lấy trạng thái online/offline |
| `POST` | `/api/presence/heartbeat` | Gửi heartbeat online |
| `GET/POST` | `/api/presence/offline` | Báo client offline |
| `GET/POST` | `/api/room/{id}/seen` | Đánh dấu đã xem phòng |

---

## Cài Đặt Và Chạy Dự Án

### 1. Yêu cầu môi trường

- JDK 17
- MySQL Server
- Gradle Wrapper đã có sẵn trong project
- IDE khuyến nghị: IntelliJ IDEA, Eclipse hoặc VS Code

Kiểm tra Java:

```bash
java -version
```

### 2. Clone hoặc mở project

```bash
git clone https://github.com/Luuhocgioi/DuAnTroChuyen.git
cd DuAnTroChuyen
```

Nếu đã có source code trên máy, chỉ cần mở thư mục project trong IDE.

### 3. Tạo database MySQL

```sql
CREATE DATABASE chat CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 4. Cấu hình kết nối database

Mở file `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/chat
spring.datasource.username=root
spring.datasource.password=
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
```

Điều chỉnh `username` và `password` theo MySQL trên máy của bạn.

### 5. Chạy ứng dụng

Trên Windows:

```bash
./gradlew.bat bootRun
```

Trên macOS/Linux:

```bash
./gradlew bootRun
```

Sau khi chạy thành công, mở trình duyệt:

```text
http://localhost:8080/login
```

---

## Dữ Liệu Database

Ứng dụng hiện chưa có màn hình đăng ký tài khoản, vì vậy cần import dữ liệu MySQL trước khi đăng nhập.

Bạn có thể dùng file dump `chat (2).sql` xuất từ phpMyAdmin/MariaDB. File này đã bao gồm:

- Database logic cho các bảng `khoa`, `lop`, `sinh_vien`, `chat_room`, `message`, `friend_request`.
- Danh sách khoa: `CNTT`, `QTKD`, `KT`, `NN`, `DL`.
- Danh sách lớp như `CNTT1`, `CNTT2`, `QTKD1`, `QTKD2`, `KT1`, `KT2`, `NN1`, `NN2`, `DL1`, `DL2`.
- Nhiều tài khoản sinh viên có sẵn.
- Một số phòng chat nhóm, phòng lớp, phòng riêng và lịch sử tin nhắn mẫu.

### Cách import SQL

Tạo database rỗng:

```sql
CREATE DATABASE chat CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Sau đó import file SQL bằng phpMyAdmin hoặc MySQL/MariaDB CLI:

```bash
mysql -u root -p chat < "chat (2).sql"
```

Nếu dùng XAMPP/phpMyAdmin:

1. Mở phpMyAdmin.
2. Tạo database tên `chat`.
3. Chọn database `chat`.
4. Vào tab **Import**.
5. Chọn file `chat (2).sql`.
6. Bấm **Import**.

### Tài khoản đăng nhập thử

Theo file SQL bạn cung cấp, các tài khoản mẫu đang dùng mật khẩu chung là `123`.

| MSSV | Mật khẩu | Ghi chú |
|---|---|---|
| `65131861` | `123` | Tài khoản chính trong dữ liệu mẫu |
| `65130003` | `123` | Sinh viên khoa CNTT, lớp CNTT2 |
| `65130004` | `123` | Sinh viên khoa QTKD, lớp QTKD1 |
| `65130005` | `123` | Sinh viên khoa KT, lớp KT1 |
| `65130073` | `123` | Sinh viên khoa DL, lớp DL2 |

### Ghi chú về dump SQL

- File dump có một số dữ liệu lịch sử được tạo trong quá trình test, ví dụ tin nhắn rỗng, phòng cũ hoặc file upload cũ.
- Logic hiện tại của ứng dụng sử dụng các loại phòng chính: `KHOA`, `LOP`, `PRIVATE`.
- Trong dump có thể còn bản ghi legacy như `GROUP`; các bản ghi này không ảnh hưởng tới luồng chính hiện tại nếu ứng dụng không truy vấn tới chúng.
- Một số bản ghi `chat_room` cũ có `ma_khoa` hoặc `ma_lop` rỗng/null. Khi người dùng đăng nhập, ứng dụng vẫn có cơ chế tự tìm hoặc tạo phòng Khoa/Lớp đúng theo thông tin `sinh_vien.ma_khoa` và `sinh_vien.ma_lop`.
- Nếu muốn dữ liệu sạch hơn, có thể giữ lại bảng `khoa`, `lop`, `sinh_vien` và để ứng dụng tự tạo lại các phòng chat khi truy cập `/home`.

---

## Upload File

### Quy tắc upload

| Thuộc tính | Giá trị |
|---|---|
| Thư mục lưu | `uploads/` |
| URL public | `/uploads/{fileName}` |
| Dung lượng tối đa | 10MB |
| Định dạng hỗ trợ | `jpg`, `jpeg`, `png`, `pdf`, `docx`, `zip` |
| File ảnh | Hiển thị trực tiếp trong chat |
| File khác | Hiển thị dạng thẻ tải xuống |

### Content type được chấp nhận

- `image/jpeg`
- `image/png`
- `application/pdf`
- `application/vnd.openxmlformats-officedocument.wordprocessingml.document`
- `application/zip`
- `application/x-zip-compressed`

Lưu ý: file SQL dump có thể chứa một vài bản ghi upload cũ như `.mp3` hoặc `.exe` do dữ liệu được tạo trong quá trình thử nghiệm trước đó. Phiên bản code hiện tại chỉ cho upload các định dạng trong danh sách phía trên.

---

## Giao Diện

Ứng dụng gồm 4 màn hình Thymeleaf chính:

### Trang đăng nhập - `login.html`

- Giao diện tối màu.
- Form nhập MSSV và mật khẩu.
- Hiển thị lỗi khi đăng nhập sai.

### Trang chủ - `home.html`

- Sidebar thông tin sinh viên.
- Danh sách phòng Khoa, phòng Lớp.
- Danh sách chat riêng.
- Badge tin nhắn chưa đọc.
- Trạng thái online/offline của bạn bè.

### Trang kết bạn - `friends.html`

- Gửi lời mời kết bạn bằng MSSV.
- Danh sách lời mời đang chờ.
- Chấp nhận hoặc từ chối lời mời.
- Nhận lời mời realtime bằng WebSocket.

### Trang phòng chat - `room.html`

- Danh sách tin nhắn.
- Gửi text realtime.
- Upload ảnh/file.
- Xem ảnh lớn bằng lightbox.
- Hiển thị trạng thái đã xem.
- Sidebar chuyển phòng nhanh.
- Toast thông báo khi có tin mới từ phòng khác.

---

## Kiểm Thử

Chạy test:

```bash
./gradlew.bat test
```

Hoặc trên macOS/Linux:

```bash
./gradlew test
```

Kiểm tra thủ công nên thực hiện:

1. Đăng nhập bằng hai tài khoản ở hai tab/trình duyệt khác nhau.
2. Kiểm tra phòng Khoa và phòng Lớp có tự tạo không.
3. Gửi tin nhắn text giữa hai tài khoản.
4. Gửi file ảnh dưới 10MB và kiểm tra ảnh hiển thị.
5. Gửi file không hợp lệ để kiểm tra lỗi upload.
6. Gửi lời mời kết bạn và xác nhận toast realtime.
7. Chấp nhận lời mời và kiểm tra phòng `PRIVATE`.
8. Kiểm tra trạng thái online/offline khi đóng tab hoặc logout.
9. Kiểm tra badge tin nhắn chưa đọc ở sidebar.
10. Kiểm tra trạng thái đã xem khi vào phòng.

---

## Ghi Chú Bảo Mật

Dự án hiện phù hợp cho môi trường học tập/demo. Nếu triển khai thật, cần nâng cấp các điểm sau:

- Mật khẩu đang lưu dạng plain text, nên chuyển sang BCrypt hoặc Argon2.
- `SecurityConfig` hiện `permitAll()` toàn bộ request; nên phân quyền route và bật lại CSRF cho form quan trọng.
- Upload file nên quét virus, kiểm tra MIME sâu hơn và giới hạn tên file/tải xuống chặt chẽ hơn.
- Endpoint chấp nhận/từ chối lời mời đang dùng `GET`; nên chuyển sang `POST`.
- Cần kiểm tra quyền upload theo room để chắc chắn người gửi thuộc phòng.
- Nên tách cấu hình database qua biến môi trường thay vì hard-code trong `application.properties`.
- Nên dùng HTTPS khi triển khai WebSocket ngoài production.

---

## Troubleshooting

### Không đăng nhập được

- Kiểm tra bảng `sinh_vien` đã có dữ liệu chưa.
- Kiểm tra đúng `mssv` và `password`.
- Kiểm tra tên cột trong MySQL do Hibernate tạo có khớp với câu SQL seed không.

### Không kết nối được MySQL

- Kiểm tra MySQL đang chạy.
- Kiểm tra database `chat` đã được tạo.
- Kiểm tra username/password trong `application.properties`.

### WebSocket không hoạt động

- Mở DevTools Console để xem lỗi SockJS/STOMP.
- Kiểm tra endpoint `/chat`.
- Kiểm tra app đang chạy đúng port `8080`.

### Upload thất bại

- Kiểm tra file dưới 10MB.
- Kiểm tra định dạng thuộc danh sách hỗ trợ.
- Kiểm tra thư mục `uploads/` có quyền ghi.

### Tin nhắn không lưu

- Kiểm tra bảng `message`.
- Kiểm tra `roomId` tồn tại.
- Kiểm tra user đang đăng nhập trong session.

---

## Hướng Phát Triển

- Thêm màn hình đăng ký và quản lý tài khoản sinh viên.
- Mã hóa mật khẩu bằng BCrypt.
- Bổ sung phân quyền Spring Security theo session/login.
- Thêm tìm kiếm sinh viên theo họ tên/MSSV trong giao diện kết bạn.
- Thêm xóa/sửa tin nhắn.
- Thêm gửi emoji, reaction và trả lời theo thread.
- Thêm phân trang hoặc lazy load lịch sử tin nhắn.
- Thêm avatar sinh viên.
- Thêm group chat tùy chỉnh ngoài phòng Khoa/Lớp.
- Thêm dashboard quản trị Khoa/Lớp/Sinh viên.
- Lưu file upload lên cloud storage thay vì thư mục local.
- Thêm Docker Compose cho MySQL và ứng dụng.
- Thêm CI để chạy test tự động.

---

## Tác Giả

Project: **DuAnTroChuyen / NTU CHAT**

Mục tiêu: xây dựng hệ thống trò chuyện realtime phục vụ sinh viên, có khả năng mở rộng thành nền tảng giao tiếp nội bộ trong môi trường học tập.
