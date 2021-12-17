#!/bin/bash

yum -y update
sudo amazon-linux-extras install nginx1 -y
systemctl enable nginx
service nginx start

yum install -y git
git clone https://github.com/dudgns3443/HealthCare.git
cp -rf HealthCare/* /usr/share/nginx/html/