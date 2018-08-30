variable "table_name" {
  description = "The name of the table, this needs to be unique within a region."
  type = "string"
}

variable "hash_key" {
  description = "** Forces new resource ** Must contain only alphanumberic characters, dash (-), underscore (_) or dot (.). Needs to be defined by type in attributes."
  type = "string"
}

variable "range_key" {
  description = "** Forces new resource ** RangeType PrimaryKey Name. If used, it will need to be defined by type in attributes"
  type = "string"
  default = ""
}

variable "read_capacity_units" {
  description = "Provisioned read throughput. Should be between 5 and 10000"
  type = "string"
  default = 5
}

variable "table_encryption" {
  description = "Server side table encryption at rest. i.e. true | false"
  type = "string"
  default = true
}

variable "write_capacity_units" {
  description = "Provisioned write throughput. Should be between 5 and 10000."
  type = "string"
  default = 10
}

variable "attributes" {
  description = "List of nested attribute definitions. Only required for hash_key (always) and range_key (if used) attributes. Attributes have name and type. Type must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data. i.e. [{ name=<hash_key> type=<data_type>}]"
  type = "list"
}

variable "point_in_time_recovery" {
  description = "Enable point in time recovery for the table."
  type = "string"
  default = false
}