variable "org_id" {
  description = "The GCP organization ID to create this within"
  type        = number
}

variable "folder_id" {
  description = "The folder ID to embed the project under"
  type        = number
}

variable "billing_account" {
  description = "The ID of the billing account"
  type        = string
}

variable "host_project_id" {
  description = "The ID of the VPC host project"
  type        = string
}

variable "labels" {
  description = "A map of k/v pairs for project labels"
  default     = {}
}

variable "owners" {
  description = "A list of identiies to grant the project role/owner to"
  type        = set(string)
  default     = []
}

variable "groups" {
  description = "A list of groups to grant the project role/editor to"
  type        = set(string)
  default     = []
}

variable "shared_vpc_subnets" {
  description = "A map of subnets in { subnet = region } format"
  type        = map(string)
}

variable "project_prefix" {
  type        = string
  description = "A prefix to uniquely identifiy projects"
  default     = "example"
}

variable "additional_apis" {
  type        = list(string)
  description = "A list of GCP APIs to enable for the project"
  default     = []
}