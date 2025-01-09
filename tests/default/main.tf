terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

locals {
  tags = {
    Terraform = "true"
  }
}

resource "random_string" "rstring" {
  length  = 8
  special = false
  upper   = false
}

module "dynamo" {
  source = "../../module"

  hash_key             = "TestHashKey"
  read_capacity_units  = 6
  name                 = "${random_string.rstring.result}-Basic"
  tags                 = local.tags
  write_capacity_units = 11

  attributes = [
    {
      name = "TestHashKey"
      type = "S"
    },
  ]
}

module "advanced" {
  source = "../../module"

  environment            = "Test"
  hash_key               = "TestHashKey"
  name                   = "${random_string.rstring.result}-Advanced"
  point_in_time_recovery = true
  range_key              = "TestRangeKey"
  read_capacity_units    = 20
  table_encryption_cmk   = true
  tags                   = local.tags
  write_capacity_units   = 5

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
}

module "complex" {
  source = "../../module"

  enable_ttl             = true
  environment            = "Test"
  hash_key               = "TestHashKey"
  name                   = "${random_string.rstring.result}-Complex"
  point_in_time_recovery = true
  range_key              = "TestRangeKey"
  read_capacity_units    = 20
  stream_enabled         = true
  stream_view_type       = "NEW_AND_OLD_IMAGES"
  table_encryption_cmk   = true
  tags                   = local.tags
  ttl_attribute          = "ttl"
  write_capacity_units   = 5

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

  global_secondary_index_maps = [
    {
      hash_key        = "GsiHashKey01"
      name            = "TestGSIProject"
      projection_type = "ALL"
      range_key       = "GsiRangeKey01"
      read_capacity   = "10"
      write_capacity  = "5"
    },
    {
      hash_key        = "GsiHashKey02"
      name            = "TestGSIInclude"
      projection_type = "INCLUDE"
      range_key       = "GsiRangeKey02"
      read_capacity   = "10"
      write_capacity  = "5"

      non_key_attributes = [
        "data2",
        "data1",
        "data3",
      ]
    },
  ]

  local_secondary_index_maps = [
    {
      name            = "TestLSIProjectAll"
      projection_type = "ALL"
      range_key       = "TestRangeKey"
    },
    {
      name            = "TestLSIInclude"
      projection_type = "INCLUDE"
      range_key       = "TestRangeKey"

      non_key_attributes = [
        "data1",
        "data2",
        "data3",
      ]
    },
  ]
}

