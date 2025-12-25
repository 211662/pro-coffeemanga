#!/bin/bash

echo "================================================"
echo "   🚀 RoliaScan Theme - Manual Deployment      "
echo "================================================"
echo ""
echo "Theme đã được upload lên server thành công!"
echo "File location: /tmp/roliascan.zip"
echo ""
echo "Bây giờ bạn cần:"
echo ""
echo "1️⃣  Mở Terminal mới và SSH vào server:"
echo "    ssh root@188.166.186.247"
echo ""
echo "2️⃣  Nhập password: -g*mw2t&YYfz.eD"
echo ""
echo "3️⃣  Copy và paste các lệnh sau (từng dòng một):"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
cat << 'EOF'
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

EOF
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "4️⃣  Sau khi chạy xong các lệnh trên, mở trình duyệt:"
echo "    http://188.166.186.247/wp-admin/"
echo ""
echo "5️⃣  Đăng nhập WordPress và:"
echo "    - Vào Appearance > Themes"
echo "    - Tìm theme 'RoliaScan'"
echo "    - Click 'Activate'"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "⚠️  QUAN TRỌNG - BẢO MẬT:"
echo ""
echo "Sau khi deploy xong, PHẢI đổi mật khẩu server:"
echo "    ssh root@188.166.186.247"
echo "    passwd"
echo "    # Nhập mật khẩu mới"
echo ""
echo "================================================"
echo ""
