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

#Web-Golden Image
resource "aws_instance" "a4_web_golden_image" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name = var.key
  #vpc_security_group_ids = [aws_security_group.a4_gi_sg.id]
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.gi_sg_id]
  availability_zone = "${var.region}${var.az[1]}"
  #subnet_id = aws_subnet.a4_pub[1].id
  subnet_id = data.terraform_remote_state.network.outputs.a4_sub_pub_web[1].id
  user_data = file("./web.sh")
  iam_instance_profile = data.terraform_remote_state.iam.outputs.web_was_describe_profile
  tags = {
    "Name" = "Web-golden-image"
  }
}

#Was-Golden Image
resource "aws_instance" "a4_was_golden_image" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name = var.key
  #vpc_security_group_ids = [aws_security_group.a4_gi_sg.id]
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.gi_sg_id]
  availability_zone = "${var.region}${var.az[1]}"
  #subnet_id = aws_subnet.a4_pub[1].id
  subnet_id = data.terraform_remote_state.network.outputs.a4_sub_pub_web[1].id
  user_data = file("./was.sh")
  iam_instance_profile = data.terraform_remote_state.iam.outputs.web_was_describe_profile
  tags = {
    "Name" = "Was-golden-image"
  }
}