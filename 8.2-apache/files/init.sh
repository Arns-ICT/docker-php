#/bin/bash

# Set variables
SERVERNAMEFOLDER=${HOSTING_DOMAINNAME//./_}

cp /etc/apache2/sites-available/template_vhost.conf /etc/apache2/sites-available/$(echo $servername).conf
sed -i 's|<ServerName>|${echo HOSTING_DOMAINNAME}|g' /etc/apache2/conf-enabled/security.conf
sed -i 's|<ServerAdmin>|${echo HOSTING_SERVERADMIN}|g' /etc/apache2/conf-enabled/security.conf
sed -i 's|<ServerNameFolder>|${echo SERVERNAMEFOLDER}|g' /etc/apache2/conf-enabled/security.conf

mkdir /var/www/html/$(echo $servername)

# Start apache
apache2-foreground