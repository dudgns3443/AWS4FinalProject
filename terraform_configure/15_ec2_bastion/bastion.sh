#!/bin/bash
#!/bin/sh

wget -P /home/ec2-user/ https://a4-stuff-store.s3.ap-northeast-2.amazonaws.com/a4_key.pem
chmod 444 /home/ec2-user/a4_key.pem
