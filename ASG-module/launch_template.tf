# Define a Launch Template
resource "aws_launch_template" "sample_template" {
  name_prefix   = var.name_prefix
  image_id      = var.ami-id
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg-id
  key_name = var.key_name
  user_data = var.user_data
}
