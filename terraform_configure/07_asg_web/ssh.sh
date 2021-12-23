#!/bin/bash
usermod -aG wheel ec2-user

sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sed -i 's/# %wheel/%wheel/g' /etc/sudoers
echo "work" | passwd --stdin ec2-user

systemctl restart sshd

NLB_DNS=`aws elbv2 describe-load-balancers --names "a4-nlb" --query "LoadBalancers[*].DNSName[]" --output text --region=ap-northeast-2`

# KST 시간
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# web_log
sudo -i
cat > web_log.sh << EOF
# web_sys_log
sudo aws s3 cp /var/log/messages s3://bucket-log-kth/web_log/web_sys_log/$(date "+%Y-%m-%d").log

# web_error_log
sudo aws s3 cp /var/log/messages s3://bucket-log-kth/web_log/web_sys_log/$(date "+%Y-%m-%d").log
EOF

chmod 777 web_log.sh

echo "59 11 * * * root bash /root/web_log.sh" >> /etc/crontab
