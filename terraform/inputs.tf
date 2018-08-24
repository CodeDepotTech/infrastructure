# global
variable "debug" {}

# provider google
variable "google_credentials" {}
variable "project" {}
variable "region" {}
variable "zone" {}

# module gke
  # bastion_pool
variable "bastion_pool_name" {}
variable "bastion_count" {}
variable "bastion_pool_min_count" {}
variable "bastion_pool_max_count" {}
variable "auto_repair" {}
variable "auto_upgrade" {}
variable "bastion_disk_size_gb" {}
variable "bastion_disk_type" {}
variable "bastion_machine_type" {}
variable "bastion_pool_preemptible" {}
variable "tags" {}
variable "oauth_scopes" {}
variable "taint" {}

# istio node pool
variable "istio_pool_name" {}
variable "cluster_name" {}
variable "istio_pool_count" {}
variable "istio_pool_min_count" {}
variable "istio_pool_max_count" {}
variable "istio_disk_size_gb" {}
variable "istio_disk_type" {}
variable "istio_image_type" {}
variable "istio_pool_preemptible" {}
variable "istio_machine_type" {}

# provider helmcmd
#variable "alias" {}
variable "chart_source_type" {}
variable "chart_source" {}
variable "kube_context" {}

# module voyager
#variable "provider" { default = "helmcmd.voyager"}
variable "name" {}
variable "chart_name" {}
variable "chart_version" {}
variable "namespace" {}
variable "overrides" {}