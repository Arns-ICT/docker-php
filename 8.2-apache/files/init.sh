#/bin/bash

# Set variables

servername=${HOSTING_DOMAINNAME//./_}
mkdir /var/www/html/$servername

cat > /etc/apache/sites/$servername.conf << EOF
<VirtualHost *:80>
        ServerName www.<domainname>

        ServerAdmin <domainadmin>

        Redirect 301 / http://<domainname>/

        ErrorLog /var/www/logs/error-www_<domainnamefolder>.log
        CustomLog ${APACHE_LOG_DIR}/access-www_<domainnamefolder>.log combined
</VirtualHost>

<VirtualHost *:80>
        ServerName <domainname>

        ServerAdmin <domainadmin>

		DocumentRoot /var/www/html/<domainnamefolder>


        ErrorLog /var/www/logs/error-<domainnamefolder>.log
        CustomLog ${APACHE_LOG_DIR}/access-<domainnamefolder>.log combined
</VirtualHost>
EOF

echo "Done"