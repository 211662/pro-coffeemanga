# 🎯 RoliaScan - Quick Deploy Summary

## ✅ Đã Hoàn Thành

1. ✅ Theme đã được tạo hoàn chỉnh
2. ✅ Theme đã được nén thành ZIP
3. ✅ File ZIP đã upload lên server: `/tmp/roliascan.zip`

---

## 🚀 Các Bước Tiếp Theo

### Bước 1: SSH vào Server

Mở Terminal mới và chạy:

```bash
ssh root@188.166.186.247
```

**Password:** `-g*mw2t&YYfz.eD`

### Bước 2: Chạy Lệnh Cài Đặt

Copy và paste toàn bộ đoạn code sau vào terminal SSH:

```bash
# Tìm WordPress
WP_PATH=$(find /var/www /home /usr/share -name "wp-config.php" 2>/dev/null | head -1 | xargs dirname)
echo "WordPress found at: $WP_PATH"

# Đi đến thư mục themes
cd $WP_PATH/wp-content/themes/

# Backup theme cũ (nếu có)
[ -d "roliascan" ] && mv roliascan roliascan.backup.$(date +%Y%m%d_%H%M%S)

# Giải nén theme
unzip -q /tmp/roliascan.zip

# Set permissions
chown -R www-data:www-data roliascan 2>/dev/null || chown -R nginx:nginx roliascan 2>/dev/null
find roliascan -type d -exec chmod 755 {} \;
find roliascan -type f -exec chmod 644 {} \;

# Xóa file ZIP
rm /tmp/roliascan.zip

# Kiểm tra
echo "✅ Installation completed!"
ls -lh roliascan/ | head -15
```

### Bước 3: Kích Hoạt Theme

1. Mở trình duyệt: **http://188.166.186.247/wp-admin/**
2. Đăng nhập WordPress
3. Vào **Appearance > Themes**
4. Tìm theme **RoliaScan**
5. Click **Activate**

---

## 📋 Cấu Hình Theme (Sau Khi Activate)

### 1. Cài đặt Permalink
- Vào: **Settings > Permalinks**
- Chọn: **Post name**
- Save Changes

### 2. Tạo Menu
- Vào: **Appearance > Menus**
- Tạo menu: "Primary Menu" và "Footer Menu"

### 3. Tạo Các Trang
Tạo 4 trang với templates:
- **About Us** → Template: About Us
- **Contact Us** → Template: Contact Us
- **Privacy Policy** → Template: Privacy Policy
- **Terms and Conditions** → Template: Terms and Conditions

### 4. Upload Logo
- Vào: **Appearance > Customize**
- Upload logo của bạn

### 5. Thêm Manga
- Vào: **Manga > Add New**
- Thêm manga với ảnh và thông tin

### 6. Thêm Genres
- Vào: **Manga > Genres**
- Thêm: Romance, Fantasy, Action, Drama, Comedy, Isekai...

---

## ⚠️ BẢO MẬT - QUAN TRỌNG!

**PHẢI đổi mật khẩu server ngay sau khi deploy!**

```bash
ssh root@188.166.186.247
passwd
# Nhập mật khẩu mới 2 lần
```

### Tạo User Mới (Khuyến Nghị)

```bash
# Tạo user mới thay vì dùng root
adduser deploy
usermod -aG sudo deploy

# Disable root login
nano /etc/ssh/sshd_config
# Đổi: PermitRootLogin yes → PermitRootLogin no
systemctl restart sshd
```

### Cài Đặt Firewall

```bash
ufw allow 22
ufw allow 80
ufw allow 443
ufw enable
```

---

## 📁 Cấu Trúc Theme

```
roliascan/
├── style.css                 # Theme info
├── functions.php             # Theme functions
├── header.php               # Header
├── footer.php               # Footer
├── front-page.php           # Homepage
├── single-manga.php         # Single manga
├── archive-manga.php        # Manga archive
├── template-about.php       # About page
├── template-contact.php     # Contact page
├── template-privacy.php     # Privacy page
├── template-terms.php       # Terms page
└── assets/
    ├── css/
    │   ├── main.css
    │   └── additional.css
    ├── js/
    │   └── main.js
    └── images/
```

---

## 🔧 Plugin Khuyến Nghị

1. **Contact Form 7** - Form liên hệ
2. **Yoast SEO** - Tối ưu SEO
3. **WP Super Cache** - Tăng tốc
4. **Advanced Custom Fields** - Custom fields cho manga
5. **Akismet** - Chống spam

---

## 🐛 Troubleshooting

### Theme không hiện trong WordPress
```bash
# Kiểm tra permissions
ls -la /var/www/html/wp-content/themes/roliascan/
chmod 755 /var/www/html/wp-content/themes/roliascan/
```

### Lỗi 500
```bash
# Check error log
tail -f /var/log/nginx/error.log
# hoặc
tail -f /var/log/apache2/error.log
```

### WordPress không tìm thấy
```bash
# Tìm WordPress
find / -name "wp-config.php" 2>/dev/null
```

---

## 📞 Hỗ Trợ

- **README:** `/Users/linh/Desktop/github/pro-coffeemanga/README.md`
- **Hướng dẫn tiếng Việt:** `HUONG-DAN-CAI-DAT.md`
- **Deploy guide:** `DEPLOY-GUIDE.md`

---

## ✅ Checklist

- [ ] Theme đã upload lên server
- [ ] Theme đã giải nén
- [ ] Permissions đã được set
- [ ] Theme đã kích hoạt trong WordPress
- [ ] Permalink đã cài đặt
- [ ] Menu đã tạo
- [ ] Các trang static đã tạo
- [ ] Logo đã upload
- [ ] **Mật khẩu server đã đổi** ⚠️
- [ ] Firewall đã bật
- [ ] SSL certificate đã cài (optional)

---

**🎉 Chúc bạn deploy thành công!**
