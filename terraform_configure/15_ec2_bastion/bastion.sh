#!/bin/bash

wget -P /home/ec2-user/ https://a4-stuff-store.s3.ap-northeast-2.amazonaws.com/a4_key.pem

amazon-linux-extras install -y ansible2

cd /home/ec2-user

echo '[web]' > inventory
aws ec2 describe-instances --filters Name=tag-value,Values=a4-web-asg --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress' --output text --region=ap-northeast-2 >> inventory
echo '[was]' >> inventory

aws ec2 describe-instances --filters Name=tag-value,Values=a4-was-asg --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress' --output text --region=ap-northeast-2 >> inventory

aws elbv2 describe-load-balancers --names "a4-nlb" --query "LoadBalancers[*].DNSName[]" --output text --region=ap-northeast-2 > nlb_dns.txt

echo "[defaults]
inventory = ./inventory
remote_user = ec2-user
ask_pass = false
[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = false" > ansible.cfg

cat > nginx.conf << EOF
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        # location / {
        #     root   html;
        #     index  index.html index.htm;
        
        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }

        # location /nlb/ { 
        #     proxy_pass http://NLB_DNS:8080; 
        #     proxy_set_header X-Real-IP $remote_addr; 
        #     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 
        #     proxy_set_header Host $http_host; 
        # }
        location /nlb/ { 
            proxy_pass http://a4-nlb-159008c51cde6d9f.elb.ap-northeast-2.amazonaws.com:8100/; 
            proxy_set_header X-Real-IP $remote_addr; 
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 
            proxy_set_header Host $http_host; 
        }        
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2;
#        listen       [::]:443 ssl http2;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers PROFILE=SYSTEM;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
EOF

aws ec2 describe-instances --filters Name=tag-value,Values=a4-web-asg --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress' --output text --region=ap-northeast-2  >> /etc/hosts
aws ec2 describe-instances --filters Name=tag-value,Values=a4-was-asg --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress' --output text --region=ap-northeast-2  >> /etc/hosts

cat > copy_conf.yaml << EOF
- name: Copy nginx configuration
  hosts: web
  tasks:
  - name: make backup nginx.conf
    command: cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
  - name: Copy conf
    copy: 
      src: /home/ec2-user/nginx.conf
      dest: /etc/nginx/nginx.conf
  - name: restart nginx
    service:
      name: nginx
      state: restarted
      enabled: yes
EOF

cat > s3_mount.yaml << EOF
---
- name: s3_bucket_connect
  hosts: localhost
  become: true
  tasks:
          - name: package install
            yum:
                    name:
                        - automake
                        - fuse-devel
                        - gcc-c++
                        - git
                        - libcurl-devel
                        - libxml2-devel
                        - make
                        - openssl-devel
                    state: latest
          - name: git
            git:
                    repo: https://github.com/s3fs-fuse/s3fs-fuse.git
                    dest: /home/ec2-user/s3fs-fuse
                    clone: true
                    force: true
          - name: keygen
            shell:
                    cmd: ./autogen.sh
                    chdir: /home/ec2-user/s3fs-fuse
          - name: openssl
            shell:
                    cmd: ./configure
                    chdir: /home/ec2-user/s3fs-fuse
          - name: Build
            make:
                    chdir: /home/ec2-user/s3fs-fuse
          - name: Run install
            make:
                    chdir: /home/ec2-user/s3fs-fuse
                    target: install
          - name: mkdir s3fs
            file:
                    path: /s3fs
                    state: directory
          - name: mount
            shell: /usr/local/bin/s3fs bucket-log-kth /s3fs
            args:
                    executable: /bin/bash
EOF

wget https://a4-stuff-store.s3.ap-northeast-2.amazonaws.com/cwagent-was.yaml
wget https://a4-stuff-store.s3.ap-northeast-2.amazonaws.com/cwagent-web.yaml

# KST 시간
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# bastion log 
sudo -i
cat > bastion_log.sh << EOF
# bastion_sys_log
sudo aws s3 cp /var/log/messages s3://bucket-log-kth/bastion_log/web_sys_log/$(date "+%Y-%m-%d").log
EOF

chmod 777 bastion_log.sh

echo "40 11 * * * root bash /root/bastion_log.sh" >> /etc/crontab