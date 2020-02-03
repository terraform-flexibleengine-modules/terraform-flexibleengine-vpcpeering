# Flexible Engine Peering Terraform Module

Terraform module which creates peering between VPC on Flexible Engine.

## TF Version : 0.12

## Usage : Terraform

This module requires that many providers are created in terraform environment
description.

In case VPC are in the same tenant, don't forget to set **same_tenant** to true in module calling.

Example with 2 providers:

```hcl
provider "flexibleengine" {
  alias     = "tenant_stage"
  user_id   = "xxx"
  password  = "foo_bar"
  tenant_id = var.tenant_id_tenant_stage
  auth_url  = var.auth_url
  region    = var.region
}

provider "flexibleengine" {
  alias     = "tenant_prod"
  user_id   = "xxx"
  password  = "foo_bar"
  tenant_id = var.tenant_id_tenant_prod
  auth_url  = var.auth_url
  region    = var.region
}
```

Example of module call:

```hcl
module "peering_stage_prod" {
  source = "terraform-flexibleengine-modules/vpcpeering/flexibleengine"
  version = "1.0.0"

  providers = {
    flexibleengine.requester = flexibleengine.tenant_prod
    flexibleengine.accepter = flexibleengine.tenant_stage
  }

  peer_name = "peering-stage-prod"

  vpc_req_name       = "vpc-prod"

  vpc_acc_name       = "vpc-stage"

  req_subnet_cidr = [
    "10.10.1.0/24",
    "10.10.2.0/24",
  ]

  acc_subnet_cidr = [
    "192.168.1.0/24",
  ]

  tenant_acc_id = "TENANT_ACC_ID"
}
```

## Usage : Terragrunt

Example of module call:

```hcl
################################
### Terragrunt Configuration ###
################################

terraform {
  source = "terraform-flexibleengine-modules/vpcpeering/flexibleengine"
  version = "1.0.0"
}

include {
  path = find_in_parent_folders()
}

##################
### Parameters ###
##################

inputs = {

  
  providers = {
    flexibleengine.requester = flexibleengine.tenant_prod
    flexibleengine.accepter = flexibleengine.tenant_stage
  }

  peer_name = "peering-stage-prod"

  vpc_req_name       = "vpc-prod"

  vpc_acc_name       = "vpc-stage"

  req_subnet_cidr = [
    "10.10.1.0/24",
    "10.10.2.0/24",
  ]

  acc_subnet_cidr = [
    "192.168.1.0/24",
  ]

  tenant_acc_id = "TENANT_ACC_ID"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acc\_subnet\_cidr | list of accepter's subnet CIDR | list | `<list>` | no |
| peer\_name | Name of the peering connection | string | `` | no |
| req\_subnet\_cidr | list of requester's subnet CIDR | list | `<list>` | no |
| tenant\_acc\_id | tenant ID of the accepter | string | `` | no |
| same\_tenant | Indicates VPC are in the same tenant | boolean | false | no |
| vpc\_acc\_name | Name of accepter's VPC | string | `` | no |
| vpc\_req\_name | Name of the requester's VPC | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| peering\_id | ID of the created peering |
