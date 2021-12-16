resource "aws_ami_from_instance" "a4_was_ami" {
    name = "${var.name}-was-ami"
    source_instance_id = aws_instance.a4_was_golden_image.id
    tags = {
        "Name" = "${var.name}-was-ami"
    }
    depends_on = [
        aws_instance.a4_was_golden_image
    ]
}

#VPC-Was Launch Configuration
resource "aws_launch_configuration" "a4_was_lc" {
    name = "${var.name}-was-lc"
    image_id = aws_ami_from_instance.a4_was_ami.id
    instance_type = var.instance_type
    security_groups = [aws_security_group.was_sg.id]
    key_name = var.key
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
    vpc_zone_identifier = [aws_subnet.a4_priwas[0].id, aws_subnet.a4_priwas[1].id]
}

resource "aws_autoscaling_attachment" "a4_was_asatt" {
    autoscaling_group_name = aws_autoscaling_group.a4_was_auto.id
    alb_target_group_arn = aws_lb_target_group.a4_tomcat_nlbtg.arn
}