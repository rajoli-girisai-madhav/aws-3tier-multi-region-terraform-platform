variable "sg_name" {
  description = "Name for the security group"
  type        = string
}

variable "vpc_id" {
  description = "get VPC ID from vpc module"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the security group"
  type        = map(string)
  default     = {}
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    port = number
    protocol = string
    cidr_blocks = list(string)
    description = string
  }))
}


