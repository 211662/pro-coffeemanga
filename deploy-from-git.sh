#!/bin/bash

# =====================================================
# RoliaScan - Auto Deploy from Git
# =====================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     RoliaScan - Deploy Theme from Git                         ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Configuration
REPO_URL="YOUR_GITHUB_REPO_URL_HERE"  # Thay bằng URL repo của bạn
THEME_PATH="/var/www/wordpress/wp-content/themes/roliascan"
TEMP_DIR="/tmp/roliascan-deploy"

echo "📥 Cloning repository from Git..."
rm -rf $TEMP_DIR
git clone $REPO_URL $TEMP_DIR

if [ $? -ne 0 ]; then
    echo "❌ Failed to clone repository!"
    exit 1
fi

echo "📦 Copying theme files..."
rm -rf $THEME_PATH
cp -r $TEMP_DIR/wp-content/themes/roliascan $THEME_PATH

echo "🔧 Setting permissions..."
chown -R www-data:www-data $THEME_PATH

echo "🧹 Cleaning up..."
rm -rf $TEMP_DIR

echo ""
echo "✅ Theme deployed successfully!"
echo "🌐 Visit: http://159.223.88.90"
