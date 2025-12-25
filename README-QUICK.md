# 🎯 RoliaScan - WordPress Theme

Clone của CoffeeManga với branding RoliaScan.

## 🚀 Quick Start

### Deploy nhanh nhất (sau khi push lên GitHub):
```bash
./quick-deploy.sh
```

### Hoặc setup auto-deploy 1 lần:
Xem hướng dẫn chi tiết trong [GITHUB-DEPLOY.md](GITHUB-DEPLOY.md)

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

## 📝 Development Workflow

1. **Sửa code** trong `wp-content/themes/roliascan/`
2. **Commit** bằng GitHub Desktop
3. **Push** lên GitHub
4. **Deploy**:
   - Tự động: Nếu đã setup webhook
   - Thủ công: Chạy `./quick-deploy.sh`

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

## 🔧 Scripts

| Script | Mô tả |
|--------|-------|
| `quick-deploy.sh` | Deploy nhanh bằng SCP |
| `auto-deploy-github.sh` | Pull từ GitHub và deploy |
| `setup-webhook.sh` | Setup GitHub webhook tự động |
| `deploy.sh` | Deploy với WordPress detection |

---

## 📞 Support

Nếu có vấn đề:

1. Check logs: `ssh root@159.223.88.90 "tail -f /var/log/github-webhook.log"`
2. Clear cache: `ssh root@159.223.88.90 "cd /var/www/wordpress && sudo -u www-data wp cache flush"`
3. Xem [GITHUB-DEPLOY.md](GITHUB-DEPLOY.md) phần Troubleshooting

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
