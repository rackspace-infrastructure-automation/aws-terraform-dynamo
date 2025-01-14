# aws-terraform-dynamo

This module creates an AWS DynamoDB table.

## Basic Usage

```HCL
module "basic" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-dynamo/?ref=v0.12.2"

  environment          = "Test"
  hash_key             = "MyHashKey"
  read_capacity_units  = 10
  name                 = "myexampletable"
  tags                 = local.tags
  write_capacity_units = 5

  attributes = [
    {
      name = "TestHashKey"
      type = "S"
    },
  ]
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

\_\_References:\_\_

[global secondary index always recreated #3828](https://github.com/terraform-providers/terraform-provider-aws/issues/3828)

[DynamoDB Non-Key Attributes Ordering #3807](https://github.com/terraform-providers/terraform-provider-aws/issues/3807)

## Terraform 0.12 upgrade

Several changes were required while adding terraform 0.12 compatibility.  The following changes should be  
made when upgrading from a previous release to version 0.12.0 or higher.

### Module variables

The following module variables were updated to better meet current Rackspace style guides:

- `table_name` -> `name`

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/4.0/docs/resources/dynamodb_table) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | List of nested attribute definitions. Only required for hash\_key's (always) and range\_key's (if used) attributes. Attributes have name and type. Type must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data. i.e. [{ name=<hash\_key> type=<data\_type>}]. Terraform documentation: [A note about attributes](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#a-note-about-attributes) | `list(map(string))` | n/a | yes |
| enable\_pay\_per\_request | Controls how you are charged for read and write throughput and how you manage capacity. If True, DynamoDB charges you for the data reads and writes your application performs on your tables. You do not need to specify how much read and write throughput you expect your application to perform because DynamoDB instantly accommodates your workloads as they ramp up or down. [On-Demand Pricing](https://aws.amazon.com/dynamodb/pricing/on-demand/) If False, you specify the number of `read_capacity_units` and `write_capacity_units` per second that you expect your workload to require. [Provisioned Pricing](https://aws.amazon.com/dynamodb/pricing/provisioned/) | `bool` | `false` | no |
| enable\_ttl | Enable time to live on record. | `bool` | `false` | no |
| environment | Application environment for which this resource is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test. | `string` | `"Development"` | no |
| global\_secondary\_index\_maps | A list of maps for each [global secondary index (GSI)](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#global_secondary_index-1). Please see [examples](./examples) for usage. | `any` | `[]` | no |
| hash\_key | **Forces new resource!** Must contain only alphanumberic characters, dash (-), underscore (\_) or dot (.). Needs to be defined by type in attributes. | `string` | n/a | yes |
| local\_secondary\_index\_maps | A list of maps for each [local secondary index (LSI)](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html#local_secondary_index-1). Please see [examples](./examples) for usage. | `any` | `[]` | no |
| name | The name of the table, this needs to be unique within a region. | `string` | n/a | yes |
| point\_in\_time\_recovery | Enable point in time recovery for the table. | `bool` | `false` | no |
| range\_key | **Forces new resource!** RangeType PrimaryKey Name. If used, it will need to be defined by type in attributes | `string` | `""` | no |
| read\_capacity\_units | Provisioned read throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`. | `number` | `5` | no |
| stream\_enabled | Enable the stream setting on the table. | `bool` | `false` | no |
| stream\_view\_type | If using `stream_enabled, you can specify a valid DynamoDB StreamViewType; must be one of: `KEYS\_ONLY`, `NEW\_IMAGE`. `OLD\_IMAGE`, `NEW\_AND\_OLD\_IMAGES | `string` | `""` | no |
| table\_encryption\_cmk | You may choose to use an [AWS Managed CMK](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) by setting this to `true`. Otherwise, server side table encryption defaults to an [AWS Owned CMK](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-owned-cmk). | `bool` | `false` | no |
| tags | Custom tags to apply to all resources. | `map(string)` | `{}` | no |
| ttl\_attribute | The name of the table attribute to store the TTL timestamp in | `string` | `""` | no |
| write\_capacity\_units | Provisioned write throughput. Should be between 5 and 10000. Ignored if `enable_pay_per_request` is set to `true`. | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| stream\_arn | ARN for the stream if `stream_enabled` was set to `true`, otherwise returns a string of "null". |
| table\_arn | Table ARN |
| table\_name | Table Name |
