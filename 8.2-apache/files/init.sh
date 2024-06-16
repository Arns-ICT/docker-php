#/bin/bash

# Set variables
FOLDERNAME=${HOSTING_DOMAINNAME//./_}

cp /etc/apache2/sites-available/template_vhost.conf /etc/apache2/sites-available/$(echo $FOLDERNAME).conf
sed -i 's|<ServerName>|${echo HOSTING_DOMAINNAME}|g' /etc/apache2/sites-available/$(echo $FOLDERNAME).conf
sed -i 's|<ServerAdmin>|${echo HOSTING_SERVERADMIN}|g' /etc/apache2/sites-available/$(echo $FOLDERNAME).conf
sed -i 's|<FolderName>|${echo FOLDERNAME}|g' /etc/apache2/sites-available/$(echo $FOLDERNAME).conf

mkdir /var/www/logs
mkdir /var/www/html/$(echo $FOLDERNAME)

ln -s /etc/apache2/sites-available/$(echo $FOLDERNAME).conf /etc/apache2/sites-enabled/$(echo $FOLDERNAME).conf

# Start apache
apache2-foreground