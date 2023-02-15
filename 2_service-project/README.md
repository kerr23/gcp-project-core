# Service Project

This is an opinionated module that creates a GCP service project.

This module:

* Creates a lein on the project to avoid accidental deletion
* Optionally grants a list of users Owner access and a list of groups Editor access
* A service account that can be used with your CI Platform for terraform

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | 4.29.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| project-factory-service-1 | terraform-google-modules/project-factory/google | ~> 13.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.project-editor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.project-owner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The ID of the billing account | `string` | n/a | yes |
| folder\_id | The folder ID to embed the project under | `number` | n/a | yes |
| host\_project\_id | The ID of the VPC host project | `string` | n/a | yes |
| org\_id | The GCP organization ID to create this within | `number` | n/a | yes |
| shared\_vpc\_subnets | A map of subnets in { subnet = region } format | `map(string)` | n/a | yes |
| groups | A list of groups to grant the project role/editor to | `set(string)` | `[]` | no |
| labels | A map of k/v pairs for project labels | `map` | `{}` | no |
| owners | A list of identiies to grant the project role/owner to | `set(string)` | `[]` | no |
| project\_prefix | A prefix to uniquely identifiy projects | `string` | `"example"` | no |

## Outputs

| Name | Description |
|------|-------------|
| gke\_module\_tfvars | Values to assign to the downstream gke module |
| project\_id | The ID of the created project |
