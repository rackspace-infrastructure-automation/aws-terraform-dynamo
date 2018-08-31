provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

module "dynamo" {
  source = "git@github.com/rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=v0.0.1"

  table_name           = "<TableName>"
  hash_key             = "<HashKeyName>"
  range_key            = "<RangeKey>"
  read_capacity_units  = 5
  write_capacity_units = 10

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
