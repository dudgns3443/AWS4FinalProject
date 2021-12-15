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


resource "aws_instance" "A4_was" {
    ami = data.aws_ami.amzn.id
    instance_type = "t2.micro"
    key_name = var.key
    vpc_security_group_ids = [aws_security_group.yh_websg.id]
    availability_zone = "ap-northeast-2a"
    private_ip = "10.10.0.11"
    subnet_id = aws_subnet.yh_pub[0].id
    user_data = file("was.sh")
}

resource "aws_eip" "yh_eip"{
    vpc = true
    instance = aws_instance.A4_was.id
    associate_with_private_ip = "10.10.0.11"
    depends_on = [aws_internet_gateway.yhkim_ig]
}

output "public_ip" {
    value = aws_instance.A4_was.public_ip
}