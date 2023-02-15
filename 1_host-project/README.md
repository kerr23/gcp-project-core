# Host Project

This is an opinionated module that creates a GCP project for use as a Shared VPC Host Project.

This module:

* Creates a lein on the project to avoid accidental deletion
* Creates 3 Subnets in us-west1, us-east1 and us-centra1
* Creates 6 secondary IP ranges for GKE
* A service account that can be used with your CI Platform for terraform

## Requirements

| Name | Version |
|------|---------|
| google | >=4.22 |
| google-beta | >=4.22 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| dns-private-zone | terraform-google-modules/cloud-dns/google | 4.2.1 |
| project-factory-host | terraform-google-modules/project-factory/google | ~> 13.0.0 |
| vpc | terraform-google-modules/network/google | ~> 4.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The ID of the billing account | `string` | n/a | yes |
| domain | The DNS name for your private dns zone | `string` | n/a | yes |
| folder\_id | The Folder ID to embed the project under | `number` | n/a | yes |
| org\_id | The GCP Organization ID to create this within | `number` | n/a | yes |
| project\_prefix | A prefix to uniquely identifiy projects | `string` | n/a | yes |
| labels | A map of k/v pairs for project labels | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| gke\_module\_tfvars | Values to assign to the downstream gke module |
| project\_id | The ID of the created project |
| service\_account | The email address of the service account |
| service\_project\_tfvars | Values to assign to the downstream service project |
| vpc\_network\_name | n/a |
