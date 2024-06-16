#/bin/bash

# Set variables

servername=${HOSTING_DOMAINNAME//./_}

mkdir /var/www/html/$(echo $servername)

# Start apache
apache2-foreground