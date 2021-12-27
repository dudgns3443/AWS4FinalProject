#!/bin/bash
#!/bin/sh

wget -P /home/ec2-user/ https://a4-stuff-store.s3.ap-northeast-2.amazonaws.com/a4_key.pem
chmod 444 /home/ec2-user/a4_key.pem
amazon-linux-extras install -y ansible2
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
            shell: /usr/local/bin/s3fs bucket-log-a4 /s3fs
            args:
                    executable: /bin/bash
EOF