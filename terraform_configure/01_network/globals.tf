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