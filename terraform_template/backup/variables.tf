variable "team" {
  type = string
}


variable "purpose" {
  type = string
}


variable "role" {
  type = string

}

variable "resource_type" {
  type        = string
  description = "(optional) describe your variable"
}

variable "interval" {
  type        = number
  description = "default -> 24"
}

variable "interval_unit" {
  type        = string
  description = "(optional) describe your variable"
}

variable "start_time" {
  type        = string
  description = "default -> 09:00"

}

variable "retain_number" {
  type        = number
  description = "default -> 3"
}

variable "target_tag_Name" {
  type        = string
  description = "default -> bastion"
}