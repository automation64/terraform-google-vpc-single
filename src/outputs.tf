#
# Shared
#

output "shared__labels" {
  description = "Module wide labels"
  value       = local.shared__labels
}

#
# Google Compute Network
#

output "google_compute_network" {
  description = "Google Compute Network"
  value       = google_compute_network.main
}

#
# Google Compute SubNetwork
#

output "google_compute_subnetwork" {
  description = "Google Compute SubNetwork"
  value = {
    dmz     = google_compute_subnetwork.dmz
    private = google_compute_subnetwork.private
  }
}

#
# Google Compute Router
#

output "google_compute_router" {
  description = "Google Compute Router"
  value       = google_compute_router.main
}

#
# Google Compute Global Address
#

output "google_compute_global_address" {
  description = "Google Compute Global Address"
  value       = google_compute_global_address.main
}

#
# Google Compute Firewall
#

output "google_compute_firewall" {
  description = "Google Compute Firewall"
  value = {
    iap_ssh = google_compute_firewall.iap_ssh
  }
}
