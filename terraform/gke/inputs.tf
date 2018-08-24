# global
variable "zone" {}

# resource google_container_cluster
variable "cluster_name" {}

# resource google_container_node_pool
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
variable "tags" { 
  type = "list" 
}
variable "oauth_scopes" {
  type = "list"
}
variable "taint" {
  type = "map"
}
variable "istio_pool_name" {}
variable "istio_pool_count" {}
variable "istio_pool_min_count" {}
variable "istio_pool_max_count" {}
variable "istio_disk_size_gb" {}
variable "istio_disk_type" {}
variable "istio_image_type" {}
variable "istio_pool_preemptible" {}
variable "istio_machine_type" {}