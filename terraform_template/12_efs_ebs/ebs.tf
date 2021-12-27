resource "aws_ebs_volume" "a4_ebs" {
  availability_zone = "${var.region}${var.az[0]}"
  size = 20
  tags = {
    "Name" = "${var.name}-ebs"
  }
}

resource "aws_volume_attachment" "a4_ebsatt" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.a4_ebs.id
  instance_id = data.terraform_remote_state.ec2_bastion.outputs.control_id
  #depends_on = [aws_instance.bastion]
}