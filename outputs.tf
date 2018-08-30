output "table_arn" {
  description = "Table ARN"
  value = "${aws_dynamodb_table.basic-dynamodb-table.arn}"
}

output "table_name" {
  description = "Table Name"
  value = "${aws_dynamodb_table.basic-dynamodb-table.id}"
}
