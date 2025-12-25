# 🚀 Hướng Dẫn Deploy RoliaScan Theme

## ⚠️ CẢNH BÁO BẢO MẬT
**Server IP:** 188.166.186.247  
**QUAN TRỌNG:** Sau khi deploy xong, PHẢI đổi mật khẩu server ngay lập tức!

---

## Phương Án 1: Deploy Tự Động (Khuyến Nghị)

### Bước 1: Chạy script deploy

```bash
cd /Users/linh/Desktop/github/pro-coffeemanga
./deploy.sh
```

Nhập mật khẩu khi được yêu cầu: `-g*mw2t&YYfz.eD`

---

## Phương Án 2: Deploy Thủ Công

### Bước 1: Upload theme lên server

```bash
cd /Users/linh/Desktop/github/pro-coffeemanga/wp-content/themes

# Upload file ZIP
scp roliascan.zip root@188.166.186.247:/tmp/
```

### Bước 2: SSH vào server

```bash
ssh root@188.166.186.247
```

Mật khẩu: `-g*mw2t&YYfz.eD`

### Bước 3: Tìm WordPress trên server

```bash
# Tìm WordPress
find /var/www /home /usr/share -name "wp-config.php" 2>/dev/null | head -1

# Hoặc kiểm tra các vị trí phổ biến:
ls /var/www/html/
ls /var/www/wordpress/
ls /usr/share/nginx/html/
```

Giả sử WordPress ở: `/var/www/html`

### Bước 4: Giải nén theme

```bash
# Di chuyển đến thư mục themes
cd /var/www/html/wp-content/themes/

# Backup theme cũ nếu có
mv roliascan roliascan.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null

# Giải nén theme mới
unzip /tmp/roliascan.zip

# Set quyền đúng cho theme
chown -R www-data:www-data roliascan
# Hoặc nếu dùng nginx:
# chown -R nginx:nginx roliascan

# Set permissions
find roliascan -type d -exec chmod 755 {} \;
find roliascan -type f -exec chmod 644 {} \;

# Xóa file ZIP
rm /tmp/roliascan.zip

# Kiểm tra
ls -la roliascan/
```

### Bước 5: Kích hoạt theme

1. Mở trình duyệt: `http://188.166.186.247/wp-admin/`
2. Đăng nhập WordPress
3. Vào **Appearance > Themes** (Giao diện > Theme)
4. Tìm theme **RoliaScan**
5. Click **Activate** (Kích hoạt)

---

## Phương Án 3: Upload qua WordPress Admin

### Bước 1: Tải file ZIP

File đã được tạo tại:
```
/Users/linh/Desktop/github/pro-coffeemanga/wp-content/themes/roliascan.zip
```

### Bước 2: Upload qua WordPress

1. Đăng nhập: `http://188.166.186.247/wp-admin/`
2. Vào **Appearance > Themes** (Giao diện > Theme)
3. Click **Add New** > **Upload Theme**
4. Chọn file `roliascan.zip`
5. Click **Install Now**
6. Click **Activate**

---

## 🔧 Cấu Hình Sau Khi Deploy

### 1. Cài đặt Permalink
```
Settings > Permalinks > Chọn "Post name"
```

### 2. Tạo Menu
```
Appearance > Menus
- Tạo "Primary Menu" và "Footer Menu"
- Thêm các trang vào menu
```

### 3. Tạo các trang quan trọng

Tạo các trang với template tương ứng:
- **About Us** → Template: About Us
- **Contact Us** → Template: Contact Us  
- **Privacy Policy** → Template: Privacy Policy
- **Terms and Conditions** → Template: Terms and Conditions

### 4. Thêm Manga

```
Manga > Add New
- Thêm tiêu đề
- Thêm mô tả
- Upload ảnh đại diện
- Chọn thể loại
```

### 5. Thêm Genres

```
Manga > Genres
Thêm: Romance, Fantasy, Action, Drama, Comedy, Isekai, etc.
```

---

## 🔒 BẢO MẬT - QUAN TRỌNG!

### Đổi mật khẩu server NGAY

```bash
ssh root@188.166.186.247
passwd
# Nhập mật khẩu mới 2 lần
```

### Tạo user mới thay vì dùng root

```bash
# Tạo user mới
adduser deploy
usermod -aG sudo deploy

# Disable root login
nano /etc/ssh/sshd_config
# Đổi: PermitRootLogin yes → PermitRootLogin no
systemctl restart sshd
```

### Setup Firewall

```bash
ufw allow 22
ufw allow 80
ufw allow 443
ufw enable
```

---

## 🐛 Troubleshooting

### Lỗi permission denied
```bash
chmod 755 /var/www/html/wp-content/themes/roliascan
chown -R www-data:www-data /var/www/html/wp-content/themes/roliascan
```

### Theme không hiện trong WordPress
```bash
# Kiểm tra file style.css có đúng header không
cat /var/www/html/wp-content/themes/roliascan/style.css
```

### Lỗi 500 Internal Server Error
```bash
# Check PHP error log
tail -f /var/log/php-fpm/error.log
# hoặc
tail -f /var/log/apache2/error.log
```

---

## 📞 Hỗ Trợ

Nếu cần hỗ trợ, liên hệ:
- Email: support@roliascan.com

---

## ✅ Checklist Sau Deploy

- [ ] Theme đã được upload
- [ ] Theme đã được kích hoạt
- [ ] Permalink đã được cài đặt
- [ ] Menu đã được tạo
- [ ] Các trang static đã được tạo
- [ ] Logo đã được upload
- [ ] Mật khẩu server đã được đổi ⚠️
- [ ] Firewall đã được bật
- [ ] SSL certificate đã được cài (nếu cần)

---

**Chúc bạn deploy thành công! 🎉**
