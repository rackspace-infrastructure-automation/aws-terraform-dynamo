# aws-terraform-dynamo

This module creates an AWS DynamoDB table.

## Basic Usage

```HCL
module "basic" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-dynamo/?ref=v0.0.3"

  attributes = [
    {
      name = "TestHashKey"
      type = "S"
    },
  ]

  environment          = "Test"
  hash_key             = "MyHashKey"
  read_capacity_units  = 10
  table_name           = "myexampletable"
  tags                 = "${local.tags}"
  write_capacity_units = 5
}
```

## Known Bugs

When using the index maps for GSI's and LSI's there is a bug in the Terraform AWS provider which stores the order of `non_key_attributes` in the state file in an order that may not match what you pass in.

If a subsequent plan shows changes for your indexes look for lines similar to the below in the output:

```
global_secondary_index.1708383685.non_key_attributes.0: "data2" => ""
global_secondary_index.1708383685.non_key_attributes.1: "data1" => ""
global_secondary_index.1708383685.non_key_attributes.2: "data3" => ""
```

The input data was `["data1", "data2", "data3"]` and we can see that attributes 0, 1, and 2 do not follow this same order.

The resolution at the moment is to edit the list in your map to match the order in the state file. This should result in a clean plan when no other changes are present.

**References:**

[global secondary index always recreated #3828](https://github.com/terraform-providers/terraform-provider-aws/issues/3828)

[DynamoDB Non-Key Attributes Ordering #3807](https://github.com/terraform-providers/terraform-provider-aws/issues/3807)

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attributes | List of nested attribute definitions. Only required for hash\_key's (always) and range\_key's (if used) attributes. Attributes have name and type. Type must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data. i.e. [{ name=<hash\_key> type=<data\_type>}]. Terraform documentation: [A note about attributes](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#a-note-about-attributes) | `list` | n/a | yes |
| enable\_pay\_per\_request | Controls how you are charged for read and write throughput and how you manage capacity. If True, DynamoDB charges you for the data reads and writes your application performs on your tables. You do not need to specify how much read and write throughput you expect your application to perform because DynamoDB instantly accommodates your workloads as they ramp up or down. [On-Demand Pricing](https://aws.amazon.com/dynamodb/pricing/on-demand/) If False, you specify the number of `read_capacity_units` and `write_capacity_units` per second that you expect your workload to require. [Provisioned Pricing](https://aws.amazon.com/dynamodb/pricing/provisioned/) | `string` | `false` | no |
| enable\_ttl | Enable time to live on record. | `string` | `false` | no |
| environment | Application environment for which this resource is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test. | `string` | `"Development"` | no |
| global\_secondary\_index\_maps | A list of maps for each [global secondary index (GSI)](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#global_secondary_index-1). Please see [examples](./examples) for usage. | `list` | `[]` | no |
| hash\_key | **Forces new resource!** Must contain only alphanumberic characters, dash (-), underscore (\_) or dot (.). Needs to be defined by type in attributes. | `string` | n/a | yes |
| local\_secondary\_index\_maps | A list of maps for each [local secondary index (LSI)](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#local_secondary_index-1). Please see [examples](./examples) for usage. | `list` | `[]` | no |
| point\_in\_time\_recovery | Enable point in time recovery for the table. | `string` | `false` | no |
| range\_key | **Forces new resource!** RangeType PrimaryKey Name. If used, it will need to be defined by type in attributes | `string` | `""` | no |
| read\_capacity\_units | Provisioned read throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`. | `string` | `5` | no |
| stream\_enabled | Enable the stream setting on the table. | `string` | `false` | no |
| stream\_view\_type | If using `stream_enabled, you can specify a valid DynamoDB StreamViewType; must be one of: `KEYS\_ONLY`, `NEW\_IMAGE`. `OLD\_IMAGE`, `NEW\_AND\_OLD\_IMAGES | `string` | `""` | no |
| table\_encryption\_cmk | You may choose to use an [AWS Managed CMK](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) by setting this to `true`. Otherwise, server side table encryption defaults to an [AWS Owned CMK](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-owned-cmk). | `string` | `false` | no |
| table\_name | The name of the table, this needs to be unique within a region. | `string` | n/a | yes |
| tags | Custom tags to apply to all resources. | `map` | `{}` | no |
| ttl\_attribute | The name of the table attribute to store the TTL timestamp in | `string` | `""` | no |
| write\_capacity\_units | Provisioned write throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`. | `string` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| stream\_arn | ARN for the stream if `stream_enabled` was set to `true`, otherwise returns a string of "null". |
| table\_arn | Table ARN |
| table\_name | Table Name |

