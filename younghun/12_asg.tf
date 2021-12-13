resource "aws_ami_from_instance" "yh_ami" {
  name               = "wordpressAMIterra"
  source_instance_id = aws_instance.yh_web.id
  depends_on = [
    aws_instance.yh_web
  ]
}

resource "aws_launch_configuration" "yh_conf" {
  name_prefix   = "terraform-lc-example"
  image_id      = aws_ami_from_instance.yh_ami.id
  instance_type = "t2.micro"
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.yh_websg.id]
  key_name = "lab7key"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_placement_group" "yh_pg" {
  name     = "pg"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "yh_asg" {
  name = "asg"
  min_size = 2
  max_size = 4
  health_check_grace_period = 100
  health_check_type = "EC2"
  desired_capacity = 2
  force_delete = false
  #placement_group = aws_placement_group.yh_pg.id
  launch_configuration = aws_launch_configuration.yh_conf.name
  vpc_zone_identifier = [aws_subnet.yh_pub[0].id,aws_subnet.yh_pub[1].id]
  target_group_arns = [aws_lb_target_group.yh_tg.arn]
}

