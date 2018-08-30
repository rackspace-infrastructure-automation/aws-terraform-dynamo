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
  table_name = "${random_string.rstring.result}-testTable"
  hash_key = "TestHashKey"
  read_capacity_units = 6
  write_capacity_units = 11
  attributes = [
    {
      name="TestHashKey"
      type="S"
    }
  ]

}