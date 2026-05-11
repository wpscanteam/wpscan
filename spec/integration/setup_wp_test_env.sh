#!/usr/bin/env bash
#
# Sets up a local WordPress install via DDEV that exercises as many of WPScan's
# detection paths as is reasonable. Used by the GitHub Actions integration test
# (.github/workflows/build.yml) and runnable locally to spin up a "demo site"
# for manual WPScan exploration — see https://github.com/wpscanteam/wpscan/issues/807.
#
# Usage (local):
#   mkdir wordpress-test && cd wordpress-test
#   bash /path/to/wpscan/spec/integration/setup_wp_test_env.sh
#   # then point wpscan at https://wordpress-test.ddev.site
#
# Prerequisites: ddev, wp-cli (provided inside the ddev container), and a working
# Docker runtime. The script must be run from an empty directory that will become
# the DDEV project root.

set -euo pipefail

# Configure and start DDEV
ddev config --project-type=wordpress --php-version=8.1 --docroot=wordpress

# Disable PHP's display_errors. The pinned-vulnerable plugin versions (notably WooCommerce
# 4.6.1) trigger deprecation warnings on PHP 8.1; when display_errors is on, those warnings
# print to output BEFORE wp-signup.php's wp_redirect() runs, which corrupts the redirect.
# That in turn makes the Multisite finder false-fire and the Registration finder look at the
# wrong URL. Turning display_errors off keeps the responses clean and the finders happy.
mkdir -p .ddev/php
cat > .ddev/php/no-display-errors.ini <<'EOF'
[PHP]
display_errors = Off
EOF

ddev start

# Install WordPress
ddev exec wp core download --path=wordpress
ddev exec wp core install \
  --path=wordpress \
  --url=https://wordpress-test.ddev.site \
  --title="WPScan Integration Test" \
  --admin_user=admin \
  --admin_password=password \
  --admin_email=test@example.com \
  --skip-email

# DDEV's WordPress project type defaults WP_DEBUG=1, which makes WordPress force
# ini_set('display_errors', 1) at runtime — overriding our php.ini override and
# letting old-plugin deprecation warnings (notably WooCommerce 4.6.1 on PHP 8.1)
# spill into responses, breaking redirects (e.g. wp-signup.php → registration page).
# Turn it off so the test environment behaves like a clean install.
ddev exec wp config set WP_DEBUG false --raw --path=wordpress
ddev exec wp config set WP_DEBUG_DISPLAY false --raw --path=wordpress

# Create additional non-admin users so user enumeration has more than just `admin` to find
ddev exec wp user create editor1 editor1@example.com --role=editor --user_pass='editor-pass-123' --path=wordpress
ddev exec wp user create author1 author1@example.com --role=author --user_pass='author-pass-123' --path=wordpress

# Install vulnerable plugins and theme LAST. Old plugin versions (especially WooCommerce 4.6.1)
# emit deprecation warnings on modern PHP, which wp-cli then prints on every subsequent
# WP-loading command. Doing this last keeps the rest of the setup output readable and fast.
ddev exec wp plugin install contact-form-7 --version=5.3.2 --activate --path=wordpress 2>/dev/null
ddev exec wp plugin install woocommerce --version=4.6.1 --activate --path=wordpress 2>/dev/null
ddev exec wp plugin install wordpress-seo --version=15.5 --activate --path=wordpress 2>/dev/null
ddev exec wp theme install twentynineteen --version=1.8 --activate --path=wordpress 2>/dev/null

# Enable user registration AFTER plugin activation. Some plugins (notably WooCommerce) touch
# user-registration settings during activation, so setting this last is the only way to ensure
# users_can_register stays at 1 — required for the Registration interesting-finding to fire
# (wp-login.php?action=register must render the #registerform).
ddev exec wp option update users_can_register 1 --path=wordpress

# Drop files / dirs that trigger WPScan's "interesting findings" / config-backup / db-export /
# timthumb / upload-sql-dump / backup-db / mu-plugins / fantastico / search-replace-db /
# duplicator-installer / emergency-pwd-reset finders. Each path matches what the corresponding
# finder under app/finders/ probes.
#
# Content matters: each finder validates the response body, not just the path. Patterns used below
# mirror what the corresponding finder expects (e.g. ConfigBackups requires /define/i + no <html,
# DbExports/UploadSQLDump require SQL DDL keywords, Timthumbs requires HTTP 400 + "no image specified",
# FantasticoFileslist requires a non-empty text/plain body).
echo "<?php define('DB_NAME','wordpress'); define('DB_USER','root');" > wordpress/wp-config.bak
echo 'CREATE TABLE foo (id INT); INSERT INTO foo VALUES (1);' > wordpress/backup.sql
echo 'PHP Notice: simulated debug entry' > wordpress/wp-content/debug.log
# Real timthumb.php returns HTTP 400 + "no image specified" when called without query args
echo '<?php http_response_code(400); echo "no image specified";' > wordpress/timthumb.php
# DuplicatorInstallerLog expects body to match /DUPLICATOR(-|\s)?(PRO|LITE)?:? INSTALL-LOG/i
echo 'DUPLICATOR-LITE: INSTALL-LOG' > wordpress/installer-log.txt
echo '<?php echo "emergency password reset script";' > wordpress/emergency.php
# SearchReplaceDB2 expects body to match /by interconnect/i (signature of the real tool)
echo '<?php echo "Search Replace DB by interconnect/it";' > wordpress/searchreplacedb2.php
echo 'fantastico fileslist' > wordpress/fantastico_fileslist.txt
mkdir -p wordpress/wp-content/uploads
echo 'CREATE TABLE bar (id INT); INSERT INTO bar VALUES (1);' > wordpress/wp-content/uploads/dump.sql
mkdir -p wordpress/wp-content/backup-db
echo 'backup-db dir' > wordpress/wp-content/backup-db/index.html
mkdir -p wordpress/wp-content/mu-plugins
echo '<?php /* mu-plugin */' > wordpress/wp-content/mu-plugins/test.php
echo 'mu-plugins dir' > wordpress/wp-content/mu-plugins/index.html

# Verify site returns HTTP 200 (will exit non-zero on 4xx/5xx errors)
curl -k -f -s -o /dev/null -w "WordPress responding: HTTP %{http_code}\n" https://wordpress-test.ddev.site
