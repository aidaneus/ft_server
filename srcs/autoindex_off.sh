#!/bin/bash
rm /etc/nginx/sites-enabled/ft_server
ln -s /etc/nginx/sites-available/ft_server_off /etc/nginx/sites-enabled/
service nginx restart
