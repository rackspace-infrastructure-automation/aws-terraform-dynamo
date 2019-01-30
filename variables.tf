variable "table_name" {
  description = "The name of the table, this needs to be unique within a region."
  type        = "string"
}

variable "enable_pay_per_request" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity. If True, DynamoDB charges you for the data reads and writes your application performs on your tables. You do not need to specify how much read and write throughput you expect your application to perform because DynamoDB instantly accommodates your workloads as they ramp up or down. [On-Demand Pricing](https://aws.amazon.com/dynamodb/pricing/on-demand/) If False, you specify the number of `read_capacity_units` and `write_capacity_units` per second that you expect your workload to require. [Provisioned Pricing](https://aws.amazon.com/dynamodb/pricing/provisioned/)"
  type        = "string"
  default     = false
}

variable "hash_key" {
  description = "** Forces new resource ** Must contain only alphanumberic characters, dash (-), underscore (_) or dot (.). Needs to be defined by type in attributes."
  type        = "string"
}

variable "range_key" {
  description = "** Forces new resource ** RangeType PrimaryKey Name. If used, it will need to be defined by type in attributes"
  type        = "string"
  default     = ""
}

variable "read_capacity_units" {
  description = "Provisioned read throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`."
  type        = "string"
  default     = 5
}

variable "table_encryption" {
  description = "Server side table encryption at rest. i.e. true | false"
  type        = "string"
  default     = true
}

variable "write_capacity_units" {
  description = "Provisioned write throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`."
  type        = "string"
  default     = 10
}

variable "attributes" {
  description = "List of nested attribute definitions. Only required for hash_key (always) and range_key (if used) attributes. Attributes have name and type. Type must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data. i.e. [{ name=<hash_key> type=<data_type>}]"
  type        = "list"
}

variable "point_in_time_recovery" {
  description = "Enable point in time recovery for the table."
  type        = "string"
  default     = false
}
