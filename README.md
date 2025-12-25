# 🎯 RoliaScan - WordPress Theme

Clone của CoffeeManga với branding RoliaScan, tự động deploy từ GitHub.

## 🚀 Quick Start

**Workflow đơn giản:**
1. Sửa code → Commit → Push
2. GitHub Webhook tự động deploy lên production
3. Done! ✨

### Setup Webhook (1 lần):
1. Vào: https://github.com/211662/pro-coffeemanga/settings/hooks
2. Add webhook với URL: `http://159.223.88.90:8080/deploy.php`
3. Secret: `roliascan-secret-2025`
4. Content type: `application/json`

Chi tiết: [AUTO-DEPLOY-DONE.md](AUTO-DEPLOY-DONE.md)

---

## 📦 Nội dung

- **WordPress Theme**: `wp-content/themes/roliascan/`
- **Custom Post Type**: Manga
- **Custom Taxonomy**: Genre
- **Responsive Design**: Mobile-first approach
- **Color Scheme**: Coffee/Brown theme (#6F4E37, #8B4513, #D2691E)

---

## 🌐 Live Site

- **URL**: http://159.223.88.90
- **Admin**: http://159.223.88.90/wp-admin
- **User**: admin
- **Pass**: RoliaScan@Admin2025!

---

## �️ Manual Deploy (nếu cần)

```bash
./quick-deploy.sh
```

---

## 📊 Logs & Monitoring

```bash
# Webhook logs
ssh root@159.223.88.90 "tail -f /var/log/github-webhook.log"

# Deployment logs  
ssh root@159.223.88.90 "tail -f /var/log/deploy-output.log"
```

---

## 🎨 Theme Structure

```
roliascan/
├── style.css                 # Theme header
├── functions.php            # Theme functions & CPT
├── header.php               # Site header
├── footer.php               # Site footer
├── front-page.php           # Homepage
├── single-manga.php         # Single manga page
├── archive-manga.php        # Manga archive
├── page.php                 # Default page template
├── template-about.php       # About page
├── template-contact.php     # Contact page
├── template-privacy.php     # Privacy policy
├── template-terms.php       # Terms of service
└── assets/
    ├── css/
    │   ├── main.css         # Main stylesheet (Coffee colors)
    │   └── additional.css   # Additional styles
    └── js/
        └── main.js          # JavaScript
```

---

## 🎨 Color Palette

```css
--primary-color: #6F4E37      /* Coffee brown */
--secondary-color: #8B4513    /* Saddle brown */
--accent-color: #D2691E       /* Chocolate */
--highlight-color: #CD853F    /* Peru */
--bg-light: #FFFAF0           /* Floral white */
--text-dark: #3E2723          /* Brown text */
```

---

## 📚 Documentation

- [Hướng dẫn Deploy](GITHUB-DEPLOY.md)
- [Installation Guide](README.md)
- [Hướng dẫn tiếng Việt](HUONG-DAN-CAI-DAT.md)

---

## ✅ Đã hoàn thành

- ✅ Theme structure với 16 files
- ✅ Custom Post Type: Manga
- ✅ Custom Taxonomy: Genre
- ✅ Responsive CSS với coffee theme
- ✅ JavaScript functionality
- ✅ Deploy scripts (quick-deploy.sh)
- ✅ GitHub webhook setup (setup-webhook.sh)
- ✅ Auto-deploy từ GitHub (auto-deploy-github.sh)
- ✅ 8 manga mẫu đã tạo

---

## � Scripts

| Script | Mục đích |
|--------|----------|
| `quick-deploy.sh` | Deploy thủ công nhanh (SCP) |
| `auto-deploy-github.sh` | Script chạy trên server để pull từ GitHub |
| `setup-webhook-apache.sh` | Setup webhook lần đầu trên server |
| `deploy.sh` | Deploy script đầy đủ với auto-detect |

---

## 📞 Troubleshooting

**Webhook không hoạt động?**
```bash
# Check webhook logs
ssh root@159.223.88.90 "tail -50 /var/log/github-webhook.log"

# Test webhook manually
curl -X POST -H "Content-Type: application/json" \
  -d '{"ref":"refs/heads/main"}' \
  http://159.223.88.90:8080/deploy.php
```

**Deploy thủ công:**
```bash
ssh root@159.223.88.90 "bash /root/auto-deploy-github.sh"
```

---

## ⚠️ Security

**QUAN TRỌNG**: Đổi mật khẩu server ngay!

```bash
ssh root@159.223.88.90
passwd
```

---

## 📄 License

WordPress Theme for RoliaScan project.
