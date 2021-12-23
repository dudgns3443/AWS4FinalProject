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