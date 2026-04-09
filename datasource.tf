# Declare the data source for Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
# Get latest AMI ID for Ubuntu OS
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Get instances created by ASG
data "aws_autoscaling_group" "web_asg" {
  name       = module.Web-Tier.asg_name
  depends_on  = [module.Web-Tier]
}

# Fetch instance IDs from ASG
data "aws_instances" "web_asg_instances" {
  depends_on = [data.aws_autoscaling_group.web_asg]

  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [module.Web-Tier.asg_name]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

# Fetch EC2 instance details
data "aws_instance" "web_instances" {
  for_each    = toset(data.aws_instances.web_asg_instances.ids)
  instance_id = each.value

  depends_on = [data.aws_instances.web_asg_instances]
}
}

# Get instances created by ASG
data "aws_autoscaling_group" "app_asg" {
  name       = module.App-Tier.asg_name
  depends_on  = [module.App-Tier]
}

# Fetch instance IDs from ASG
data "aws_instances" "app_asg_instances" {
  depends_on = [data.aws_autoscaling_group.app_asg]

  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [module.App-Tier.asg_name]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

# Fetch EC2 instance details
data "aws_instance" "app_instances" {
  for_each    = toset(data.aws_instances.app_asg_instances.ids)
  instance_id = each.value

  depends_on = [data.aws_instances.app_asg_instances]
}
