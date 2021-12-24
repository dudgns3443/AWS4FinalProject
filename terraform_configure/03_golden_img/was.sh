#!/bin/bash
#!/bin/sh

mkdir /app

yum install -y gcc-c++ make 

curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash - 
yum install -y nodejs

yum install git -y
git clone https://github.com/dudgns3443/HealthCare-BackEnd.git /app

cd /app
npm install package.json --save

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
