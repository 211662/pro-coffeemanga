#!/bin/bash

# =====================================================
# Setup GitHub Auto-Deploy Webhook
# Chạy script này trên server để cài đặt webhook
# =====================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     Setup GitHub Webhook for Auto-Deploy                      ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Tạo webhook endpoint
WEBHOOK_DIR="/var/www/webhook"
WEBHOOK_FILE="$WEBHOOK_DIR/deploy.php"

mkdir -p $WEBHOOK_DIR

# Tạo file webhook PHP
cat > $WEBHOOK_FILE << 'EOF'
<?php
/**
 * GitHub Webhook - Auto Deploy
 * Khi có push lên GitHub, script này sẽ tự động deploy theme
 */

// Secret key để bảo mật (thay đổi giá trị này)
define('WEBHOOK_SECRET', 'your-secret-key-here');

// Log file
$logFile = '/var/log/github-webhook.log';

// Ghi log
function writeLog($message) {
    global $logFile;
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($logFile, "[$timestamp] $message\n", FILE_APPEND);
}

// Verify GitHub signature
function verifySignature($payload, $signature) {
    if (!$signature) {
        return false;
    }
    
    list($algo, $hash) = explode('=', $signature, 2);
    $payloadHash = hash_hmac($algo, $payload, WEBHOOK_SECRET);
    
    return hash_equals($hash, $payloadHash);
}

// Get POST data
$payload = file_get_contents('php://input');
$signature = $_SERVER['HTTP_X_HUB_SIGNATURE'] ?? '';

writeLog("Webhook received from " . ($_SERVER['REMOTE_ADDR'] ?? 'unknown'));

// Verify signature
if (!verifySignature($payload, $signature)) {
    writeLog("Invalid signature!");
    http_response_code(401);
    exit('Invalid signature');
}

// Parse payload
$data = json_decode($payload, true);

if (isset($data['ref']) && ($data['ref'] === 'refs/heads/main' || $data['ref'] === 'refs/heads/master')) {
    writeLog("Push detected on main/master branch. Starting deployment...");
    
    // Chạy script deploy
    $output = shell_exec('bash /root/auto-deploy-github.sh 2>&1');
    
    writeLog("Deployment output: $output");
    writeLog("Deployment completed!");
    
    echo "Deployment triggered successfully!";
} else {
    writeLog("Push on different branch, skipping deployment");
    echo "Not a main/master branch push, skipping";
}
?>
EOF

echo "✅ Webhook file created: $WEBHOOK_FILE"

# Set permissions
chown -R www-data:www-data $WEBHOOK_DIR
chmod 755 $WEBHOOK_DIR
chmod 644 $WEBHOOK_FILE

# Tạo log file
touch /var/log/github-webhook.log
chown www-data:www-data /var/log/github-webhook.log
chmod 644 /var/log/github-webhook.log

echo "✅ Log file created: /var/log/github-webhook.log"

# Tạo Nginx config cho webhook
NGINX_CONF="/etc/nginx/sites-available/webhook"

cat > $NGINX_CONF << 'EOF'
server {
    listen 8080;
    server_name _;
    
    root /var/www/webhook;
    index deploy.php;
    
    location / {
        try_files $uri $uri/ /deploy.php$is_args$args;
    }
    
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php-fpm.sock;
    }
    
    # Security
    location ~ /\.git {
        deny all;
    }
    
    access_log /var/log/nginx/webhook-access.log;
    error_log /var/log/nginx/webhook-error.log;
}
EOF

# Enable site
ln -sf $NGINX_CONF /etc/nginx/sites-enabled/webhook

# Test Nginx config
nginx -t

if [ $? -eq 0 ]; then
    systemctl reload nginx
    echo "✅ Nginx configured and reloaded"
else
    echo "❌ Nginx configuration error!"
    exit 1
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     ✅ WEBHOOK SETUP COMPLETED!                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📝 Next Steps:"
echo ""
echo "1. Go to your GitHub repository settings"
echo "2. Navigate to: Settings > Webhooks > Add webhook"
echo "3. Set Payload URL: http://159.223.88.90:8080/deploy.php"
echo "4. Content type: application/json"
echo "5. Secret: your-secret-key-here (update in $WEBHOOK_FILE)"
echo "6. Select: Just the push event"
echo "7. Click 'Add webhook'"
echo ""
echo "🔧 To view webhook logs:"
echo "   tail -f /var/log/github-webhook.log"
echo ""
echo "🧪 To test manually:"
echo "   curl -X POST http://159.223.88.90:8080/deploy.php"
echo ""
