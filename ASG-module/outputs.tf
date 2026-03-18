output "ASG_id" {
  value = aws_autoscaling_group.sample_ASG.id
  description = "captures the AutoScaling Group id"
}

output "asg_name" {
  value = aws_autoscaling_group.sample_ASG.name
}
