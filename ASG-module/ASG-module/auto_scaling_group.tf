# Define the Auto Scaling Group
resource "aws_autoscaling_group" "sample_ASG" {
  name                 = var.name
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids # Replace with your subnet IDs
  launch_template {
    id = aws_launch_template.sample_template.id
    version = "$Latest"
  }
  # This line links the ASG to the ALB Target Group
  target_group_arns = [aws_lb_target_group.sample_tg.arn]
  tag {
    key = var.key
    value = var.tags
    propagate_at_launch = var.propagate_at_launch
  }
  # Use lifecycle to prevent Terraform from interfering with dynamic scaling changes
  lifecycle {
    ignore_changes = [desired_capacity]
  }
}
