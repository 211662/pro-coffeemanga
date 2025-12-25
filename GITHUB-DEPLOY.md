# 🚀 Auto Deploy từ GitHub

## Cách 1: Deploy thủ công (Quick Deploy)

### Bước 1: Push code lên GitHub
```bash
# Sử dụng GitHub Desktop hoặc:
git add .
git commit -m "Update theme"
git push origin main
```

### Bước 2: Chạy script deploy
```bash
cd /Users/linh/Desktop/github/pro-coffeemanga
./quick-deploy.sh
```

---

## Cách 2: Auto Deploy với GitHub Webhook (Khuyên dùng)

### Setup lần đầu trên Server:

1. **Upload script lên server:**
```bash
scp auto-deploy-github.sh root@159.223.88.90:/root/
scp setup-webhook.sh root@159.223.88.90:/root/
```

2. **SSH vào server và chạy setup:**
```bash
ssh root@159.223.88.90
chmod +x /root/*.sh
bash /root/setup-webhook.sh
```

3. **Cập nhật GitHub repo URL:**
```bash
nano /root/auto-deploy-github.sh
# Sửa dòng: REPO_URL="https://github.com/YOUR_USERNAME/pro-coffeemanga.git"
```

### Setup GitHub Webhook:

1. Vào GitHub repo của bạn
2. **Settings** → **Webhooks** → **Add webhook**
3. Điền thông tin:
   - **Payload URL**: `http://159.223.88.90:8080/deploy.php`
   - **Content type**: `application/json`
   - **Secret**: `your-secret-key-here` (nhớ đổi trong file deploy.php)
   - **Which events**: Chọn "Just the push event"
4. Click **Add webhook**

### Sử dụng:

Sau khi setup xong, chỉ cần:

1. **Commit & Push lên GitHub** (bằng GitHub Desktop hoặc command line)
2. **Webhook tự động trigger** và deploy code lên server
3. **Xong!** ✅

### Xem logs:
```bash
ssh root@159.223.88.90
tail -f /var/log/github-webhook.log
```

---

## Cách 3: Deploy thủ công từ GitHub trên Server

```bash
ssh root@159.223.88.90
bash /root/auto-deploy-github.sh
```

---

## 📝 File Structure

```
pro-coffeemanga/
├── quick-deploy.sh              # Deploy nhanh bằng SCP
├── auto-deploy-github.sh        # Pull từ GitHub và deploy
├── setup-webhook.sh             # Setup webhook tự động
└── wp-content/
    └── themes/
        └── roliascan/           # Theme code
```

---

## 🔧 Troubleshooting

### Webhook không hoạt động?
```bash
# Check webhook logs
ssh root@159.223.88.90
tail -50 /var/log/github-webhook.log

# Check Nginx logs
tail -50 /var/log/nginx/webhook-error.log
```

### Deploy thủ công không được?
```bash
# Kiểm tra quyền truy cập SSH
ssh root@159.223.88.90 "whoami"

# Kiểm tra theme trên server
ssh root@159.223.88.90 "ls -la /var/www/wordpress/wp-content/themes/roliascan"
```

---

## ⚡ Quick Commands

```bash
# Deploy nhanh nhất
./quick-deploy.sh

# Xem logs webhook
ssh root@159.223.88.90 "tail -f /var/log/github-webhook.log"

# Deploy thủ công từ GitHub
ssh root@159.223.88.90 "bash /root/auto-deploy-github.sh"

# Clear cache WordPress
ssh root@159.223.88.90 "cd /var/www/wordpress && sudo -u www-data wp cache flush"
```

---

## 🌐 URLs

- **Website**: http://159.223.88.90
- **WordPress Admin**: http://159.223.88.90/wp-admin
- **Webhook Endpoint**: http://159.223.88.90:8080/deploy.php
