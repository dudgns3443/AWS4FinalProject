variable "seoul" {
    type = string
    default = "ap-northeast-2"

}

variable "key" {
    type = string
    default = "lab7key"
}

variable "cidr_main"{
    type = string
    default  = "10.2.0.0/16"
}

variable "name" {
    type = string
    default = "yh"
}

variable "pub_cidr" {
    type = list
    default = ["10.2.0.0/24","10.2.1.0/24"]
}

variable "pri_cidr" {
    type = list
    default = ["10.2.2.0/24","10.2.3.0/24"]
}

variable "db_cidr" {
    type = list
    default = ["10.2.4.0/24","10.2.5.0/24"]
}

variable "az" {
    type = list
    default = ["a","c"]
}

variable "route_cidr" {
    type = string
    default = "0.0.0.0/0"
}