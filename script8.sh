#!/bin/bash
apt update -y 
apt install apache2 -y
systemctl start apache2
systemctl enable apache2


cat <<EOF > ssl-config.conf
[ req ]
default_bits       = 2048
default_md         = sha256
prompt             = no
encrypt_key        = no
distinguished_name = dn

[ dn ]
C=US
ST=New York
L=New York City
O=My Organization
OU=My Organizational Unit
emailAddress=me@example.com
CN = www.mywebsite.com
EOF


openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -config ssl-config.conf


cat <<EOF > apache-config.conf
<VirtualHost *:443>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
EOF


cp apache-config.conf /etc/apache2/sites-available/000-default.conf
a2enmod ssl
a2ensite default-ssl
systemctl restart apache2


echo "<html><body><h1>Hello world! Hovda Bohdan done it</h1></body></html>" > /var/www/html/index.html
