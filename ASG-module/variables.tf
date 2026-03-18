variable "alb_name" {
    description = "Provide the name for an application load balancer"
    type = string
}
variable "scheme" {
    description = "Say false, if it is Internet-facing. else, say true."
    type = bool
}
variable "tg_name" {
    description = "Provide name for target group"
    type = string
}
variable "vpc_id" {
  description = "Get VPC ID from the vpc module"
  type        = string
}
variable "name_prefix" {
    description = "provide a name prefix for my launch template"
    type = string
}
variable "ami-id" {
    description = "provide a ami-id for my launch template"
    type = string
}
variable "instance_type" {
    description = "Instance type for launched instances"
    type = string
}
variable "sg-id" {
    description = "provide sg-id for my launch template"
    type = list(string)
    default = []
}
variable "key_name" {
    description = "key_name for my launch template"
    type = string
    default = "test-key" # already existing in my key_pairs
}
variable "user_data" {
    type = string
  description = "add any user data"
}
variable "name" {
    description = "provide a name for my AutoScaling Group"
    type = string
}
variable "min_size" {
    description = "describing minimum number of instances required during launch of ASG"
    type = number
}
variable "max_size" {
    description = "describing maximum number of instances required during launch of ASG"
    type = number
}
variable "desired_capacity" {
    description = "describing number of instances required during launch of ASG"
    type = number
}
variable "subnet_ids" {
    description = "provide a name prefix for my launch template"
    type = list(string)
    default = []
}
variable "key" {
    description = "assuming default key as Name"
    type = string
    default = "Name"
}
variable "tags" {
    description = "provide a name prefix for my launch template"
    type = string
}
variable "propagate_at_launch" {
    description = "Says to add your tag name during launch or not"
    type = bool
    default = true
}
