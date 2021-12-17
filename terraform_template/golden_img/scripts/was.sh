#!/bin/bash
mkdir /app
cd /app
yum install -y gcc-c++ make 

curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash - 
yum install -y nodejs

yum install git -y
git clone https://github.com/dudgns3443/HealthCare-BackEnd.git

cd HealthCare-BackEnd
npm install package.json --save
node app