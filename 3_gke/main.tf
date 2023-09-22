/*
* # GKE Cluster
* 
* This is a module that creates a simple GKE cluster and connects it to a shared Shared VPC.
* 
* This module: 
*
* * Creates a cluster per region/subnet passed in
* * Opens up firewall ports for 9443 and 15017
* * Assigns secondary IP ranges that are passed in from the host project
*
*/

module "kubernetes-engine" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "23.1.0"

  for_each = var.gke_clusters

  project_id                 = var.project_id
  name                       = "${var.project_prefix}-${each.key}"
  region                     = each.value.region
  network                    = var.network
  network_project_id         = var.host_project_id
  subnetwork                 = each.value.subnetwork
  ip_range_pods              = each.value.ip_range_pods
  ip_range_services          = each.value.ip_range_services
  create_service_account     = true
  add_cluster_firewall_rules = false
  firewall_inbound_ports     = ["9443", "15017"]
}