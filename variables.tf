variable "peer_name" {
  description = "Name of the peering connection"
  default     = ""
}

variable "tenant_acc_id" {
  description = "tenant ID of the accepter"
  default     = ""
}

variable "vpc_req_name" {
  description = "Name of the requester's VPC"
  default     = ""
}

variable "vpc_acc_name" {
  description = "Name of accepter's VPC"
  default     = ""
}

variable "req_subnet_cidr" {
  description = "list of requester's subnet CIDR"
  default     = []
}

variable "acc_subnet_cidr" {
  description = "list of accepter's subnet CIDR"
  default     = []
}

variable "same_tenant" {
  description = "Indicates VPC are in the same tenant"
  default     = false
}
