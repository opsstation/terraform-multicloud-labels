
provider "aws" {
  region = "us-east-1"
}

module "labels" {
  source = "../../" # adjust path

  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-modules"
  attributes  = ["v2"]
  extra_tags = {
    Owner      = "OpsStation"
    CostCenter = "Finance"
  }
}

resource "aws_s3_bucket" "test" {
  bucket = module.labels.id
  tags   = module.labels.tags
}
