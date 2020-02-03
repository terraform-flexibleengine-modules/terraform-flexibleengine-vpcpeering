provider "flexibleengine" {
  alias       = "tenant_xxx"
  domain_name = "xxxx"
  tenant_name = "eu-west-0"
  auth_url    = "https://iam.eu-west-0.prod-cloud-ocb.orange-business.com/v3"
  region      = "eu-west-0"
}

provider "flexibleengine" {
  alias       = "tenant_main"
  domain_name = "xxxxx"
  tenant_name = "eu-west-0"
  auth_url    = "https://iam.eu-west-0.prod-cloud-ocb.orange-business.com/v3"
  region      = "eu-west-0"
}
