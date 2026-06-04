resource "aws_security_group" "app_sg" {

  name = "${local.organization}-${local.project}-${local.environment}-sg"

  description = "Security Group for FastAPI Application"

  ingress {

    description = "SSH Access"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = var.allowed_ssh_cidr
  }

  ingress {

    description = "Application Access"

    from_port = 8000

    to_port = 8000

    protocol = "tcp"

    cidr_blocks = var.allowed_app_cidr
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}