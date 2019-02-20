provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

locals {
  tags = {
    Environment     = "Test"
    ServiceProvider = "Rackspace"
    Terraform       = "true"
  }
}

resource "random_string" "prefix" {
  length  = 8
  upper   = false
  special = false
}

module "advanced" {
  source = "../../"

  attributes = [
    {
      name = "TestHashKey"
      type = "S"
    },
    {
      name = "TestRangeKey"
      type = "S"
    },
  ]

  environment            = "Test"
  hash_key               = "TestHashKey"
  point_in_time_recovery = "true"
  range_key              = "TestRangeKey"
  read_capacity_units    = 20
  table_encryption_cmk   = "true"
  table_name             = "${random_string.prefix.result}-advanced"
  tags                   = "${local.tags}"
  write_capacity_units   = 5
}
