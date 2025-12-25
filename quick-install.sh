#!/bin/bash

###############################################################################
# RoliaScan - Quick WordPress Installation (No System Update)
###############################################################################

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     RoliaScan - Quick WordPress Installation                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Configuration
DB_NAME="roliascan_db"
DB_USER="roliascan_user"
DB_PASS="RoliaScan@2025!Secure"
WP_ADMIN_USER="admin"
WP_ADMIN_PASS="RoliaScan@Admin2025!"
WP_ADMIN_EMAIL="admin@roliascan.com"
DOMAIN_OR_IP="188.166.186.247"

echo "📋 Configuration:"
echo "   Database: $DB_NAME"
echo "   Domain/IP: $DOMAIN_OR_IP"
echo ""

# Step 1: Install Nginx
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🌐 Installing Nginx..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
apt install nginx -y
systemctl start nginx
systemctl enable nginx
echo "✅ Nginx installed"

# Step 2: Install MySQL
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🗄️  Installing MySQL..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
apt install mysql-server -y
systemctl start mysql
systemctl enable mysql
echo "✅ MySQL installed"

# Step 3: Install PHP
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🐘 Installing PHP..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
apt install php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip unzip wget curl -y
PHP_VERSION=$(php -v | head -n 1 | cut -d ' ' -f 2 | cut -d '.' -f 1,2)
echo "✅ PHP $PHP_VERSION installed"

# Step 4: Configure MySQL
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 Configuring MySQL..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;" 2>/dev/null || true
mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';" 2>/dev/null || true
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';" 2>/dev/null || true
mysql -e "FLUSH PRIVILEGES;" 2>/dev/null || true
echo "✅ Database configured"

# Step 5: Download WordPress
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📥 Downloading WordPress..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cd /tmp
rm -rf wordpress latest.tar.gz
wget -q https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
echo "✅ WordPress downloaded"

# Step 6: Setup WordPress
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📁 Setting up WordPress..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
mkdir -p /var/www/html
rm -rf /var/www/html/*
cp -r wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Create wp-config.php
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASS/" /var/www/html/wp-config.php

# Add security keys
SALT=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
STRING='put your unique phrase here'
printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s /var/www/html/wp-config.php 2>/dev/null || true

echo "✅ WordPress configured"

# Step 7: Configure Nginx
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚙️  Configuring Nginx..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

cat > /etc/nginx/sites-available/roliascan << EOF
server {
    listen 80;
    server_name $DOMAIN_OR_IP;
    root /var/www/html;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php$PHP_VERSION-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/roliascan /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx
systemctl restart php$PHP_VERSION-fpm

echo "✅ Nginx configured"

# Step 8: Install WP-CLI
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 Installing WP-CLI..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
echo "✅ WP-CLI installed"

# Step 9: Complete WordPress installation
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Completing WordPress installation..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cd /var/www/html
sudo -u www-data wp core install \
    --url="http://$DOMAIN_OR_IP" \
    --title="RoliaScan" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASS" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email

echo "✅ WordPress installed"

# Step 10: Install theme
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎨 Installing RoliaScan theme..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -f "/tmp/roliascan.zip" ]; then
    cd /var/www/html/wp-content/themes/
    unzip -q /tmp/roliascan.zip
    chown -R www-data:www-data roliascan
    find roliascan -type d -exec chmod 755 {} \;
    find roliascan -type f -exec chmod 644 {} \;
    
    cd /var/www/html
    sudo -u www-data wp theme activate roliascan
    
    echo "✅ Theme installed and activated"
else
    echo "⚠️  Theme not found"
fi

# Step 11: Configure WordPress
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚙️  Configuring WordPress..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cd /var/www/html
sudo -u www-data wp rewrite structure '/%postname%/'
sudo -u www-data wp option update timezone_string 'Asia/Ho_Chi_Minh'
echo "✅ WordPress configured"

# Cleanup
echo ""
echo "🧹 Cleaning up..."
cd /tmp
rm -rf wordpress latest.tar.gz
echo "✅ Cleanup completed"

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║              🎉 Installation Complete!                         ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "🌐 Website:  http://$DOMAIN_OR_IP"
echo "🔐 Admin:    http://$DOMAIN_OR_IP/wp-admin"
echo ""
echo "👤 Username: $WP_ADMIN_USER"
echo "🔑 Password: $WP_ADMIN_PASS"
echo ""
echo "🗄️  Database: $DB_NAME"
echo "👤 DB User:  $DB_USER"
echo "🔑 DB Pass:  $DB_PASS"
echo ""
echo "🎉 RoliaScan is live! 🚀"
echo ""
