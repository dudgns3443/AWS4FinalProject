# AMI
resource "aws_ami_from_instance" "a4_web_ami" {
    name = "${var.name}-web-ami"
    source_instance_id = aws_instance.a4_web_golden_image.id
    tags = {
        "Name" = "${var.name}-web-ami"
    }
    depends_on = [
        aws_instance.a4_web_golden_image
    ]
}

#VPC-Web Launch Configuration
resource "aws_launch_configuration" "a4_web_lc" {
    name = "${var.name}-web-lc"
    image_id = aws_ami_from_instance.a4_web_ami.id
    instance_type = var.instance_type
    security_groups = [aws_security_group.web_sg.id]
    key_name = var.key
}

#VPC-Web Auto Scaling
resource "aws_autoscaling_group" "a4_web_auto" {
    name = "${var.name}-web"
    min_size = var.min_auto
    max_size = var.max_auto
    force_delete = false
    desired_capacity = 2
    health_check_grace_period = 60
    health_check_type = "EC2"
    launch_configuration = aws_launch_configuration.a4_web_lc.name
    vpc_zone_identifier = [aws_subnet.a4_priweb[0].id, aws_subnet.a4_priweb[1].id]
}

resource "aws_autoscaling_attachment" "a4_web_asatt" {
    autoscaling_group_name = aws_autoscaling_group.a4_web_auto.id
    alb_target_group_arn = aws_lb_target_group.a4_http_albtg.arn
}