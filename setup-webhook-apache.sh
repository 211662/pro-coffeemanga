#!/bin/bash

# =====================================================
# Setup GitHub Auto-Deploy Webhook (Apache Version)
# =====================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     Setup GitHub Webhook for Auto-Deploy (Apache)             ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Tạo webhook directory
WEBHOOK_DIR="/var/www/webhook"
WEBHOOK_FILE="$WEBHOOK_DIR/deploy.php"

mkdir -p $WEBHOOK_DIR

# Tạo file webhook PHP
cat > $WEBHOOK_FILE << 'EOFPHP'
<?php
/**
 * GitHub Webhook - Auto Deploy
 */

// Secret key (đổi nếu muốn bảo mật hơn)
define('WEBHOOK_SECRET', 'roliascan-secret-2025');

// Log file
$logFile = '/var/log/github-webhook.log';

function writeLog($message) {
    global $logFile;
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($logFile, "[$timestamp] $message\n", FILE_APPEND);
}

function verifySignature($payload, $signature) {
    if (!$signature) {
        return true; // Skip verification nếu không có secret
    }
    
    list($algo, $hash) = explode('=', $signature, 2);
    $payloadHash = hash_hmac($algo, $payload, WEBHOOK_SECRET);
    
    return hash_equals($hash, $payloadHash);
}

// Get POST data
$payload = file_get_contents('php://input');
$signature = $_SERVER['HTTP_X_HUB_SIGNATURE'] ?? '';

writeLog("=== Webhook received from " . ($_SERVER['REMOTE_ADDR'] ?? 'unknown') . " ===");

// Verify signature
if (!verifySignature($payload, $signature)) {
    writeLog("ERROR: Invalid signature!");
    http_response_code(401);
    exit('Invalid signature');
}

// Parse payload
$data = json_decode($payload, true);

if (json_last_error() !== JSON_ERROR_NONE) {
    writeLog("ERROR: Invalid JSON payload");
    http_response_code(400);
    exit('Invalid JSON');
}

// Check if this is a push to main/master
$ref = $data['ref'] ?? '';
writeLog("Push detected on branch: $ref");

if ($ref === 'refs/heads/main' || $ref === 'refs/heads/master') {
    writeLog("Starting deployment...");
    
    // Chạy script deploy trong background
    $command = 'bash /root/auto-deploy-github.sh > /var/log/deploy-output.log 2>&1 &';
    exec($command, $output, $returnCode);
    
    writeLog("Deployment triggered with command: $command");
    writeLog("Return code: $returnCode");
    
    echo json_encode([
        'status' => 'success',
        'message' => 'Deployment triggered',
        'timestamp' => date('c')
    ]);
} else {
    writeLog("Skipping - not a main/master branch push");
    echo json_encode([
        'status' => 'skipped',
        'message' => 'Not a main/master branch',
        'ref' => $ref
    ]);
}

writeLog("=== Request completed ===\n");
?>
EOFPHP

echo "✅ Webhook file created: $WEBHOOK_FILE"

# Set permissions
chown -R www-data:www-data $WEBHOOK_DIR
chmod 755 $WEBHOOK_DIR
chmod 644 $WEBHOOK_FILE

# Tạo log files
touch /var/log/github-webhook.log
touch /var/log/deploy-output.log
chown www-data:www-data /var/log/github-webhook.log
chown www-data:www-data /var/log/deploy-output.log
chmod 644 /var/log/github-webhook.log
chmod 644 /var/log/deploy-output.log

echo "✅ Log files created"

# Tạo Apache config cho webhook
APACHE_CONF="/etc/apache2/sites-available/webhook.conf"

cat > $APACHE_CONF << 'EOFAPACHE'
<VirtualHost *:8080>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/webhook
    
    <Directory /var/www/webhook>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    <FilesMatch \.php$>
        SetHandler "proxy:unix:/var/run/php/php-fpm.sock|fcgi://localhost"
    </FilesMatch>
    
    ErrorLog ${APACHE_LOG_DIR}/webhook-error.log
    CustomLog ${APACHE_LOG_DIR}/webhook-access.log combined
</VirtualHost>
EOFAPACHE

echo "✅ Apache config created: $APACHE_CONF"

# Enable port 8080
if ! grep -q "Listen 8080" /etc/apache2/ports.conf; then
    echo "Listen 8080" >> /etc/apache2/ports.conf
    echo "✅ Added port 8080 to Apache"
fi

# Enable site
a2ensite webhook.conf

# Enable required modules
a2enmod proxy_fcgi

# Test Apache config
apachectl configtest

if [ $? -eq 0 ]; then
    systemctl reload apache2
    echo "✅ Apache configured and reloaded"
else
    echo "❌ Apache configuration error!"
    exit 1
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     ✅ WEBHOOK SETUP COMPLETED!                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📝 Setup GitHub Webhook:"
echo ""
echo "1. Go to: https://github.com/YOUR_USERNAME/YOUR_REPO/settings/hooks"
echo "2. Click 'Add webhook'"
echo "3. Payload URL: http://159.223.88.90:8080/deploy.php"
echo "4. Content type: application/json"
echo "5. Secret: roliascan-secret-2025"
echo "6. Select: Just the push event"
echo "7. Active: ✓"
echo "8. Click 'Add webhook'"
echo ""
echo "🔧 View logs:"
echo "   tail -f /var/log/github-webhook.log"
echo "   tail -f /var/log/deploy-output.log"
echo ""
echo "🧪 Test webhook:"
echo "   curl -X POST http://159.223.88.90:8080/deploy.php"
echo ""
