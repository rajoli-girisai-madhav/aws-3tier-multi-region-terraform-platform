# Define Application Load Balancer
resource "aws_lb" "sample_alb" {
  name               = var.alb_name
  internal           = var.scheme
  load_balancer_type = "application"
  security_groups    = var.sg-id
  subnets            = var.subnet_ids
}
