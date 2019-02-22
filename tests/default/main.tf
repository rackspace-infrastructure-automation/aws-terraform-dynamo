provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

locals {
  tags = {
    Terraform = "true"
  }
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
  tags                 = "${local.tags}"
  write_capacity_units = 11
}

module "advanced" {
  source = "../../module"

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
  point_in_time_recovery = true
  range_key              = "TestRangeKey"
  read_capacity_units    = 20
  table_encryption_cmk   = true
  table_name             = "${random_string.rstring.result}-advanced"
  tags                   = "${local.tags}"
  write_capacity_units   = 5
}

module "complex" {
  source = "../../module"

  attributes = [
    {
      name = "TestHashKey"
      type = "S"
    },
    {
      name = "TestRangeKey"
      type = "S"
    },
    {
      name = "GsiHashKey01"
      type = "S"
    },
    {
      name = "GsiHashKey02"
      type = "S"
    },
    {
      name = "GsiRangeKey01"
      type = "S"
    },
    {
      name = "GsiRangeKey02"
      type = "S"
    },
  ]

  environment = "Test"

  global_secondary_index_maps = [
    {
      name            = "TestGSIProject"
      write_capacity  = "5"
      read_capacity   = "10"
      hash_key        = "GsiHashKey01"
      range_key       = "GsiRangeKey01"
      projection_type = "ALL"
    },
    {
      name            = "TestGSIInclude"
      write_capacity  = "5"
      read_capacity   = "10"
      hash_key        = "GsiHashKey02"
      range_key       = "GsiRangeKey02"
      projection_type = "INCLUDE"

      non_key_attributes = [
        "data2",
        "data1",
        "data3",
      ]
    },
  ]

  hash_key = "TestHashKey"

  local_secondary_index_maps = [
    {
      name            = "TestLSIProjectAll"
      range_key       = "TestRangeKey"
      projection_type = "ALL"
    },
    {
      name            = "TestLSIInclude"
      range_key       = "TestRangeKey"
      projection_type = "INCLUDE"

      non_key_attributes = [
        "data1",
        "data2",
        "data3",
      ]
    },
  ]

  point_in_time_recovery = true
  range_key              = "TestRangeKey"
  read_capacity_units    = 20
  stream_enabled         = true
  stream_view_type       = "NEW_AND_OLD_IMAGES"
  table_encryption_cmk   = true
  table_name             = "${random_string.rstring.result}-complex"
  tags                   = "${local.tags}"
  write_capacity_units   = 5
}