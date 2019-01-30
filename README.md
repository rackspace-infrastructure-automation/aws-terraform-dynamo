## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | List of nested attribute definitions. Only required for hash_key (always) and range_key (if used) attributes. Attributes have name and type. Type must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data. i.e. [{ name=<hash_key> type=<data_type>}] | list | - | yes |
| enable\_pay\_per\_request | Controls how you are charged for read and write throughput and how you manage capacity. If True, DynamoDB charges you for the data reads and writes your application performs on your tables. You do not need to specify how much read and write throughput you expect your application to perform because DynamoDB instantly accommodates your workloads as they ramp up or down. [On-Demand Pricing](https://aws.amazon.com/dynamodb/pricing/on-demand/) If False, you specify the number of `read_capacity_units` and `write_capacity_units` per second that you expect your workload to require. [Provisioned Pricing](https://aws.amazon.com/dynamodb/pricing/provisioned/) | string | `false` | no |
| hash\_key | ** Forces new resource ** Must contain only alphanumberic characters, dash (-), underscore (_) or dot (.). Needs to be defined by type in attributes. | string | - | yes |
| point\_in\_time\_recovery | Enable point in time recovery for the table. | string | `false` | no |
| range\_key | ** Forces new resource ** RangeType PrimaryKey Name. If used, it will need to be defined by type in attributes | string | `` | no |
| read\_capacity\_units | Provisioned read throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`. | string | `5` | no |
| table\_encryption | Server side table encryption at rest. i.e. true | false | string | `true` | no |
| table\_name | The name of the table, this needs to be unique within a region. | string | - | yes |
| write\_capacity\_units | Provisioned write throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`. | string | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| table\_arn | Table ARN |
| table\_name | Table Name |

