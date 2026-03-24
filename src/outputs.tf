#
# Google Compute Network
#

output "google_compute_network" {
  description = "Google Compute Network Attributes"
  value       = google_compute_network.main
}

#
# Google Compute SubNetwork
#

output "google_compute_subnetwork" {
  description = "Google Compute SubNetwork Attributes"
  value = {
    dmz     = google_compute_subnetwork.dmz
    private = google_compute_subnetwork.private
  }
}

#
# Google Compute Router
#

output "google_compute_router" {
  description = "Google Compute Router Attributes"
  value       = google_compute_router.main
}
