resource "aws_cloudwatch_log_group" "web_log" {
    name = "web-log"
    retention_in_days = 7
    tags = {
        "Name" = "web-log"
    }
}

resource "aws_cloudwatch_log_group" "was_log" {
    name = "was-log"
    retention_in_days = 7
    tags = {
        "Name" = "was-log"
    }
}

resource "aws_cloudwatch_log_group" "nginx_access" {
    name = "nginx_access"
    retention_in_days = 7
    tags = {
        "Name" = "nginx-access"
    }
}

resource "aws_cloudwatch_log_group" "nginx_error" {
    name = "nginx_error"
    retention_in_days = 7
    tags = {
        "Name" = "nginx-error"
    }
}