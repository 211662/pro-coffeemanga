# 🚨 WordPress Chưa Được Cài Đặt Trên Server

## Tình Trạng Hiện Tại

✅ **Đã hoàn thành:**
- Theme RoliaScan đã được tạo
- File ZIP đã upload lên server: `/tmp/roliascan.zip`

❌ **Vấn đề:**
- Server `188.166.186.247` chưa có WordPress được cài đặt
- Không tìm thấy `/var/www/` directory
- Không có web server (nginx/apache) đang chạy

---

## 🔧 Giải Pháp: Cài Đặt WordPress Trước

### Option 1: Cài Đặt WordPress Thủ Công (Khuyến Nghị)

#### Bước 1: SSH vào server
```bash
ssh root@188.166.186.247
# Password: -g*mw2t&YYfz.eD
```

#### Bước 2: Cài đặt LEMP Stack (Linux, Nginx, MySQL, PHP)

```bash
# Update system
apt update && apt upgrade -y

# Install Nginx
apt install nginx -y
systemctl start nginx
systemctl enable nginx

# Install MySQL
apt install mysql-server -y
mysql_secure_installation

# Install PHP
apt install php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y

# Restart services
systemctl restart nginx
systemctl restart php8.1-fpm  # hoặc php8.2-fpm tùy version
```

#### Bước 3: Tạo Database cho WordPress

```bash
mysql -u root -p

# Trong MySQL prompt:
CREATE DATABASE roliascan_db;
CREATE USER 'roliascan_user'@'localhost' IDENTIFIED BY 'your-strong-password';
GRANT ALL PRIVILEGES ON roliascan_db.* TO 'roliascan_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

#### Bước 4: Download và cài đặt WordPress

```bash
# Tạo thư mục web root
mkdir -p /var/www/html

# Download WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

# Move WordPress files
cp -r wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
```

#### Bước 5: Cấu hình Nginx cho WordPress

```bash
nano /etc/nginx/sites-available/roliascan

# Paste nội dung sau:
```

```nginx
server {
    listen 80;
    server_name 188.166.186.247;
    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

```bash
# Enable site
ln -s /etc/nginx/sites-available/roliascan /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

# Test và restart nginx
nginx -t
systemctl restart nginx
```

#### Bước 6: Hoàn tất cài đặt WordPress

1. Mở trình duyệt: `http://188.166.186.247`
2. Chọn ngôn ngữ và click Continue
3. Nhập thông tin database:
   - Database Name: `roliascan_db`
   - Username: `roliascan_user`
   - Password: `your-strong-password`
   - Database Host: `localhost`
   - Table Prefix: `wp_`
4. Click Submit và Run Installation
5. Điền thông tin site:
   - Site Title: RoliaScan
   - Username: admin
   - Password: (tạo password mạnh)
   - Email: your-email@domain.com
6. Click Install WordPress

#### Bước 7: Cài đặt Theme RoliaScan

```bash
# Theme đã có sẵn tại /tmp/roliascan.zip
cd /var/www/html/wp-content/themes/
unzip /tmp/roliascan.zip
chown -R www-data:www-data roliascan
find roliascan -type d -exec chmod 755 {} \;
find roliascan -type f -exec chmod 644 {} \;
rm /tmp/roliascan.zip
```

#### Bước 8: Kích hoạt theme

1. Login vào WordPress: `http://188.166.186.247/wp-admin`
2. Vào Appearance > Themes
3. Activate theme RoliaScan

---

### Option 2: Sử Dụng Script Tự Động

Tôi có thể tạo script tự động cài đặt toàn bộ. Bạn có muốn không?

---

### Option 3: Sử Dụng Control Panel

Nếu server có cPanel, Plesk, hoặc DirectAdmin:
1. Login vào control panel
2. Sử dụng WordPress Auto Installer
3. Sau khi WordPress cài xong, upload theme qua admin

---

## 🔒 Bảo Mật Sau Khi Cài

```bash
# Đổi password root
passwd

# Setup firewall
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

# Disable root login (sau khi tạo user mới)
adduser deploy
usermod -aG sudo deploy
nano /etc/ssh/sshd_config
# PermitRootLogin no
systemctl restart sshd
```

---

## 📞 Cần Hỗ Trợ?

Bạn muốn tôi:
1. ✅ Tạo script cài đặt tự động toàn bộ?
2. ✅ Hướng dẫn chi tiết từng bước?
3. ✅ Deploy theme sau khi WordPress đã sẵn?

Cho tôi biết bạn chọn option nào! 🚀
