/*
* # Service Project
* 
* This is an opinionated module that creates a GCP service project.
* 
* This module: 
*
* * Creates a lein on the project to avoid accidental deletion
* * Optionally grants a list of users Owner access and a list of groups Editor access
* * A service account that can be used with your CI Platform for terraform
*
*/

locals {
  shared_vpc_subnets = [for k, v in var.shared_vpc_subnets : "projects/${var.host_project_id}/regions/${v}/subnetworks/${k}"]
  apis = [

  ]
}

module "project-factory-service-1" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 13.0.0"

  name                        = "${var.project_prefix}-service"
  random_project_id           = true
  org_id                      = var.org_id
  folder_id                   = var.folder_id
  bucket_force_destroy        = true
  billing_account             = var.billing_account
  disable_services_on_destroy = false
  default_service_account     = "deprivilege"
  create_project_sa           = true
  svpc_host_project_id        = var.host_project_id
  shared_vpc_subnets          = local.shared_vpc_subnets

  lien   = true
  labels = var.labels
  activate_apis = concat(
    var.additional_apis,
    [
      "cloudapis.googleapis.com",
      "compute.googleapis.com"
    ]
  )
}

resource "google_project_iam_member" "project-owner" {
  for_each = var.owners

  project = module.project-factory-service-1.project_id
  role    = "roles/owner"
  member  = "user:${each.key}"
}

resource "google_project_iam_member" "project-editor" {
  for_each = var.groups

  project = module.project-factory-service-1.project_id
  role    = "roles/editors"
  member  = "group:${each.key}"
}