variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_storage_type" {
  type    = string
  default = "gp2"
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_engine_ver" {
  type    = string
  default = "8.0"
}

variable "db_instance_type" {
  type    = string
  default = "db.t2.micro"
}

variable "db_name" {
  type    = string
  default = "a4db"
}

variable "db_identifier" {
  type    = string
  default = "a4db"
}

variable "db_user" {
  type    = string
  default = "a4"
}

variable "db_passwd" {
  type    = string
  default = "123456789"
}

variable "db_parameter_group_name" {
  type    = string
  default = "default.mysql8.0"
}

variable "backup_time" {
  type        = string
  description = "start to automated backup time"
  default     = "09:00-10:30"
}

variable "retention_period" {
  type    = number
  default = 7
}

variable "maintenance_time" {
  type        = string
  description = "Fri:22:00-Fri:23:00"
}