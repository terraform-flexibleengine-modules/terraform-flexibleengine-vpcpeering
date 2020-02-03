terraform {
  required_version = ">= 0.12.16"
}

module "peering_main2" {
  source = "terraform-flexibleengine-modules/vpcpeering/flexibleengine"

  providers = {
    flexibleengine.requester = flexibleengine.tenant_main
    flexibleengine.accepter = flexibleengine.tenant_accepter
  }

  peer_name = "peering-test-22"

  vpc_req_name       = "vpc-test"

  vpc_acc_name       = "vpc-main"

  req_subnet_cidr = [
    "10.1.0.0/16"
  ]

  acc_subnet_cidr = [
    "192.168.0.0/16"
  ]

  tenant_acc_id = "xxx"

  same_tenant = true
}
