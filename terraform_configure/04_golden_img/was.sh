#!/bin/bash
useradd -aG wheel ec2-user

sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sed -i 's/# %wheel/%wheel/g' /etc/sudoers
echo "work" | passwd --stdin ec2-user

systemctl restart sshd

mkdir /app

yum install -y gcc-c++ make 

curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash - 
yum install -y nodejs

yum install git -y
git clone https://github.com/dudgns3443/HealthCare-BackEnd.git /app

cd /app
npm install package.json --save

# node /app/app &
nohup node /app/app & 
