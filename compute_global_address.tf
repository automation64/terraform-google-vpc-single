resource "google_compute_global_address" "main" {
  project = var.shared__project_id

  address_type  = local.google_compute_global_address.address_type
  description   = local.google_compute_global_address.description
  ip_version    = local.google_compute_global_address.ip_version
  labels        = local.shared__labels
  name          = local.google_compute_global_address.name
  prefix_length = local.google_compute_global_address.prefix_length
  purpose       = local.google_compute_global_address.purpose

  network = google_compute_network.main.self_link
}

resource "google_service_networking_connection" "main" {

  deletion_policy         = local.google_compute_global_address.deletion_policy
  network                 = google_compute_network.main.self_link
  reserved_peering_ranges = [google_compute_global_address.main.name]

  service = "servicenetworking.googleapis.com"
}

resource "null_resource" "dependency_setter" {
  depends_on = [google_service_networking_connection.main]
}
