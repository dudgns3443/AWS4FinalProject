#!/bin/bash
usermod -aG wheel ec2-user

sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sed -i 's/# %wheel/%wheel/g' /etc/sudoers
echo "work" | passwd --stdin ec2-user

systemctl restart sshd

NLB_DNS=`aws elbv2 describe-load-balancers --names "a4-nlb" --query "LoadBalancers[*].DNSName[]" --output text --region=ap-northeast-2`

cat > /lib/systemd/system/healthcare.service << EOF
[Unit]
Description=hello_env.js - making your environment variables rad
Documentation=https://example.com
After=network.target

[Service]
Environment=NODE_PORT=8100
Type=simple
User=root
ExecStart=/usr/bin/node /app/app
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start healthcare
systemctl enable healthcare

# KST 시간
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# was_log
sudo -i
cat > was_log.sh << EOF
# was_sys_log
sudo aws s3 cp /var/log/messages s3://bucket-log-kth/web_log/was_sys_log/$(date "+%Y-%m-%d").log
EOF

chmod 777 was_log.sh

echo "59 11 * * * root bash /root/was_log.sh" >> /etc/crontab