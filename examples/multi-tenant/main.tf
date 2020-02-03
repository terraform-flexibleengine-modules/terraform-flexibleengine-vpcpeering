terraform {
  required_version = ">= 0.12.16"
}

module "peering_main" {
  source = "terraform-flexibleengine-modules/vpcpeering/flexibleengine"

  providers = {
    flexibleengine.requester = flexibleengine.tenant_xxx
    flexibleengine.accepter = flexibleengine.tenant_main
  }

  peer_name = "peering-xxx"

  vpc_req_name       = "vpc-xxx"

  vpc_acc_name       = "vpc-main"

  req_subnet_cidr = [
    "10.2.0.0/16"
  ]

  acc_subnet_cidr = [
    "192.168.0.0/16"
  ]

  tenant_acc_id = "xxx"
}
