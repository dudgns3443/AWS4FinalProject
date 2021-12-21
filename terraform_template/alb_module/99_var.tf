# variable "access_key" {
#     type = string
#     default = ""
# }

# variable "secret_key" {
#     type = string
#     default = ""
# }

variable "region" {
    type = string
    default = "ap-northeast-2"
}

variable "vpc_cidr_web" {
    default = "10.10.0.0/16" 
}
variable "vpc_cidr_was" {
    default = "10.20.0.0/16" 
}


variable "key" {
    type = string
    default = "a4_key"
}

variable "name" {
    type = string
    default = "a4"
}

variable "pub_cidr" {
    type = list
    default = ["10.10.0.0/24","10.10.1.0/24"]
}

variable "pri_cidr_web" {
    type = list
    default = ["10.10.2.0/24","10.10.3.0/24"]
}
variable "pri_cidr_was" {
    type = list
    default = ["10.20.0.0/24","10.20.1.0/24"]
}

variable "pub_cidr_was" {
    type = list
    default = ["10.20.10.0/24","10.20.11.0/24"]
}

variable "db_cidr" {
    type = list
    default = ["10.20.2.0/24","10.20.3.0/24"]
}

variable "az" {
    type = list
    default = ["a","c"]
}

variable "route_cidr_global" {
    type = string
    default = "0.0.0.0/0"
}

##### Security gorup 이후
variable "rule_type" {
    type = list
    default = ["ingress","egress" ]
}

variable "port_ssh" {
    type = number
    default = 22
}

variable "protocol" {
    type = string
    default = "tcp"
}

variable "b_protocol" {
    type = string
    default = "TCP"
}

variable "b_protocol_http" {
    type = string
    default = "HTTP"
}

variable "port_http" {
    type = number
    default = 80
}

variable "port_https" {
    type = number
    default = 443
}

variable "port_efs" {
    type = number
    default = 2049
}

variable "port_mysql" {
    type = number
    default = 3306
}

variable "port_redis" {
    type = number
    default = 6379
}

variable "port_tomcat" {
    type = number
    default = 8100
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "bastion_pip" {
    type = string
    default = "10.10.0.10"
}

variable "instance_filter_namevalue" {
    type = string
    default = "amzn2-ami-hvm-*-x86_64-gp2"
}

variable "instance_filter_vtypevalue" {
    type = string
    default = "hvm"
}

variable "instance_owner" {
    type = string
    default = "amazon"
}

variable "lb_type" {
    type = list
    default = ["application","network"]
}

variable "l7_protocol" {
    type = list
    default = ["http","https"]
} 

variable "healthy_threshold" {
    type = number
    default = 3
}

variable "health_interval" {
    type = number
    default = 5
}

variable "health_path" {
    type = string
    default = "/"
}

variable "health_port" {
    type = string
    default = "traffic-port"
}

variable "health_matcher" {
    type = string
    default = "200" 
}

variable "health_timeout" {
    type = number
    default = 2
}

variable "unhealthy_threshold" {
    type = number
    default = 2
}

variable "target_type" {
    type = string
    default = "instance"
}

variable "lis_default_action" {
    type = string
    default = "forward"
}

variable "min_auto" {
    type = number
    default = 2
}

variable "max_auto" {
    type = number
    default = 10
}

variable "db_allocated_storage" {
    type = number
    default = 20
}

variable "db_storage_type" {
    type = string
    default = "gp2"
}

variable "db_engine" {
    type = string
    default = "mysql"
}

variable "db_engine_ver" {
    type = string
    default = "8.0"
}

variable "db_instance_type" {
    type = string
    default = "db.t2.micro"
}

variable "db_name" {
    type = string
    default = "a4db"
}

variable "db_identifier" {
    type = string
    default = "a4db"
}

variable "db_user" {
    type = string
    default = "a4"
}

variable "db_passwd" {
    type = string
    default = "123456789"
}

variable "db_parameter_group_name" {
    type = string
    default = "default.mysql8.0"
}

variable "remote_bucket_name" {
  type        = string
  default     = null
}
