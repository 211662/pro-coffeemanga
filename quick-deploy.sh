#!/bin/bash

# Quick Deploy Script
# Sử dụng: ./quick-deploy.sh

SERVER="root@159.223.88.90"

echo "🚀 Quick Deploy RoliaScan Theme"
echo ""

# Create zip
cd wp-content/themes
rm -f roliascan.zip
zip -r roliascan.zip roliascan/ -q
echo "✅ Zipped theme"

# Upload
scp roliascan.zip $SERVER:/tmp/
echo "✅ Uploaded"

# Deploy
ssh $SERVER "cd /var/www/wordpress/wp-content/themes && rm -rf roliascan && unzip -o /tmp/roliascan.zip -q && chown -R www-data:www-data roliascan && cd /var/www/wordpress && sudo -u www-data wp cache flush"
echo "✅ Deployed"

echo ""
echo "🎉 Done! Visit: http://159.223.88.90"
