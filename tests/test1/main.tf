provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

resource "random_string" "rstring" {
  length  = 8
  upper   = false
  special = false
}

module "dynamo" {
  source = "../../module"

  attributes = [
    {
      name = "TestHashKey"
      type = "S"
    },
  ]

  hash_key             = "TestHashKey"
  read_capacity_units  = 6
  table_name           = "${random_string.rstring.result}-testTable"
  write_capacity_units = 11
}
