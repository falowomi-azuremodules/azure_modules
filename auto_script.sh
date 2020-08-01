#!/bin/bash
apt-get update -y
apt-get -y install apache2 php7.0 libapache2-mod-php7.0
service apache2 start
service apache2 stop


mkdir /site
mkdir /site/main
mkdir /site/main/html

sed -i 's+DocumentRoot /var/www/html+DocumentRoot /site/main/html+g' /etc/apache2/sites-enabled/000-default.conf
sed -i 's+<Directory /var/www>+<Directory /site/main>+g' /etc/apache2/apache2.conf

apachectl configtest

cat <<EOF > /site/main/html/index.php
<?php
\$hostname = gethostname();
echo "<h2>Hello World!</h2>";
echo "<h2>Server Hostname: \$hostname</h2>";
?>
EOF

rm -rf /var/www

service apache2 start
