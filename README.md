# 🚀 FitRoutine & Expense - Ứng Dụng Quản Lý Thói Quen & Chi Tiêu (Gamification)

> **Bài Tập Lớn Môn:** Phát triển Ứng dụng Di Động (Lập trình ĐTDĐ)  
> **Nhóm thực hiện:** GROUP 11  
> **Nền tảng mục tiêu:** Android (Chuyên biệt hóa môi trường Android)  
> **Ngôn ngữ thiết kế:** Google Material Design 3 ([`material_ui`](https://pub.dev/packages/material_ui) v1.3.0)  
> **Quản lý trạng thái:** Provider Pattern  

---

## 📖 1. Giới Thiệu Dự Án

**FitRoutine & Expense** là ứng dụng Android kết hợp giữa **Xây dựng thói quen tốt (Habit Tracker)** và **Quản lý tài chính cá nhân (Expense Tracker)**, áp dụng cơ chế **Gamification (Game hóa)**:
- Người dùng nhận điểm kinh nghiệm (**EXP**) và **Coins** khi hoàn thành các thói quen hàng ngày và ghi chép chi tiêu đầy đủ.
- Tăng cấp độ (**Level**) và nâng cấp trạng thái cho **Nhân vật ảo (Virtual Pet 🐱)**.
- Duy trì chuỗi ngày liên tiếp (**Streak flame**) để đạt các danh hiệu cao quý và huy hiệu danh dự.
- Biểu đồ phân tích tài chính và tỷ lệ kỷ luật trực quan giúp sinh viên kiểm soát lối sống lành mạnh.

### ✨ Điểm Nhấn Thiết Kế Google Material 3:
- Sử dụng gói thư viện chính thức **`package:material_ui`** của Google.
- Thanh điều hướng **Material 3 `NavigationBar`** với hiệu ứng Pill Indicator sinh động và icon chuyển đổi trạng thái (`outlined` / `filled`).
- Bảng màu hài hòa theo hệ thống **`ColorScheme.fromSeed`** Material 3 trên nền Dark Theme hiện đại kết hợp font chữ **Plus Jakarta Sans**.

---

## 👥 2. Danh Sách Thành Viên & Phân Chia Công Việc (GROUP 11)

| STT | Họ và Tên | MSSV | Vai Trò | Nhiệm Vụ Chính Trong Dự Án | Mục Tiêu |
| :---: | :--- | :---: | :---: | :--- | :---: |
| 1 | **Nguyễn Hồng Phúc** | **2351170611** | **Nhóm trưởng / System Architect** | - Khởi tạo kiến trúc dự án (Architecture), quản trị Git Repo & CI/CD.<br>- Lập trình hệ thống Gamification (Tính Level, EXP, Pet Avatar).<br>- Tích hợp Local Storage / Firebase & Review Code toàn nhóm. | **A** |
| 2 | **Lê Tuấn Khanh** | **2351170601** | **Core Feature Dev** | - Lập trình logic module **Thói quen (Habits)** (Check-in, tính streak).<br>- Lập trình logic module **Thu Chi (Expenses)** (Thêm giao dịch, tính số dư).<br>- Hỗ trợ tích hợp biểu đồ thống kê `fl_chart`. | **A** |
| 3 | **Đinh Thị Hoa** | **2351170593** | **UI/UX Designer & BA** | - Thiết kế toàn bộ bản vẽ giao diện Figma (Color palette, Component).<br>- Thu thập nội dung, danh mục chi tiêu và bộ thói quen mẫu.<br>- **Viết tài liệu Báo cáo đồ án môn học (Word/PDF)**: Use Case, SRS, Kiến trúc. | **B** |
| 4 | **PHẠM VŨ NGỌC BẢO** | **2251172249** | **QA Tester, Media & Thuyết trình** | - Thiết kế Slide báo cáo chuyên nghiệp ăn khớp giao diện app.<br>- Kiểm thử ứng dụng (Manual Testing), lập biên bản lỗi (Bug Report).<br>- Quay video demo giới thiệu app & **Thuyết trình chính buổi phản biện**. | **B** |
| 5 | **CHU HỮU ĐỆ** | **2251172273** | **Junior Dev & UI Coder** | - Xây dựng các màn hình giao diện tĩnh: **Profile, Thông tin nhóm, Settings**.<br>- Chuyển đổi các widget mẫu từ Figma sang mã nguồn Flutter.<br>- Chuẩn bị dữ liệu mẫu cho bài test demo của nhóm. | **B** |

---

## 🏗️ 3. Cấu Trúc Dự Án (Android Dedicated & Feature-First)

Dự án đã được tinh gọn **chuyên biệt cho nền tảng Android** (đã loại bỏ các thư mục nền tảng không liên quan như iOS, Web, Desktop) nhằm tối ưu dung lượng và quy trình build trên Android Studio:

```
fit_routine_expense/
├── android/                        # Cấu hình Native Android (Gradle, Manifest, Kotlin/Java)
├── lib/
│   ├── core/                       # Mã nguồn dùng chung (Phúc phụ trách)
│   │   ├── constants/              # Bảng màu (AppColors), kích thước, assets
│   │   ├── theme/                  # AppTheme (Chuẩn Google Material 3 Dark Theme)
│   │   └── utils/                  # Định dạng tiền tệ VND, thời gian (CurrencyFormatter)
│   ├── features/
│   │   ├── dashboard/              # Dashboard tổng quan & M3 NavigationBar
│   │   ├── gamification/           # [Phúc] Virtual Pet, Level up, EXP bar, Badges
│   │   ├── habits/                 # [Khanh & Phúc] Thói quen, Streak, Check-in
│   │   ├── expenses/               # [Khanh] Giao dịch thu/chi, danh mục, số dư
│   │   ├── stats/                  # [Bảo & Khanh] Biểu đồ FlChart phân tích
│   │   └── profile/                # [Đệ & Hoa] Cá nhân hóa, danh sách thành viên Nhóm 11
│   └── main.dart                   # Điểm khởi chạy MultiProvider với package:material_ui
├── test/
│   └── widget_test.dart            # Kiểm thử tự động (Smoke test)
├── pubspec.yaml                    # Quản lý dependencies (material_ui, provider, fl_chart...)
└── README.md
```

---

## 🛠️ 4. Hướng Dẫn Cài Đặt & Chạy Ứng Dụng Trên Android

### Yêu cầu tiên quyết:
- Flutter SDK `>= 3.47.0`
- Dart SDK `>= 3.13.0`
- Android Studio với Android SDK `>= API 21` (hoặc thiết bị Android vật lý bật USB Debugging)

### Các bước chạy:
1. Clone mã nguồn về máy:
   ```bash
   git clone https://github.com/LoudlyDawn2108/fit_routine_expense.git
   cd fit_routine_expense
   ```
2. Cài đặt các dependencies:
   ```bash
   flutter pub get
   ```
3. Chạy ứng dụng trên máy ảo Android (Emulator) hoặc thiết bị thật:
   ```bash
   flutter run -d android
   ```
4. Hoặc build file APK cài đặt:
   ```bash
   flutter build apk --debug
   ```

---

## 🌿 5. Quy Ước Làm Việc Với Git (Git Workflow)

- Nhánh chính: `main` (Chỉ nhóm trưởng Nguyễn Hồng Phúc merge sau khi review code).
- Tạo nhánh tính năng riêng cho từng bạn:
  - `feature/habits-crud` (Khanh)
  - `feature/expense-history` (Khanh)
  - `feature/profile-ui` (Đệ)
  - `feature/stats-chart` (Khanh / Bảo)
- Quy chuẩn commit message:
  - `feat: thêm chức năng mới`
  - `fix: sửa lỗi`
  - `docs: cập nhật tài liệu / README`
  - `style: chỉnh sửa UI / màu sắc`
