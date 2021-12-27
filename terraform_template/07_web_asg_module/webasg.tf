# AMI
resource "aws_ami_from_instance" "a4_web_ami" {
    name = "${var.name}-web-ami"
    source_instance_id = data.terraform_remote_state.golden_image.outputs.a4_web_golden_image.id
    tags = {
        "Name" = "${var.name}-web-ami"
    }
}

#VPC-Web Launch Configuration
resource "aws_launch_configuration" "a4_web_lc" {
    name = "${var.name}-web-lc"
    image_id = aws_ami_from_instance.a4_web_ami.id
    instance_type = var.instance_type
    security_groups = [data.terraform_remote_state.sg.outputs.web_sg_id]
    iam_instance_profile = data.terraform_remote_state.iam.outputs.web_was_describe_profile
    key_name = var.key
    user_data = file("ssh.sh")
}

#VPC-Web Auto Scaling
resource "aws_autoscaling_group" "a4_web_auto" {
    name = "${var.name}-web"
    min_size = var.web_min_auto
    max_size = var.web_max_auto
    force_delete = false
    desired_capacity = 2
    health_check_grace_period = 60
    health_check_type = "EC2"
    launch_configuration = aws_launch_configuration.a4_web_lc.name
    vpc_zone_identifier = [data.terraform_remote_state.network.outputs.a4_sub_pri_web[0].id,data.terraform_remote_state.network.outputs.a4_sub_pri_web[1].id]
    tag {
     key                 = "Name"
     value               = "${var.name}-web-asg"
     propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "a4_web_asatt" {
    autoscaling_group_name = aws_autoscaling_group.a4_web_auto.id
    alb_target_group_arn = data.terraform_remote_state.alb.outputs.a4_http_albtg_arn
}

resource "aws_autoscaling_policy" "a4-web-ap" {
  name                   = "a4-web-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.a4_web_auto.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = "60"

  }
}
