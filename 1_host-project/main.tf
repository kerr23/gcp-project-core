/*
* # Host Project
* 
* This is an opinionated module that creates a GCP project for use as a Shared VPC Host Project.
* 
* This module: 
*
* * Creates a lein on the project to avoid accidental deletion
* * Creates 3 Subnets in us-west1, us-east1 and us-centra1 
* * Creates 6 secondary IP ranges for GKE
* * A service account that can be used with your CI Platform for terraform
*
*/

module "project-factory-host" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 13.0.0"

  name                        = "${var.project_prefix}-host"
  random_project_id           = true
  org_id                      = var.org_id
  folder_id                   = var.folder_id
  bucket_force_destroy        = true
  billing_account             = var.billing_account
  disable_services_on_destroy = false
  default_service_account     = "deprivilege"
  create_project_sa           = true
  lien                        = true
  labels                      = var.labels
  auto_create_network         = false
  activate_apis = [
    "cloudapis.googleapis.com",
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "secretmanager.googleapis.com",
    "container.googleapis.com",
    "dns.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 4.0"

  project_id      = module.project-factory-host.project_id
  network_name    = "${var.project_prefix}-vpc"
  routing_mode    = "GLOBAL"
  shared_vpc_host = true

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.0.0/16"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.20.0.0/16"
      subnet_region         = "us-east1"
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-03"
      subnet_ip             = "10.30.0.0/16"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-04"
      subnet_ip             = "10.40.0.0/16"
      subnet_region         = "us-west2"
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-1-ip-range-pods"
        ip_cidr_range = "192.168.0.0/16"
      },
      {
        range_name    = "subnet-1-ip-range-services"
        ip_cidr_range = "192.167.0.0/16"
      },
    ]

    subnet-02 = [
      {
        range_name    = "subnet-2-ip-range-pods"
        ip_cidr_range = "192.166.0.0/16"
      },
      {
        range_name    = "subnet-2-ip-range-services"
        ip_cidr_range = "192.165.0.0/16"
      },
    ]

    subnet-03 = [
      {
        range_name    = "subnet-3-ip-range-pods"
        ip_cidr_range = "192.164.0.0/16"
      },
      {
        range_name    = "subnet-3-ip-range-services"
        ip_cidr_range = "192.163.0.0/16"
      },
    ]
  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}

module "dns-private-zone" {
  source     = "terraform-google-modules/cloud-dns/google"
  version    = "4.2.1"
  project_id = module.project-factory-host.project_id
  type       = "private"
  name       = lower(replace(var.domain, ".", "-"))
  domain     = "${var.domain}."

  private_visibility_config_networks = [
    module.vpc.network_self_link
  ]
}

# resource "google_compute_global_address" "private_ip_alloc" {
#   name          = "private-ip-alloc"
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 16
#   network       = module.vpc.network_id
# }

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = module.project-factory-host.project_id
  network_name = module.vpc.network_name

  rules = [{
    name                    = "allow-ssh-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["ssh"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}

module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "2.2.2"
  project_id    = module.project-factory-host.project_id
  region        = "us-west2"
  create_router = true
  router        = "${var.project_prefix}-router"
  network       = module.vpc.network_name
}