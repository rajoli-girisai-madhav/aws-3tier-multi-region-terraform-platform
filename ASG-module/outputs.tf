output "ASG_id" {
  value = aws_autoscaling_group.sample_ASG.id
  description = "captures the AutoScaling Group id"
}

output "asg_name" {
  value = aws_autoscaling_group.sample_ASG.name
}

output "alb_dns_name" {
  value       = aws_lb.sample_alb.dns_name
  description = "ALB DNS name"
}

output "alb_arn" {
  value = aws_lb.sample_alb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.sample_tg.arn
}
