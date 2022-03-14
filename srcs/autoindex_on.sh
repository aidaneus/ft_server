#!/bin/bash
rm /etc/nginx/sites-enabled/ft_server_off
ln -s /etc/nginx/sites-available/ft_server /etc/nginx/sites-enabled/
service nginx restart
bash
