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