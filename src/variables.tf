#
# Shared
#

variable "shared__name" {
  description = "Name seed to be used for naming generated module objects"
  sensitive   = false
  nullable    = false
  type        = string
}

variable "shared__location" {
  description = "GCP location where resources will be deployed to"
  sensitive   = false
  nullable    = false
  type        = string
}

variable "shared__prefix" {
  description = "Prefix definition for naming generated module objects"
  sensitive   = false
  nullable    = true
  type = object({
    google_compute_network    = optional(string)
    google_compute_subnetwork = optional(string)
    google_compute_router     = optional(string)
    google_compute_firewall   = optional(string)
  })
  default = {}
}

variable "shared__labels" {
  description = "Common labels to be applied to all resources"
  sensitive   = false
  nullable    = true
  type        = map(string)
  default     = {}
}

variable "shared__project_id" {
  description = "GCP Project ID where resources will be deployed to"
  sensitive   = false
  nullable    = false
  type        = string
}

#
# Google Compute Network
#

variable "google_compute_network" {
  description = "Google Compute Network Attributes"
  sensitive   = false
  nullable    = true
  type = object({
    description  = optional(string, "Main VPC")
    routing_mode = optional(string, "REGIONAL")
  })
  default = {}
}

#
# Google Compute SubNetwork
#

variable "google_compute_subnetwork" {
  description = "Google Compute SubNetwork Attributes"
  sensitive   = false
  nullable    = true
  type = object({
    ip_cidr_range = optional(object({
      dmz     = optional(string, "192.168.0.0/24")
      private = optional(string, "192.168.1.0/24")
    }), {})
  })
  default = {}
}

variable "google_compute_subnetwork__log_config" {
  description = "Google Compute SubNetwork Log Config"
  sensitive   = false
  nullable    = true
  type = object({
    aggregation_interval = optional(string)
    flow_sampling        = optional(number)
  })
  default = null
}
