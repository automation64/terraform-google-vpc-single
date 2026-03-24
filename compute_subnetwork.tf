resource "google_compute_subnetwork" "dmz" {
  ip_cidr_range = var.google_compute_subnetwork.ip_cidr_range.dmz
  region        = var.shared__location

  network     = google_compute_network.main.id
  project     = google_compute_network.main.project
  description = local.google_compute_subnetwork.description.dmz
  name        = local.google_compute_subnetwork.name.dmz
  stack_type  = local.google_compute_subnetwork.stack_type
  purpose     = local.google_compute_subnetwork.purpose

  private_ip_google_access = false
}

resource "google_compute_subnetwork" "private" {
  ip_cidr_range = var.google_compute_subnetwork.ip_cidr_range.private
  region        = var.shared__location

  network     = google_compute_network.main.id
  project     = google_compute_network.main.project
  description = local.google_compute_subnetwork.description.private
  name        = local.google_compute_subnetwork.name.private
  stack_type  = local.google_compute_subnetwork.stack_type
  purpose     = local.google_compute_subnetwork.purpose

  private_ip_google_access = true

  dynamic "log_config" {
    for_each = var.google_compute_subnetwork__log_config != null ? [var.google_compute_subnetwork__log_config] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = "INCLUDE_ALL_METADATA"
    }
  }
}
