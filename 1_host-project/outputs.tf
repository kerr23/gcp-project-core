locals {
  service_project_tfvars = {
    host_project_id = module.project-factory-host.project_id
    org_id          = var.org_id
    folder_id       = var.folder_id
    billing_account = var.billing_account
    subnets         = module.vpc.subnets
    project_prefix  = var.project_prefix
  }
  gke_project_tfvars = {
    host_project_id = module.project-factory-host.project_id
    network         = module.vpc.network.network_name
    subnets         = module.vpc.subnets
    project_prefix  = var.project_prefix
  }
}

output "project_id" {
  value       = module.project-factory-host.project_id
  description = "The ID of the created project"
}

output "service_account" {
  description = "The email address of the service account"
  value       = module.project-factory-host.service_account_email
}

output "service_project_tfvars" {
  description = "Values to assign to the downstream service project"
  value       = templatefile("${path.module}/templates/service_project.tfvars.tmpl", local.service_project_tfvars)
}

output "gke_module_tfvars" {
  description = "Values to assign to the downstream gke module"
  value       = templatefile("${path.module}/templates/gke_project.tfvars.tmpl", local.gke_project_tfvars)
}

output "vpc_network_name" {
  value = module.vpc.network_name
}