resource "google_compute_firewall" "iap_ssh" {
  project = var.shared__project_id

  network = google_compute_network.main.self_link

  description   = local.google_compute_firewall.iap_ssh.description
  direction     = local.google_compute_firewall.iap_ssh.direction
  name          = local.google_compute_firewall.iap_ssh.name
  source_ranges = local.google_compute_firewall.iap_ssh.source_ranges #tfsec:ignore:google-compute-no-public-ingress

  allow {
    protocol = local.google_compute_firewall.iap_ssh.allow.protocol
    ports    = local.google_compute_firewall.iap_ssh.allow.ports
  }
}
