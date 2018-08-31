
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | List of nested attribute definitions. Only required for hash_key (always) and range_key (if used) attributes. Attributes have name and type. Type must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data. i.e. [{ name=<hash_key> type=<data_type>}] | list | - | yes |
| hash_key | ** Forces new resource ** Must contain only alphanumberic characters, dash (-), underscore (_) or dot (.). Needs to be defined by type in attributes. | string | - | yes |
| point_in_time_recovery | Enable point in time recovery for the table. | string | `false` | no |
| range_key | RangeType PrimaryKey Name. If used, it will need to be defined by type in attributes | string | `` | no |
| read_capacity_units | Provisioned read throughput. Should be between 5 and 10000 | string | `5` | no |
| table_encryption | Server side table encryption at rest. i.e. true | false | string | `true` | no |
| table_name | The name of the table, this needs to be unique within a region. | string | - | yes |
| write_capacity_units | Provisioned write throughput. Should be between 5 and 10000. | string | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| table_arn | Table ARN |
| table_name | Table Name |

