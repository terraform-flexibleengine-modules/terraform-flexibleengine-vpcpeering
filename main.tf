# init provider
provider "flexibleengine" {
  alias = "requester"
}

provider "flexibleengine" {
  alias = "accepter"
}

# Get IDs of VPC
data "flexibleengine_vpc_v1" "vpc_req" {
  # Get the ID of VPC requester
  provider = flexibleengine.requester
  name     = var.vpc_req_name
}

data "flexibleengine_vpc_v1" "vpc_acc" {
  # Get the ID of VPC peer
  provider = flexibleengine.accepter
  name     = var.vpc_acc_name
}

# Requester's side of the connection.
resource "flexibleengine_vpc_peering_connection_v2" "peering" {
  provider       = flexibleengine.requester
  name           = var.peer_name
  vpc_id         = data.flexibleengine_vpc_v1.vpc_req.id
  peer_vpc_id    = data.flexibleengine_vpc_v1.vpc_acc.id
  peer_tenant_id = var.tenant_acc_id
}

# Accepter's side of the connection. In other Tenant
resource "flexibleengine_vpc_peering_connection_accepter_v2" "peer" {
  count                     = var.same_tenant ? 0 : 1
  provider                  = flexibleengine.accepter
  vpc_peering_connection_id = flexibleengine_vpc_peering_connection_v2.peering.id
  accept                    = true
}

# Add route in peering
# Requester's side
resource "flexibleengine_vpc_route_v2" "req_vpc_route" {
  provider    = flexibleengine.requester
  count       = length(var.acc_subnet_cidr) > 0 ? length(var.acc_subnet_cidr) : 0
  type        = "peering"
  nexthop     = flexibleengine_vpc_peering_connection_v2.peering.id
  destination = element(var.acc_subnet_cidr, count.index)
  vpc_id      = data.flexibleengine_vpc_v1.vpc_req.id
  depends_on = [
    flexibleengine_vpc_peering_connection_v2.peering,
    flexibleengine_vpc_peering_connection_accepter_v2.peer,
  ]
}

# Accepter's side in other tenant
resource "flexibleengine_vpc_route_v2" "acc_vpc_route" {
  provider    = flexibleengine.accepter
  count       = length(var.req_subnet_cidr) > 0 ? length(var.req_subnet_cidr) : 0
  type        = "peering"
  nexthop     = flexibleengine_vpc_peering_connection_v2.peering.id
  destination = element(var.req_subnet_cidr, count.index)
  vpc_id      = data.flexibleengine_vpc_v1.vpc_acc.id
  depends_on = [
    flexibleengine_vpc_peering_connection_v2.peering,
    flexibleengine_vpc_peering_connection_accepter_v2.peer,
  ]
}

