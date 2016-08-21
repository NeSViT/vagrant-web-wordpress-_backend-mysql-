#!/bin/bash

# script provide custom parameters for wordpress using wp cli: http://wp-cli.org/commands/core/install/
# wordpress folder = /var/www/wordpress
# ip for wp site = 10.10.100.20
# wp title = DEVOPS START
# admin user = nesvits
# admin password = password
# admin email = nesvits@gmail.com

echo "INSTALL WP-CLI PACKET FOR RULING WORDPRESS FROM CONSOLE"
# Download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# set execute permissions to downloaded file
chmod +x wp-cli.phar
# move file to custom derectory
sudo mv wp-cli.phar /usr/local/bin/wp
# delete downloaded file
rm -f wp-cli.phar

echo "CONFIGURE INSTALL.PHP PAGE AUTOMATICALLY"
# run command from user vagrant to configure wordpress start page 
sudo -u vagrant -i -- wp core install --path="/var/www/wordpress" --url=10.10.100.20 --title="DEVOPS START" --admin_user=nesvits --admin_password=password --admin_email=nesvits@gmail.com
sudo -u vagrant -i -- curl http://loripsum.net/api/5 |sudo -u vagrant -i -- wp post generate --path="/var/www/wordpress" --post_content --count=10