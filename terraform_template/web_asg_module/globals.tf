variable "region" {
    type = string

}
variable "key" {
    type = string

}
variable "name" {
    type = string

}
variable "remote_bucket_name" {
  type        = string
  default     = null
}

variable "az" {
    type = list
}

variable "route_cidr_global" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "bastion_pip" {
    type = string
}

variable "port_http" {
    type = number
}

variable "port_tomcat" {
    type = number
}

variable "lb_type" {
    type = list
}

variable "lis_default_action" {
    type = string
}