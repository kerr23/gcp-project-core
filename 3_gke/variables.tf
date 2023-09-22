variable "project_id" {
  type        = string
  description = "The ID of the service project"
}

variable "network" {
  type        = string
  description = "The name of the VPC network"
}

variable "host_project_id" {
  type        = string
  description = "The ID of the VPC host project"
}

variable "gke_clusters" {
  description = "A map containing the GKE cluster"
}

variable "project_prefix" {
  type        = string
  description = "A prefix to uniquely identifiy projects"
  default     = "example"
}