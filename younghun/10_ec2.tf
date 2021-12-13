data "aws_ami" "amzn" {
  most_recent = true
  
  filter {
    name  = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}


resource "aws_instance" "yh_web" {
    ami = data.aws_ami.amzn.id
    instance_type = "t2.micro"
    key_name = "lab7key"
    vpc_security_group_ids = [aws_security_group.yh_websg.id]
    availability_zone = "ap-northeast-2a"
    private_ip = "10.2.0.11"
    subnet_id = aws_subnet.yh_pub[0].id
    user_data = file("wordpress.sh")
}

resource "aws_eip" "yh_eip"{
    vpc = true
    instance = aws_instance.yh_web.id
    associate_with_private_ip = "10.2.0.11"
    depends_on = [aws_internet_gateway.yh_ig]
}

output "public_ip" {
    value = aws_instance.yh_web.public_ip
}