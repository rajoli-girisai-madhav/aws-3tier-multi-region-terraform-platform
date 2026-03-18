# Define the Target group for Load Balancer
resource "aws_lb_target_group" "sample_tg" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Define listener to the Load Balancer
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.sample_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sample_tg.arn
  }
}
