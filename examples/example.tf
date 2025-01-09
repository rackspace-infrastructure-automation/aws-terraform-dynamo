terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "dynamo_table_provisioned" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=v0.12.2"

  enable_pay_per_request = false
  hash_key               = "user_id"
  name                   = "corp_office"
  point_in_time_recovery = true
  range_key              = "department_id"
  read_capacity_units    = 5
  table_encryption_cmk   = true
  write_capacity_units   = 10

  attributes = [
    {
      name = "user_id"
      type = "S"
    },
    {
      name = "department_id"
      type = "N"
    },
  ]
}

module "dynamo_table_pay_per_requst" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=v0.12.2"

  enable_pay_per_request = true
  hash_key               = "user_id"
  name                   = "branch_office"
  point_in_time_recovery = true
  range_key              = "department_id"
  table_encryption_cmk   = true

  attributes = [
    {
      name = "user_id"
      type = "S"
    },
    {
      name = "department_id"
      type = "N"
    },
  ]
}
