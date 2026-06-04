locals {

  organization = "vipul"

  project = "clouddevops"

  environment = "dev"

  common_tags = {

    Environment = local.environment

    Project = local.project

    ManagedBy = "Terraform"

    Owner = "Vipul"

    CostCenter = "Engineering"
  }
}