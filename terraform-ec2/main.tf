provider "aws" {
  region = "us-east-1"
}
######
# EC2 instance
######
resource "aws_instance" "this" {
  count = var.instance_count

  ami                    = var.ami
  instance_type          = var.instance_type
  user_data              = var.user_data
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  monitoring             = var.monitoring
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  ebs_optimized = var.ebs_optimized
  volume_tags   = var.volume_tags


  tags = merge(
    var.tags,
    {
      "Name" = var.instance_count > 1 ? format("%s-%d", var.name, count.index + 1) : var.name
    },
  )
}

