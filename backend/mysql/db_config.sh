#!/bin/bash

# create database for wordpress
mysql -uroot -proot -e "CREATE DATABASE wordpress;"
# create specific user in mysql
mysql -uroot -proot -e "CREATE USER wordpressuser@'10.10.100.20' IDENTIFIED BY 'password';"
# grant permissions to all tables in database wordpress to user wordpressuser
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@'10.10.100.20' IDENTIFIED BY 'password';"
# update permissions
mysql -uroot -proot -e "FLUSH PRIVILEGES;"