#!/bin/bash
yum install -y httpd
amazon-linux-extras enable php7.2
amazon-linux-extras enable lamp-mariadb10.2-php7.2
yum install php-cli php-pdo php-fpm php-json php-mysqlnd mariadb php -y
wget https://ko.wordpress.org/latest-ko_KR.tar.gz
tar xvfz latest-ko_KR.tar.gz
cp -a wordpress/* /var/www/html
chown apache.apache /var/www/html/*
# sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/g' /etc/httpd/conf/httpd.conf
cd /var/www/html
cp wp-config-sample.php wp-config.php
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/admin/g' wp-config.php
sed -i 's/password_here/c6553443/g' wp-config.php
sed -i 's/localhost/database-1.cjrijddncjvm.ap-northeast-2.rds.amazonaws.com/g' wp-config.php
cat > /var/www/html/health.html << EOF
<html><body><h1>SDKIM WEB SERVER _ health </h1></body></html>
EOF
systemctl enable httpd
systemctl start httpd