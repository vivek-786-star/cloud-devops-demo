# Security Group
resource "aws_security_group" "cdd_dev_sg" {

  name = "cdd-dev-sg"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "FastAPI"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Role
resource "aws_iam_role" "cdd_dev_role" {

  name = "cdd-dev-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# CloudWatch Policy
resource "aws_iam_role_policy_attachment" "cloudwatch" {

  role       = aws_iam_role.cdd_dev_role.name

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Instance Profile
resource "aws_iam_instance_profile" "cdd_dev_profile" {

  name = "cdd-dev-profile"

  role = aws_iam_role.cdd_dev_role.name
}

# Get Latest Amazon Linux
data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}

# EC2
resource "aws_instance" "cdd_dev_ec2" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.cdd_dev_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.cdd_dev_profile.name

  tags = {
    Name = "cdd-dev-ec2"
  }
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "logs" {

  name = "cdd-dev-logs"

  retention_in_days = 14
}