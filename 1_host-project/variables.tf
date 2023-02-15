variable "org_id" {
  description = "The GCP Organization ID to create this within"
  type        = number
}

variable "folder_id" {
  description = "The Folder ID to embed the project under"
  type        = number
}

variable "billing_account" {
  description = "The ID of the billing account"
  type        = string
}

variable "labels" {
  description = "A map of k/v pairs for project labels"
  default     = {}
}

variable "project_prefix" {
  type        = string
  description = "A prefix to uniquely identifiy projects"
}

variable "domain" {
  type        = string
  description = "The DNS name for your private dns zone"
}