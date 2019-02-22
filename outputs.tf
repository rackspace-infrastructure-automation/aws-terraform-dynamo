output "stream_arn" {
  description = "ARN for the stream if `stream_enabled` was set to `true`, otherwise returns a string of \"null\"."
  value       = "${var.stream_enabled == "true" ? aws_dynamodb_table.basic-dynamodb-table.stream_arn : "null" }"
}

output "table_arn" {
  description = "Table ARN"
  value       = "${aws_dynamodb_table.basic-dynamodb-table.arn}"
}

output "table_name" {
  description = "Table Name"
  value       = "${aws_dynamodb_table.basic-dynamodb-table.id}"
}
