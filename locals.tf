locals {
  #
  # Shared
  #

  shared__labels = {
    at64_shared__automated      = "true"
    at64_shared__module_type    = "terraform"
    at64_shared__module_name    = "terraform-google-vpc-single"
    at64_shared__module_version = "1-0-0"
  }

  shared__prefix = {
    google_compute_network    = coalesce(var.shared__prefix.google_compute_network, module.lib_catalog.pgg.vpc_network)
    google_compute_subnetwork = coalesce(var.shared__prefix.google_compute_subnetwork, module.lib_catalog.pgg.vpc_subnetwork)
    google_compute_router     = coalesce(var.shared__prefix.google_compute_router, module.lib_catalog.pgg.vpc_route)
    google_compute_firewall   = coalesce(var.shared__prefix.google_compute_firewall, module.lib_catalog.pgg.vpc_firewall)
  }

  #
  # Google Compute Network
  #

  google_compute_network = {
    name                            = "${local.shared__prefix.google_compute_network}-${var.shared__name}"
    auto_create_subnetworks         = false
    delete_default_routes_on_create = false
  }

  #
  # Google Compute SubNetwork
  #

  google_compute_subnetwork = {
    stack_type = "IPV4_ONLY"
    purpose    = "PRIVATE"
    name = {
      dmz     = "${local.shared__prefix.google_compute_subnetwork}-${var.shared__name}-dmz"
      private = "${local.shared__prefix.google_compute_subnetwork}-${var.shared__name}-private"
    }
    description = {
      dmz     = "DMZ Subnetwork for the VPC: ${var.google_compute_network.description}"
      private = "Private Subnetwork for the VPC: ${var.google_compute_network.description}"
    }
  }

  #
  # Google Compute Router
  #
  google_compute_router = {
    name        = "${local.shared__prefix.google_compute_router}-${var.shared__name}"
    description = "Router for the VPC: ${var.google_compute_network.description}"
  }

  #
  # Google Compute Firewall
  #
}
