# GKE Cluster

This is a module that creates a simple GKE cluster and connects it to a shared Shared VPC.

This module:

* Creates a cluster per region/subnet passed in
* Opens up firewall ports for 9443 and 15017
* Assigns secondary IP ranges that are passed in from the host project

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| kubernetes-engine | terraform-google-modules/kubernetes-engine/google | 23.1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gke\_clusters | A map containing the GKE cluster | `map(string)` | n/a | yes |
| host\_project\_id | The ID of the VPC host project | `string` | n/a | yes |
| network | The name of the VPC network | `string` | n/a | yes |
| project\_id | The ID of the service project | `string` | n/a | yes |
| project\_prefix | A prefix to uniquely identifiy projects | `string` | `"example"` | no |

## Outputs

No outputs.
