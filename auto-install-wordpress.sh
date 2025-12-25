#!/bin/bash

###############################################################################
# RoliaScan - Automatic WordPress + Theme Installation Script
# This script will install LEMP stack, WordPress, and RoliaScan theme
###############################################################################

set -e  # Exit on error

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║        RoliaScan - Automatic Installation Script              ║"
echo "║        WordPress + LEMP Stack + Theme                          ║"
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
echo "   DB User: $DB_USER"
echo "   Domain/IP: $DOMAIN_OR_IP"
echo ""

# Step 1: Update System
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 Step 1: Updating system..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
apt update -y
apt upgrade -y

# Step 2: Install Nginx
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🌐 Step 2: Installing Nginx..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
apt install nginx -y
systemctl start nginx
systemctl enable nginx
echo "✅ Nginx installed and started"

# Step 3: Install MySQL
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🗄️  Step 3: Installing MySQL..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
apt install mysql-server -y
systemctl start mysql
systemctl enable mysql
echo "✅ MySQL installed and started"

# Step 4: Install PHP
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🐘 Step 4: Installing PHP and extensions..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
apt install php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip unzip -y
PHP_VERSION=$(php -v | head -n 1 | cut -d ' ' -f 2 | cut -d '.' -f 1,2)
echo "✅ PHP $PHP_VERSION installed"

# Step 5: Configure MySQL Database
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 Step 5: Configuring MySQL database..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
echo "✅ Database created: $DB_NAME"

# Step 6: Download WordPress
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📥 Step 6: Downloading WordPress..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cd /tmp
rm -rf wordpress latest.tar.gz
wget -q https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
echo "✅ WordPress downloaded"

# Step 7: Setup WordPress files
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📁 Step 7: Setting up WordPress files..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
mkdir -p /var/www/html
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
printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s /var/www/html/wp-config.php

echo "✅ WordPress files configured"

# Step 8: Configure Nginx
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚙️  Step 8: Configuring Nginx..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

cat > /etc/nginx/sites-available/roliascan << EOF
server {
    listen 80;
    server_name $DOMAIN_OR_IP;
    root /var/www/html;
    index index.php index.html index.htm;

    access_log /var/log/nginx/roliascan_access.log;
    error_log /var/log/nginx/roliascan_error.log;

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

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
        expires max;
        log_not_found off;
    }
}
EOF

# Enable site
rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/roliascan /etc/nginx/sites-enabled/

# Test nginx config
nginx -t

# Restart services
systemctl restart nginx
systemctl restart php$PHP_VERSION-fpm

echo "✅ Nginx configured and restarted"

# Step 9: Install WP-CLI
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 Step 9: Installing WP-CLI..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
echo "✅ WP-CLI installed"

# Step 10: Complete WordPress installation via WP-CLI
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Step 10: Completing WordPress installation..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cd /var/www/html
sudo -u www-data wp core install \
    --url="http://$DOMAIN_OR_IP" \
    --title="RoliaScan" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASS" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email

echo "✅ WordPress installed successfully"

# Step 11: Install RoliaScan Theme
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎨 Step 11: Installing RoliaScan theme..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -f "/tmp/roliascan.zip" ]; then
    cd /var/www/html/wp-content/themes/
    unzip -q /tmp/roliascan.zip
    chown -R www-data:www-data roliascan
    find roliascan -type d -exec chmod 755 {} \;
    find roliascan -type f -exec chmod 644 {} \;
    
    # Activate theme via WP-CLI
    cd /var/www/html
    sudo -u www-data wp theme activate roliascan
    
    echo "✅ RoliaScan theme installed and activated"
else
    echo "⚠️  Theme file not found at /tmp/roliascan.zip"
    echo "   Please upload theme manually via WordPress admin"
fi

# Step 12: Configure WordPress settings
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚙️  Step 12: Configuring WordPress settings..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cd /var/www/html
sudo -u www-data wp rewrite structure '/%postname%/'
sudo -u www-data wp option update timezone_string 'Asia/Ho_Chi_Minh'
echo "✅ WordPress configured"

# Step 13: Setup firewall
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔒 Step 13: Configuring firewall..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
echo "y" | ufw enable
echo "✅ Firewall configured"

# Cleanup
echo ""
echo "🧹 Cleaning up..."
cd /tmp
rm -rf wordpress latest.tar.gz roliascan.zip
echo "✅ Cleanup completed"

# Print summary
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                  🎉 Installation Complete!                     ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📝 Installation Summary:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🌐 Website URL:       http://$DOMAIN_OR_IP"
echo "🔐 Admin URL:         http://$DOMAIN_OR_IP/wp-admin"
echo ""
echo "👤 Admin Username:    $WP_ADMIN_USER"
echo "🔑 Admin Password:    $WP_ADMIN_PASS"
echo ""
echo "🗄️  Database Name:     $DB_NAME"
echo "👤 Database User:     $DB_USER"
echo "🔑 Database Password: $DB_PASS"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo "1. Visit http://$DOMAIN_OR_IP to see your site"
echo "2. Login to admin panel"
echo "3. Create pages (About Us, Contact, etc.)"
echo "4. Add manga content"
echo "5. Configure theme settings"
echo ""
echo "⚠️  IMPORTANT SECURITY TASKS:"
echo "1. Change root password: passwd"
echo "2. Save the credentials above securely"
echo "3. Consider setting up SSL certificate"
echo "4. Create regular backups"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎉 RoliaScan is now live! Enjoy! 🚀"
echo ""
