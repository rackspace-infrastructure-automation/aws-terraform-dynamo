terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.7"
  region  = "us-west-2"
}

module "dynamo_table_provisioned" {
  source = "git@github.com/rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=v0.12.0"

  enable_pay_per_request = false
  hash_key               = "<HashKeyName>"
  name                   = "<TableName>"
  point_in_time_recovery = true
  range_key              = "<RangeKey>"
  read_capacity_units    = 5
  table_encryption       = true
  write_capacity_units   = 10

  attributes = [
    {
      name = "<HashKeyName>"
      type = "S"
    },
    {
      name = "<RangeKey>"
      type = "N"
    },
  ]
}

module "dynamo_table_pay_per_requst" {
  source = "git@github.com/rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=v0.12.0"

  enable_pay_per_request = true
  hash_key               = "<HashKeyName>"
  name                   = "<TableName>"
  point_in_time_recovery = true
  range_key              = "<RangeKey>"
  table_encryption       = true

  attributes = [
    {
      name = "<HashKeyName>"
      type = "S"
    },
    {
      name = "<RangeKey>"
      type = "N"
    },
  ]
}

