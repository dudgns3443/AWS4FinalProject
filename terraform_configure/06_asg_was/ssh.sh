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

# key chmod 400
sudo chmod 400 /home/ec2-user/a4_key.pem

# KST 시간
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# was_log
# sudo -i
# sudo cat > /root/was_log.sh << EOF
# # was_sys_log
# sudo aws s3 cp /var/log/messages s3://bucket-log-a4/was_log/was_sys_log/\$(date "+%Y-%m-%d-%H-%M").log
# EOF

# sudo chmod 777 /root/was_log.sh

# sudo echo "*/5 * * * * root bash /root/was_log.sh" >> /etc/crontab

cd /home/ec2-user/
sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
sudo mkdir /usr/share/collectd
sudo touch /usr/share/collectd/types.db
sudo wget https://a4-stuff-store.s3.ap-northeast-2.amazonaws.com/was-config.json
sudo rm /opt/aws/amazon-cloudwatch-agent/bin/config.json
sudo cp was-config.json /opt/aws/amazon-cloudwatch-agent/bin/config.json
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json