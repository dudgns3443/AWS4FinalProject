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
/*-----------------------------------*/

variable "az" {
    type = list
    default = ["a","c"]
}

variable "route_cidr_global" {
    type = string
    default = "0.0.0.0/0"
}