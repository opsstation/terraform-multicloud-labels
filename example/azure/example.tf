
provider "azurerm" {
  features {}
}


module "labels" {
  source = "../../"

  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-modules"
  attributes  = ["v2"]
  extra_tags = {
    Owner      = "OpsStation"
    CostCenter = "Finance"
  }
}

resource "azurerm_resource_group" "test" {
  name     = module.labels.id
  location = "eastus"
  tags     = module.labels.tags
}