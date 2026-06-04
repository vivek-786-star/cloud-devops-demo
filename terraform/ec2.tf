data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {

    name = "name"

    values = ["al2023-ami-2023*"]
  }

  filter {

    name = "architecture"

    values = ["x86_64"]
  }
}

resource "aws_instance" "app_server" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type

  key_name = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  monitoring = true

  metadata_options {

    http_endpoint = "enabled"

    http_tokens = "required"
  }

  root_block_device {

    encrypted = true

    volume_size = 20

    volume_type = "gp3"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.organization}-${local.project}-${local.environment}-ec2"
    }
  )
}