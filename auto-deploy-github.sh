#!/bin/bash

# =====================================================
# RoliaScan - Auto Deploy from GitHub
# Usage: Chạy script này trên server để tự động pull từ GitHub
# =====================================================

# Cấu hình
REPO_URL="https://github.com/YOUR_USERNAME/pro-coffeemanga.git"  # ⚠️ THAY ĐỔI URL NÀY
REPO_DIR="/var/www/roliascan-repo"
THEME_DIR="/var/www/wordpress/wp-content/themes/roliascan"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     RoliaScan - Auto Deploy from GitHub                       ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Cài đặt Git nếu chưa có
if ! command -v git &> /dev/null; then
    echo "📦 Installing Git..."
    apt-get update -qq
    apt-get install -y git -qq
fi

# Clone repo lần đầu hoặc pull update
if [ ! -d "$REPO_DIR" ]; then
    echo "📥 Cloning repository..."
    git clone $REPO_URL $REPO_DIR
else
    echo "🔄 Pulling latest changes..."
    cd $REPO_DIR
    git pull origin main || git pull origin master
fi

if [ $? -ne 0 ]; then
    echo "❌ Failed to sync with GitHub!"
    exit 1
fi

echo "✅ Repository synced"

# Copy theme files
echo "📦 Copying theme files to WordPress..."
rm -rf $THEME_DIR
cp -r $REPO_DIR/wp-content/themes/roliascan $THEME_DIR

# Set permissions
echo "🔧 Setting permissions..."
chown -R www-data:www-data $THEME_DIR
find $THEME_DIR -type d -exec chmod 755 {} \;
find $THEME_DIR -type f -exec chmod 644 {} \;

# Clear WordPress cache
echo "🧹 Clearing WordPress cache..."
cd /var/www/wordpress
sudo -u www-data wp cache flush

echo ""
echo "✅ Theme deployed successfully from GitHub!"
echo "🌐 Visit: http://159.223.88.90"
echo ""
