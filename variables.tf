variable "attributes" {
  description = "List of nested attribute definitions. Only required for hash_key's (always) and range_key's (if used) attributes. Attributes have name and type. Type must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data. i.e. [{ name=<hash_key> type=<data_type>}]. Terraform documentation: [A note about attributes](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#a-note-about-attributes)"
  type        = "list"
}

variable "enable_pay_per_request" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity. If True, DynamoDB charges you for the data reads and writes your application performs on your tables. You do not need to specify how much read and write throughput you expect your application to perform because DynamoDB instantly accommodates your workloads as they ramp up or down. [On-Demand Pricing](https://aws.amazon.com/dynamodb/pricing/on-demand/) If False, you specify the number of `read_capacity_units` and `write_capacity_units` per second that you expect your workload to require. [Provisioned Pricing](https://aws.amazon.com/dynamodb/pricing/provisioned/)"
  type        = "string"
  default     = false
}

variable "environment" {
  description = "Application environment for which this resource is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test."
  type        = "string"
  default     = "Development"
}

variable "global_secondary_index_maps" {
  description = "A list of maps for each [global secondary index (GSI)](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#global_secondary_index-1). Please see [examples](./examples) for usage."
  type        = "list"
  default     = []
}

variable "hash_key" {
  description = "**Forces new resource!** Must contain only alphanumberic characters, dash (-), underscore (_) or dot (.). Needs to be defined by type in attributes."
  type        = "string"
}

variable "local_secondary_index_maps" {
  description = "A list of maps for each [local secondary index (LSI)](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#local_secondary_index-1). Please see [examples](./examples) for usage."
  type        = "list"
  default     = []
}

variable "point_in_time_recovery" {
  description = "Enable point in time recovery for the table."
  type        = "string"
  default     = false
}

variable "range_key" {
  description = "**Forces new resource!** RangeType PrimaryKey Name. If used, it will need to be defined by type in attributes"
  type        = "string"
  default     = ""
}

variable "read_capacity_units" {
  description = "Provisioned read throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`."
  type        = "string"
  default     = 5
}

variable "stream_enabled" {
  description = "Enable the stream setting on the table."
  type        = "string"
  default     = "false"
}

variable "stream_view_type" {
  description = "If using `stream_enabled, you can specify a valid DynamoDB StreamViewType; must be one of: `KEYS_ONLY`, `NEW_IMAGE`. `OLD_IMAGE`, `NEW_AND_OLD_IMAGES`"
  type        = "string"
  default     = ""
}

variable "table_encryption_cmk" {
  description = "You may choose to use an [AWS Managed CMK](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) by setting this to `true`. Otherwise, server side table encryption defaults to an [AWS Owned CMK](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-owned-cmk)."
  type        = "string"
  default     = false
}

variable "table_name" {
  description = "The name of the table, this needs to be unique within a region."
  type        = "string"
}

variable "tags" {
  description = "Custom tags to apply to all resources."
  type        = "map"
  default     = {}
}

variable "write_capacity_units" {
  description = "Provisioned write throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`."
  type        = "string"
  default     = 10
}
