#!/bin/bash

#start mysql
service mysql start
mysql -e "create database ft_server;"
mysql -e "create user 'nhildred'@'localhost' identified by 'nhildred';"
mysql -e "grant all on ft_server.* to 'nhildred'@'localhost';"
mysql -e "flush privileges;"

service php7.3-fpm start
service nginx start

bash
