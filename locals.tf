locals {
  #
  # Shared
  #

  shared__labels = {
    at64_shared__automated      = "true"
    at64_shared__module_type    = "terraform"
    at64_shared__module_name    = "terraform-google-vpc-single"
    at64_shared__module_version = "1-1-0"
  }

  shared__prefix = {
    google_compute_firewall       = coalesce(var.shared__prefix.google_compute_firewall, module.lib_catalog.pgg.vpc_firewall)
    google_compute_global_address = coalesce(var.shared__prefix.google_compute_global_address, module.lib_catalog.pgg.vpc_address_global)
    google_compute_network        = coalesce(var.shared__prefix.google_compute_network, module.lib_catalog.pgg.vpc_network)
    google_compute_router         = coalesce(var.shared__prefix.google_compute_router, module.lib_catalog.pgg.vpc_route)
    google_compute_subnetwork     = coalesce(var.shared__prefix.google_compute_subnetwork, module.lib_catalog.pgg.vpc_subnetwork)
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
  # Google Compute Global Address
  #

  google_compute_global_address = {
    name            = "${local.shared__prefix.google_compute_global_address}-${var.shared__name}"
    deletion_policy = var.shared__allow_delete ? "" : "ABANDON"
    address_type    = "INTERNAL"
    description     = "Private IP range for Google Managed Services"
    ip_version      = "IPV4"
    prefix_length   = "16"
    purpose         = "VPC_PEERING"
  }

  #
  # Google Compute Firewall
  #

  google_compute_firewall = {
    iap_ssh = {
      name = "${local.shared__prefix.google_compute_firewall}-${var.shared__name}-iap-ssh"

      description   = "Allow SSH access via Google Identity-Aware Proxy TCP forwarding"
      direction     = "INGRESS"
      source_ranges = ["35.235.240.0/20"]

      allow = {
        protocol = "tcp"
        ports    = ["22"]
      }
    }
  }
}
