resource "google_compute_router" "main" {
  name        = local.google_compute_router.name
  description = local.google_compute_router.description

  network = google_compute_network.main.name
  project = google_compute_network.main.project
  region  = google_compute_subnetwork.private.region
}
