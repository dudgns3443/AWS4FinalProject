#!/bin/bash

wget -P /home/ec2-user/ https://s4-stuff-bucket.s3.ap-northeast-2.amazonaws.com/a4_key.pem

amazon-linux-extras install -y ansible2

cd /home/ec2-user
echo "AKIAUD6MY25DRH5U4WP6
> P0OP1SPUwVLd6AZu3uvz/Ed/Ap+sftLPa/zqWkK/
> ap-northeast-2
> json
> " > configure_info

aws configure < configure_info
echo '[web]' > inventory
aws ec2 describe-instances --filters Name=tag-value,Values=a4-web-asg --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress' --output text >> inventory
echo '[was]' >> inventory
aws ec2 describe-instances --filters Name=tag-value,Values=a4-was-asg --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress' --output text >> inventory


echo "[defaults]
inventory = ./inventory
remote_user = bespin
ask_pass = false
[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = false" > ansible.cfg

