variable "port_http" {
    type = number
    default = 80
}

variable "lb_type" {
    type = list
    default = ["application","network"]
}

variable "l7_protocol" {
    type = list
    default = ["http","https"]
} 

variable "healthy_threshold" {
    type = number
    default = 3
}

variable "health_interval" {
    type = number
    default = 5
}

variable "health_path" {
    type = string
    default = "/"
}

variable "health_port" {
    type = string
    default = "traffic-port"
}

variable "health_matcher" {
    type = string
    default = "200" 
}

variable "health_timeout" {
    type = number
    default = 2
}

variable "unhealthy_threshold" {
    type = number
    default = 2
}