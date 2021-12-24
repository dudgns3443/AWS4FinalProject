data "aws_ssm_parameter" "a4db_username" {
    name = "/a4db/rds/master.username"
}

data "aws_ssm_parameter" "a4db_passwd" {
    name = "/a4db/rds/master.userpasswd"
}