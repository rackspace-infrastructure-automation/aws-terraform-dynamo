provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

module "dynamo_table_provisioned" {
  source = "git@github.com/rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=v0.0.6"

  table_name             = "<TableName>"
  hash_key               = "<HashKeyName>"
  range_key              = "<RangeKey>"
  enable_pay_per_request = false
  read_capacity_units    = 5
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

  table_encryption = true

  point_in_time_recovery = true
}

module "dynamo_table_pay_per_requst" {
  source = "git@github.com/rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=v0.0.6"

  table_name             = "<TableName>"
  hash_key               = "<HashKeyName>"
  range_key              = "<RangeKey>"
  enable_pay_per_request = true

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

  table_encryption = true

  point_in_time_recovery = true
}
