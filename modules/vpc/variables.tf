variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "prefix" {
  description = "Prefix for resource names"
  default     = "pg-ha"
}
