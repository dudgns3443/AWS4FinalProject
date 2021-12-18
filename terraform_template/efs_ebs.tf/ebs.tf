resource "aws_ebs_volume" "final_ebs" {
  availability_zone = "${var.region}${var.az[0]}"
  size = 20
  tags = {
    "Name" = "final-ebs"
  }
}

resource "aws_volume_attachment" "final_ebsatt" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.final_ebs.id
  instance_id = aws_instance.bastion.id
  depends_on = [aws_instance.bastion]
}