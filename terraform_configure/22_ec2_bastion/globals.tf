
variable "region" {
    type = string
    default = "ap-northeast-2"
}
variable "key" {
    type = string
    default = "a4_key"
}
variable "name" {
    type = string
    default = "a4"
}
variable "remote_bucket_name" {
  type        = string
  default     = "aws4-terraform-state"
}

variable "az" {
    type = list
    default = ["a","c"]
}

variable "route_cidr_global" {
    type = string
    default = "0.0.0.0/0"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "bastion_pip" {
    type = string
    default = "10.10.0.10"
}

variable "port_http" {
    type = number
    default = 80
}

variable "port_tomcat" {
    type = number
    default = 8100
}

variable "lb_type" {
    type = list
    default = ["application","network"]
}

variable "b_protocol" {
    type = string
    default = "TCP"
}

variable "lis_default_action" {
    type = string
    default = "forward"
}