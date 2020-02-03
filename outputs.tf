output "peering_id" {
  description = "ID of the created peering"
  value       = flexibleengine_vpc_peering_connection_v2.peering.id
}

