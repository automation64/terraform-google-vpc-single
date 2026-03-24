resource "google_compute_network" "main" {
  project      = var.shared__project_id
  description  = var.google_compute_network.description
  routing_mode = var.google_compute_network.routing_mode

  name                            = local.google_compute_network.name
  auto_create_subnetworks         = local.google_compute_network.auto_create_subnetworks
  delete_default_routes_on_create = local.google_compute_network.delete_default_routes_on_create
}
