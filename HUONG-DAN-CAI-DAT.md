# RoliaScan WordPress Theme - Installation Guide (Tiếng Việt)

## Hướng Dẫn Cài Đặt Chi Tiết

### 1. Yêu Cầu Hệ Thống

- WordPress phiên bản 5.0 trở lên
- PHP phiên bản 7.4 trở lên
- MySQL phiên bản 5.6 trở lên
- Hosting hỗ trợ WordPress

### 2. Cài Đặt Theme

#### Bước 1: Upload Theme

**Cách 1: Qua WordPress Admin**
1. Nén thư mục `roliascan` thành file ZIP
2. Đăng nhập vào WordPress Admin
3. Vào **Giao diện > Theme** (Appearance > Themes)
4. Nhấn **Thêm mới** > **Tải lên Theme**
5. Chọn file ZIP và nhấn **Cài đặt ngay**
6. Sau khi cài đặt xong, nhấn **Kích hoạt**

**Cách 2: Upload qua FTP**
1. Upload thư mục `roliascan` vào `/wp-content/themes/`
2. Đăng nhập WordPress Admin
3. Vào **Giao diện > Theme**
4. Tìm theme **RoliaScan** và nhấn **Kích hoạt**

### 3. Cấu Hình Cơ Bản

#### Bước 1: Cài đặt Permalink
1. Vào **Cài đặt > Đường dẫn tĩnh** (Settings > Permalinks)
2. Chọn **Tên bài viết** (Post name)
3. Nhấn **Lưu thay đổi**

#### Bước 2: Tùy chỉnh Theme
1. Vào **Giao diện > Tùy biến** (Appearance > Customize)
2. Upload logo của bạn
3. Đặt tiêu đề và slogan cho website
4. Tùy chỉnh màu sắc (nếu cần)

### 4. Tạo Menu

#### Menu Chính (Primary Menu)
1. Vào **Giao diện > Menu** (Appearance > Menus)
2. Tạo menu mới: "Menu Chính"
3. Thêm các trang/link vào menu:
   - Trang chủ (Home)
   - Tất cả Manga (All Manga)
   - Thể loại (Genres)
   - Về chúng tôi (About Us)
   - Liên hệ (Contact)
4. Chỉ định cho vị trí **Primary Menu**
5. Nhấn **Lưu menu**

#### Menu Footer
1. Tạo menu mới: "Menu Footer"
2. Thêm các trang:
   - HOME
   - ABOUT US
   - PRIVACY POLICY
   - TERMS CONDITIONS
   - CONTACT US
   - SITEMAP
3. Chỉ định cho vị trí **Footer Menu**
4. Nhấn **Lưu menu**

### 5. Tạo Các Trang Quan Trọng

#### Tạo Trang "Về Chúng Tôi" (About Us)
1. Vào **Trang > Thêm mới** (Pages > Add New)
2. Tiêu đề: "About Us" hoặc "Về Chúng Tôi"
3. Trong phần **Thuộc tính trang** (Page Attributes), chọn Template: **About Us**
4. Nhấn **Xuất bản** (Publish)

#### Tạo Trang "Liên Hệ" (Contact Us)
1. Vào **Trang > Thêm mới**
2. Tiêu đề: "Contact Us" hoặc "Liên Hệ"
3. Chọn Template: **Contact Us**
4. Nhấn **Xuất bản**

#### Tạo Trang "Chính Sách Bảo Mật" (Privacy Policy)
1. Vào **Trang > Thêm mới**
2. Tiêu đề: "Privacy Policy" hoặc "Chính Sách Bảo Mật"
3. Chọn Template: **Privacy Policy**
4. Nhấn **Xuất bản**

#### Tạo Trang "Điều Khoản & Điều Kiện" (Terms and Conditions)
1. Vào **Trang > Thêm mới**
2. Tiêu đề: "Terms and Conditions" hoặc "Điều Khoản Sử Dụng"
3. Chọn Template: **Terms and Conditions**
4. Nhấn **Xuất bản**

### 6. Thêm Manga

#### Tạo Manga Mới
1. Vào **Manga > Thêm mới** trong admin panel
2. Nhập tiêu đề manga
3. Thêm nội dung mô tả
4. Chọn **Ảnh đại diện** (Featured Image)
5. Chọn các **Thể loại** (Genres) phù hợp
6. Thêm thông tin tùy chỉnh (Custom Fields):
   - `manga_author`: Tên tác giả
   - `manga_status`: Trạng thái (Đang cập nhật/Hoàn thành)
7. Nhấn **Xuất bản**

### 7. Thêm Thể Loại Manga (Genres)

1. Vào **Manga > Genres**
2. Thêm các thể loại phổ biến:
   - Romance (Lãng mạn)
   - Fantasy (Giả tưởng)
   - Action (Hành động)
   - Drama (Chính kịch)
   - Comedy (Hài hước)
   - Isekai (Chuyển sinh)
   - Historical (Lịch sử)
   - Slice of Life (Đời thường)
   - School Life (Học đường)
   - Adventure (Phiêu lưu)

### 8. Tùy Chỉnh Màu Sắc

Để thay đổi màu sắc của theme, chỉnh sửa file `/assets/css/main.css`:

```css
:root {
    --primary-color: #1a1a2e;      /* Màu chính */
    --secondary-color: #16213e;     /* Màu phụ */
    --accent-color: #0f3460;        /* Màu nhấn */
    --highlight-color: #e94560;     /* Màu nổi bật (CTA) */
    --text-color: #eaeaea;          /* Màu chữ sáng */
    --text-dark: #333;              /* Màu chữ tối */
}
```

### 9. Plugin Khuyến Nghị

Cài đặt các plugin sau để tăng tính năng:

1. **Contact Form 7** - Form liên hệ nâng cao
2. **Yoast SEO** - Tối ưu SEO
3. **WP Super Cache** - Tăng tốc website
4. **Advanced Custom Fields (ACF)** - Thêm trường thông tin cho manga
5. **Akismet Anti-Spam** - Chống spam

### 10. Cấu Hình SEO Cơ Bản

1. Cài đặt plugin **Yoast SEO**
2. Vào **SEO > Cài đặt tổng quát**
3. Hoàn thiện thông tin website
4. Tối ưu tiêu đề và mô tả cho từng trang

### 11. Kiểm Tra Website

Sau khi cài đặt xong, kiểm tra:

- [ ] Trang chủ hiển thị đúng
- [ ] Menu hoạt động bình thường
- [ ] Các trang static hiển thị đúng template
- [ ] Manga hiển thị đầy đủ thông tin
- [ ] Thể loại hoạt động đúng
- [ ] Responsive trên mobile
- [ ] Tốc độ tải trang

### 12. Backup

Luôn backup website trước khi thay đổi:

1. Sử dụng plugin **UpdraftPlus** hoặc **BackWPup**
2. Backup định kỳ hàng tuần
3. Lưu trữ backup ở nơi an toàn

### Liên Hệ Hỗ Trợ

- Email: support@roliascan.com
- Website: https://www.roliascan.com/

### Ghi Chú Quan Trọng

- Theme này được tạo ra dựa trên cấu trúc của CoffeeManga
- Tất cả từ khóa "CoffeeManga" đã được thay thế bằng "RoliaScan"
- Theme hoàn toàn responsive và tối ưu cho mobile
- Hỗ trợ đầy đủ tính năng của WordPress

---

**Chúc bạn thành công với website RoliaScan!**
