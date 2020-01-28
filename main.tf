/**
 * # aws-terraform-dynamo
 *
 * This module creates an AWS DynamoDB table.
 *
 * ## Basic Usage
 *
 * ```HCL
 * module "basic" {
 *   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-dynamo/?ref=v0.0.3"
 *
 *   environment          = "Test"
 *   hash_key             = "MyHashKey"
 *   read_capacity_units  = 10
 *   table_name           = "myexampletable"
 *   tags                 = "${local.tags}"
 *   write_capacity_units = 5
 *
 *   attributes = [
 *     {
 *       name = "TestHashKey"
 *       type = "S"
 *     },
 *   ]
 * }
 * ```
 *
 * ## Known Bugs
 *
 * When using the index maps for GSI's and LSI's there is a bug in the Terraform AWS provider which stores the order of `non_key_attributes` in the state file in an order that may not match what you pass in.
 *
 * If a subsequent plan shows changes for your indexes look for lines similar to the below in the output:
 *
 * ```
 * global_secondary_index.1708383685.non_key_attributes.0: "data2" => ""
 * global_secondary_index.1708383685.non_key_attributes.1: "data1" => ""
 * global_secondary_index.1708383685.non_key_attributes.2: "data3" => ""
 * ```
 *
 * The input data was `["data1", "data2", "data3"]` and we can see that attributes 0, 1, and 2 do not follow this same order.
 *
 * The resolution at the moment is to edit the list in your map to match the order in the state file. This should result in a clean plan when no other changes are present.
 *
 * __References:__
 *
 * [global secondary index always recreated #3828](https://github.com/terraform-providers/terraform-provider-aws/issues/3828)
 *
 * [DynamoDB Non-Key Attributes Ordering #3807](https://github.com/terraform-providers/terraform-provider-aws/issues/3807)
 *
 * ## Terraform 0.12 upgrade
 *
 * Several changes were required while adding terraform 0.12 compatibility.  The following changes should be
 * made when upgrading from a previous release to version 0.12.0 or higher.
 *
 * ### Module variables
 *
 * The following module variables were updated to better meet current Rackspace style guides:
 *
 * - `table_name` -> `name`
 *
 */

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.1.0"
  }
}

locals {
  tags = {
    Environment     = var.environment
    Name            = var.name
    ServiceProvider = "Rackspace"
  }
}

resource "aws_dynamodb_table" "table" {
  billing_mode     = var.enable_pay_per_request ? "PAY_PER_REQUEST" : "PROVISIONED"
  hash_key         = var.hash_key
  name             = var.name
  range_key        = var.range_key
  read_capacity    = var.enable_pay_per_request ? 0 : var.read_capacity_units
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : ""
  tags             = merge(local.tags, var.tags)
  write_capacity   = var.enable_pay_per_request ? 0 : var.write_capacity_units

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index_maps

    content {
      hash_key           = global_secondary_index.value.hash_key
      name               = global_secondary_index.value.name
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index_maps

    content {
      name               = local_secondary_index.value.name
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = local_secondary_index.value.projection_type
      range_key          = local_secondary_index.value.range_key
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  server_side_encryption {
    enabled = var.table_encryption_cmk
  }

  ttl {
    enabled        = var.enable_ttl
    attribute_name = var.ttl_attribute
  }
}

