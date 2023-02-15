output "project_id" {
  description = "The ID of the created project"
  value       = module.project-factory-service-1.project_id
}

output "gke_module_tfvars" {
  description = "Values to assign to the downstream gke module"
  value       = templatefile("${path.module}/templates/gke_project.tfvars.tmpl", { project_id = module.project-factory-service-1.project_id })
}
