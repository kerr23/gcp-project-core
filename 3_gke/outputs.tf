output "cluster_connect" {
  value = [
    for k,v in var.gke_clusters :
      "gcloud container clusters get-credentials ${var.project_prefix}-${k} --region ${v.region} --project ${var.project_id}"
  ]
}