#!/bin/bash
# Quick deployment commands - Copy and paste these into your SSH session

# 1. Find WordPress installation
echo "=== Finding WordPress installation ==="
WP_PATH=$(find /var/www /home /usr/share -name "wp-config.php" 2>/dev/null | head -1 | xargs dirname)
echo "WordPress found at: $WP_PATH"

# 2. Navigate to themes directory
cd $WP_PATH/wp-content/themes/

# 3. Backup existing theme if exists
if [ -d "roliascan" ]; then
    echo "=== Backing up existing theme ==="
    mv roliascan roliascan.backup.$(date +%Y%m%d_%H%M%S)
fi

# 4. Extract theme
echo "=== Extracting theme ==="
unzip -q /tmp/roliascan.zip
echo "Theme extracted successfully"

# 5. Set permissions
echo "=== Setting permissions ==="
chown -R www-data:www-data roliascan 2>/dev/null || \
chown -R nginx:nginx roliascan 2>/dev/null || \
chown -R apache:apache roliascan 2>/dev/null || \
echo "Note: Please set ownership manually"

find roliascan -type d -exec chmod 755 {} \;
find roliascan -type f -exec chmod 644 {} \;
echo "Permissions set successfully"

# 6. Verify installation
echo "=== Verifying installation ==="
ls -lh roliascan/ | head -15
echo ""
echo "=== Theme files count ==="
find roliascan -type f | wc -l
echo ""
echo "✅ Theme installed at: $WP_PATH/wp-content/themes/roliascan"

# 7. Clean up
rm -f /tmp/roliascan.zip
echo "✅ Cleanup completed"

echo ""
echo "🎉 Deployment completed!"
echo ""
echo "📝 Next steps:"
echo "1. Go to: http://188.166.186.247/wp-admin/"
echo "2. Navigate to: Appearance > Themes"
echo "3. Activate 'RoliaScan' theme"
echo ""
echo "⚠️  IMPORTANT: Change server password now!"
