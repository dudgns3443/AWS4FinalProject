variable "b_protocol" {
    type = string
    default = "TCP"
}

variable "port_tomcat" {
    type = number
    default = 8100
}

variable "lb_type" {
    type = list
    default = ["application","network"]
}
variable "target_type" {
    type = string
    default = "instance"
}

variable "lis_default_action" {
    type = string
    default = "forward"
}