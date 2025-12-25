# ✅ GitHub Auto-Deploy đã SETUP XONG!

## 🎯 Workflow của bạn từ giờ:

### 1. Sửa code local
Sửa file bất kỳ trong theme (CSS, PHP, JS...)

### 2. Commit & Push lên GitHub
- Dùng **GitHub Desktop**: Commit → Push origin
- Hoặc terminal:
  ```bash
  git add .
  git commit -m "Update theme"
  git push
  ```

### 3. ✨ TỰ ĐỘNG DEPLOY!
- GitHub webhook tự động gọi server
- Server tự động pull code mới từ GitHub
- Server tự động copy vào WordPress
- Cache tự động được xóa
- **XONG!** Không cần làm gì thêm!

---

## 🔧 Setup GitHub Webhook (Làm 1 lần):

1. Vào: https://github.com/211662/pro-coffeemanga/settings/hooks
2. Click **"Add webhook"**
3. Điền thông tin:
   - **Payload URL**: `http://159.223.88.90:8080/deploy.php`
   - **Content type**: `application/json`
   - **Secret**: `roliascan-secret-2025`
   - **Which events**: ✓ Just the push event
   - **Active**: ✓ Checked
4. Click **"Add webhook"**

---

## 📊 Xem logs deployment:

```bash
# Xem log webhook (GitHub gọi vào)
ssh root@159.223.88.90 "tail -f /var/log/github-webhook.log"

# Xem log deployment (quá trình deploy)
ssh root@159.223.88.90 "tail -f /var/log/deploy-output.log"
```

---

## 🧪 Test thủ công:

```bash
# Trigger deployment thủ công
curl -X POST -H "Content-Type: application/json" \
  -d '{"ref":"refs/heads/main"}' \
  http://159.223.88.90:8080/deploy.php

# Hoặc deploy trực tiếp trên server
ssh root@159.223.88.90 "bash /root/auto-deploy-github.sh"
```

---

## 📝 Nếu webhook chưa setup:

Sau khi setup webhook trên GitHub (bước trên), mỗi lần bạn push code:

1. GitHub sẽ gửi POST request tới: `http://159.223.88.90:8080/deploy.php`
2. Server nhận được → chạy `/root/auto-deploy-github.sh`
3. Script pull code mới từ GitHub
4. Copy theme vào `/var/www/wordpress/wp-content/themes/roliascan`
5. Set permissions & clear cache
6. **Done!** ✅

---

## 🌐 URLs:

- **Website**: http://159.223.88.90
- **Admin**: http://159.223.88.90/wp-admin
- **Webhook**: http://159.223.88.90:8080/deploy.php
- **GitHub Repo**: https://github.com/211662/pro-coffeemanga

---

## 🚀 Ví dụ workflow thực tế:

```bash
# 1. Sửa CSS
vim wp-content/themes/roliascan/assets/css/main.css

# 2. Commit (hoặc dùng GitHub Desktop)
git add .
git commit -m "Update colors"

# 3. Push
git push

# 4. ✨ Chờ 3-5 giây → Website tự động update!
```

---

## ⚡ Status check:

```bash
# Kiểm tra webhook có hoạt động không
curl -I http://159.223.88.90:8080/deploy.php

# Xem log deployment gần nhất
ssh root@159.223.88.90 "tail -30 /var/log/github-webhook.log"
```

---

## 🎉 Hoàn thành!

Từ giờ bạn chỉ cần:
1. Code
2. Commit
3. Push
4. Done! ✨

**Không cần chạy script deploy nữa!**
