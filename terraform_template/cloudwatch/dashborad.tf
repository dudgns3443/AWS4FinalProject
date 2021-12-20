resource "aws_cloudwatch_dashboard" "a4-web-dashboard" {
  dashboard_name = "a4-web-dashboard"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", "a4-web" ]
                ],
                "region": "ap-northeast-2"
            }
        }
    ]
}
EOF
}

resource "aws_cloudwatch_dashboard" "a4-was-dashboard" {
  dashboard_name = "a4-was-dashboard"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", "a4-was" ]
                ],
                "region": "ap-northeast-2"
            }
        }
    ]
}
EOF
}

resource "aws_cloudwatch_dashboard" "a4-db-dashboard" {
  dashboard_name = "a4-db-dashboard"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "a4db" ]
                ],
                "region": "ap-northeast-2"
            }
        }
    ]
}
EOF
}