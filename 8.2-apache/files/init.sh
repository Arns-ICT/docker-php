#/bin/bash

# Set variables
SERVERNAMEFOLDER=${HOSTING_DOMAINNAME//./_}

cp /etc/apache2/sites-available/template_vhost.conf /etc/apache2/sites-available/$(echo $SERVERNAMEFOLDER).conf
sed -i 's|<ServerName>|${echo HOSTING_DOMAINNAME}|g' /etc/apache2/sites-available/$(echo $SERVERNAMEFOLDER).conf
sed -i 's|<ServerAdmin>|${echo HOSTING_SERVERADMIN}|g' /etc/apache2/sites-available/$(echo $SERVERNAMEFOLDER).conf
sed -i 's|<ServerNameFolder>|${echo SERVERNAMEFOLDER}|g' /etc/apache2/sites-available/$(echo $SERVERNAMEFOLDER).conf

mkdir /var/www/html/$(echo $SERVERNAMEFOLDER)

ln -s /etc/apache2/sites-available/$(echo $SERVERNAMEFOLDER).conf /etc/apache2/sites-enabled/$(echo $SERVERNAMEFOLDER).conf

# Start apache
apache2-foreground