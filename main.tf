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
 *   attributes = [
 *     {
 *       name = "TestHashKey"
 *       type = "S"
 *     },
 *   ]
 *
 *   environment          = "Test"
 *   hash_key             = "MyHashKey"
 *   read_capacity_units  = 10
 *   table_name           = "myexampletable"
 *   tags                 = "${local.tags}"
 *   write_capacity_units = 5
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
 * **References:**
 *
 * [global secondary index always recreated #3828](https://github.com/terraform-providers/terraform-provider-aws/issues/3828)
 *
 * [DynamoDB Non-Key Attributes Ordering #3807](https://github.com/terraform-providers/terraform-provider-aws/issues/3807)
 */

locals {
  tags {
    Environment     = "${var.environment}"
    Name            = "${var.table_name}"
    ServiceProvider = "Rackspace"
  }
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  billing_mode     = "${var.enable_pay_per_request ? "PAY_PER_REQUEST" : "PROVISIONED" }"
  hash_key         = "${var.hash_key}"
  name             = "${var.table_name}"
  range_key        = "${var.range_key}"
  read_capacity    = "${var.read_capacity_units}"
  stream_enabled   = "${var.stream_enabled}"
  stream_view_type = "${var.stream_enabled ? var.stream_view_type : "" }"
  write_capacity   = "${var.write_capacity_units}"

  attribute              = "${var.attributes}"
  global_secondary_index = "${var.global_secondary_index_maps}"
  local_secondary_index  = "${var.local_secondary_index_maps}"

  point_in_time_recovery {
    enabled = "${var.point_in_time_recovery}"
  }

  server_side_encryption {
    enabled = "${var.table_encryption_cmk}"
  }

  tags = "${merge(
    local.tags,
    var.tags
  )}"
}
