#!/bin/bash

# RoliaScan Theme Deployment Script
# Server: 159.223.88.90
# User: root

echo "🚀 Starting RoliaScan Theme Deployment..."

# Server details
SERVER_IP="159.223.88.90"
SERVER_USER="root"
LOCAL_THEME_PATH="/Users/linh/Desktop/github/pro-coffeemanga/wp-content/themes"
THEME_ZIP="roliascan.zip"

echo ""
echo "⚠️  SECURITY WARNING: After deployment, please change your server password immediately!"
echo ""

# Step 1: Check if ZIP file exists
if [ ! -f "$LOCAL_THEME_PATH/$THEME_ZIP" ]; then
    echo "❌ Theme ZIP file not found. Please run this command first:"
    echo "cd $LOCAL_THEME_PATH && zip -r roliascan.zip roliascan/"
    exit 1
fi

echo "✅ Theme ZIP file found"

# Step 2: Find WordPress installation on server
echo ""
echo "🔍 Step 1: Finding WordPress installation on server..."
echo "Please enter your server password when prompted:"
echo ""

WP_PATH=$(ssh ${SERVER_USER}@${SERVER_IP} "find /var/www /home /usr/share -name 'wp-config.php' -type f 2>/dev/null | head -1 | xargs dirname")

if [ -z "$WP_PATH" ]; then
    echo "❌ WordPress not found on server!"
    echo ""
    echo "Please manually specify WordPress path:"
    read -p "Enter WordPress root path (e.g., /var/www/html): " WP_PATH
fi

echo "✅ WordPress found at: $WP_PATH"

# Step 3: Upload theme
echo ""
echo "📤 Step 2: Uploading theme to server..."
echo "Uploading to: $WP_PATH/wp-content/themes/"
echo ""

scp "$LOCAL_THEME_PATH/$THEME_ZIP" ${SERVER_USER}@${SERVER_IP}:/tmp/

if [ $? -eq 0 ]; then
    echo "✅ Theme uploaded successfully"
else
    echo "❌ Upload failed!"
    exit 1
fi

# Step 4: Extract and setup on server
echo ""
echo "📦 Step 3: Extracting theme on server..."
echo ""

ssh ${SERVER_USER}@${SERVER_IP} << EOF
    # Navigate to themes directory
    cd $WP_PATH/wp-content/themes/
    
    # Backup existing theme if exists
    if [ -d "roliascan" ]; then
        echo "📋 Backing up existing theme..."
        mv roliascan roliascan.backup.\$(date +%Y%m%d_%H%M%S)
    fi
    
    # Extract new theme
    echo "📦 Extracting new theme..."
    unzip -q /tmp/$THEME_ZIP
    
    # Set proper permissions
    echo "🔒 Setting permissions..."
    chown -R www-data:www-data roliascan 2>/dev/null || chown -R nginx:nginx roliascan 2>/dev/null || chown -R apache:apache roliascan 2>/dev/null
    find roliascan -type d -exec chmod 755 {} \;
    find roliascan -type f -exec chmod 644 {} \;
    
    # Clean up
    rm /tmp/$THEME_ZIP
    
    echo "✅ Theme extracted and permissions set"
    
    # Display theme info
    echo ""
    echo "📊 Theme files:"
    ls -lh roliascan/ | head -10
EOF

echo ""
echo "🎉 Deployment completed!"
echo ""
echo "📝 Next Steps:"
echo "1. Go to your WordPress admin: http://${SERVER_IP}/wp-admin/"
echo "2. Navigate to: Appearance > Themes"
echo "3. Activate 'RoliaScan' theme"
echo "4. Follow the setup guide in README.md"
echo ""
echo "⚠️  IMPORTANT: Change your server password NOW!"
echo "Run: ssh root@${SERVER_IP} 'passwd'"
echo ""
