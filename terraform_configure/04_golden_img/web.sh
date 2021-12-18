#!/bin/bash
useradd -aG wheel ec2-user

sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sed -i 's/# %wheel/%wheel/g' /etc/sudoers
echo "work" | passwd --stdin ec2-user
systemctl restart sshd

yum -y update
sudo amazon-linux-extras install nginx1 -y
systemctl enable nginx
service nginx start

yum install -y git
git clone https://github.com/dudgns3443/HealthCare.git
cp -rf HealthCare/* /usr/share/nginx/html/