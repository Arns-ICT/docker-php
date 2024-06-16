#/bin/bash

# Set variables

servername=${HOSTING_DOMAINNAME//./_}

mkdir /var/www/html/$(echo $servername)

cat > /etc/apache/sites/$(echo $servername).conf << EOF
<VirtualHost *:80>
        ServerName www.$(echo $HOSTING_DOMAINNAME)

        ServerAdmin $(echo $HOSTING_SERVERADMIN)

        Redirect 301 / http://$(echo $HOSTING_DOMAINNAME)/

        ErrorLog /var/www/logs/error-www_$(echo $servername).log
        CustomLog ${APACHE_LOG_DIR}/access-www_$(echo $servername).log combined
</VirtualHost>

<VirtualHost *:80>
        ServerName $(echo $HOSTING_DOMAINNAME)

        ServerAdmin $(echo $HOSTING_SERVERADMIN)

		DocumentRoot /var/www/html/$(echo $servername)


        ErrorLog /var/www/logs/error-$(echo $servername).log
        CustomLog ${APACHE_LOG_DIR}/access-$(echo $servername).log combined
</VirtualHost>
EOF

# Start apache
apache2-foreground