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

# provider helmcmd voyager
#variable "alias" {}
variable "helm_voyager_chart_source_type" {}
variable "helm_voyager_chart_source" {}
variable "helm_voyager_kube_context" {}

# module voyager
#variable "provider" { default = "helmcmd.voyager"}
variable "helm_voyager_name" {}
variable "helm_voyager_chart_name" {}
variable "helm_voyager_chart_version" {}
variable "helm_voyager_namespace" {}
variable "helm_voyager_overrides" {}


# provider helmcmd istio
#variable "alias" {}
variable "helm_istio_chart_source_type" {}
variable "helm_istio_chart_source" {}
variable "helm_istio_kube_context" {}

# module istio
#variable "provider" { default = "helmcmd.istio"}
variable "helm_istio_name" {}
variable "helm_istio_chart_name" {}
variable "helm_istio_chart_version" {}
variable "helm_istio_namespace" {}
variable "helm_istio_overrides" {}