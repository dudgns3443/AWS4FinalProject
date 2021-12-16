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
    default = "lab7key"
}

variable "name" {
    type = string
    default = "yh"
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

