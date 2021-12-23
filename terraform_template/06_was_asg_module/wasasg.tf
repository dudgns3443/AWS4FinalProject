resource "aws_ami_from_instance" "a4_was_ami" {
    name = "${var.name}-was-ami"
    source_instance_id = data.terraform_remote_state.golden_image.outputs.a4_was_golden_image.id
    tags = {
        "Name" = "${var.name}-was-ami"
    }
}

#VPC-Was Launch Configuration
resource "aws_launch_configuration" "a4_was_lc" {
    name = "${var.name}-was-lc"
    image_id = aws_ami_from_instance.a4_was_ami.id
    instance_type = var.instance_type
    security_groups = [data.terraform_remote_state.sg.outputs.was_sg_id]
    iam_instance_profile = data.terraform_remote_state.iam.outputs.web_was_describe_profile
    key_name = var.key
    user_data = file("ssh.sh")
}

#VPC-Was Auto Scaling
resource "aws_autoscaling_group" "a4_was_auto" {
    name = "${var.name}-was"
    min_size = var.min_auto
    max_size = var.max_auto
    force_delete = false
    desired_capacity = 2
    health_check_grace_period = 60
    health_check_type = "EC2"
    launch_configuration = aws_launch_configuration.a4_was_lc.name
    vpc_zone_identifier = [data.terraform_remote_state.network.outputs.a4_sub_pri_was[0].id,data.terraform_remote_state.network.outputs.a4_sub_pri_was[1].id]
    tag {
     key                 = "Name"
     value               = "${var.name}-was-asg"
     propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "a4_was_asatt" {
    autoscaling_group_name = aws_autoscaling_group.a4_was_auto.id
    alb_target_group_arn = data.terraform_remote_state.nlb.outputs.a4_tomcat_nlbtg_arn
}