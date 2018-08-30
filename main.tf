resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.table_name}"
  read_capacity  = "${var.read_capacity_units}"
  write_capacity = "${var.write_capacity_units}"
  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"

  attribute = "${var.attributes}"

  server_side_encryption {
    enabled = "${var.table_encryption}"
  }

  point_in_time_recovery {
    enabled = "${var.point_in_time_recovery}"
  }
}
