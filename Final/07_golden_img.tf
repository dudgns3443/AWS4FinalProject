#Web-Golden Image
resource "aws_instance" "a4_web_golden_image" {
  ami = "ami-0263588f2531a56bd"
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.a4_gi_sg.id]
  availability_zone = "${var.region}${var.az[1]}"
  subnet_id = aws_subnet.a4_pub[1].id
  user_data = file("scripts/web.sh")
  tags = {
    "Name" = "Web-golden-image"
  }
}

#Was-Golden Image
resource "aws_instance" "a4_was_golden_image" {
  ami = "ami-0263588f2531a56bd"
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids = [aws_security_group.a4_gi_sg.id]
  availability_zone = "${var.region}${var.az[1]}"
  subnet_id = aws_subnet.a4_pub[1].id
  user_data = file("scripts/was.sh")
  tags = {
    "Name" = "Was-golden-image"
  }
}