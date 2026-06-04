resource "aws_cloudwatch_log_group" "application_logs" {

  name = "/aws/ec2/${local.project}/${local.environment}"

  retention_in_days = 90

  tags = local.common_tags
}

resource "aws_cloudwatch_dashboard" "dashboard" {

  dashboard_name = "${local.project}-${local.environment}-dashboard"

  dashboard_body = jsonencode({

    widgets = []
  })
}