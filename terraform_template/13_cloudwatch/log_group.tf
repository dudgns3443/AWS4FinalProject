resource "aws_cloudwatch_log_group" "web_log" {
    name = "web-log"
    retention_in_days = 7
    tags = {
        "Name" = "web-log",
        "ExportToS3" = "true"
    }
}

resource "aws_cloudwatch_log_group" "was_log" {
    name = "was-log"
    retention_in_days = 7
    tags = {
        "Name" = "was-log",
        "ExportToS3" = "true"
    }
}

resource "aws_cloudwatch_log_group" "nginx_access" {
    name = "nginx_access"
    retention_in_days = 7
    tags = {
        "Name" = "nginx-access",
        "ExportToS3" = "true"
    }
}

resource "aws_cloudwatch_log_group" "nginx_error" {
    name = "nginx_error"
    retention_in_days = 7
    tags = {
        "Name" = "nginx-error",
        "ExportToS3" = "true"
    }
}