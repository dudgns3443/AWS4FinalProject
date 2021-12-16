#Instance ami Data
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
      name = "name"
      values = [var.instance_filter_namevalue]
  }
  filter {
      name = "virtualization-type"
      values = [var.instance_filter_vtypevalue]
  }
  owners = [var.instance_owner]
}

#Bastion Instance
resource "aws_instance" "bastion" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  availability_zone = "${var.region}${var.az[0]}"
  private_ip = var.bastion_pip
  subnet_id = aws_subnet.a4_pub[0].id
  # user_data = file("./ssh.sh")
  tags = {
    "Name" = "Bastion"
  }
}

#Elastic IP for Bastion
resource "aws_eip" "bastion" {
  vpc = true
  instance = aws_instance.bastion.id
  associate_with_private_ip = var.bastion_pip
  depends_on = [aws_internet_gateway.a4_ig_web]
}