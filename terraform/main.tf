# global
variable "debug" {}

# provider google
variable "google_credentials" {}
variable "project" {}
variable "region" {}
variable "zone" {}
provider "google" {
  credentials = "${var.google_credentials}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

# module gke
  # bastion_pool
// variable "google_credentials" {}
variable "bastion_pool_name" {}
// variable "bastion_count" {}
// variable "bastion_pool_min_count" {}
// variable "bastion_pool_max_count" {}
// variable "auto_repair" {}
// variable "auto_upgrade" {}
// variable "bastion_disk_size_gb" {}
// variable "bastion_disk_type" {}
// variable "bastion_machine_type" {}
// variable "bastion_pool_preemptible" {}
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

module "gke" {
  source = "./gke"
  zone = "${var.zone}"
  # google provider
  # google_credentials="${var.google_credentials}"
  # project="${var.project}"
  # region="${var.region}"
  zone="${var.zone}"

  # bastion_pool
  bastion_pool_name="${var.bastion_pool_name}"
  bastion_count="${var.bastion_count}"
  bastion_pool_min_count="${var.bastion_pool_min_count}"
  bastion_pool_max_count="${var.bastion_pool_max_count}"
  auto_repair="${var.auto_repair}"
  auto_upgrade="${var.auto_upgrade}"
  bastion_disk_size_gb="${var.bastion_disk_size_gb}"
  bastion_disk_type="${var.bastion_disk_type}"
  bastion_machine_type="${var.bastion_machine_type}"
  bastion_pool_preemptible="${var.bastion_pool_preemptible}"
  tags="${var.tags}"
  oauth_scopes="${var.oauth_scopes}"
  taint="${var.taint}"

  # istio node pool
  istio_pool_name="${var.istio_pool_name}"
  cluster_name="${var.cluster_name}"
  istio_pool_count="${var.istio_pool_count}"
  istio_pool_min_count="${var.istio_pool_min_count}"
  istio_pool_max_count="${var.istio_pool_max_count}"
  istio_disk_size_gb="${var.istio_disk_size_gb}"
  istio_disk_type="${var.istio_disk_type}"
  istio_image_type="${var.istio_image_type}"
  istio_pool_preemptible="${var.istio_pool_preemptible}"
  istio_machine_type="${var.istio_machine_type}"
}

# provider helmcmd
variable "alias" {}
variable "chart_source_type" {}
variable "chart_source" {}
variable "kube_context" {}

provider "helmcmd" {
  alias = "voyager"
  chart_source_type = "${var.chart_source_type}"
  chart_source = "${var.chart_source}"
  debug = "${var.debug}"
  kube_context = "${var.kube_context}"
}

# module voyager
// variable "provider" { default = "helmcmd.voyager"}
variable "name" {}
variable "chart_name" {}
variable "chart_version" {}
variable "namespace" {}
variable "overrides" {}

module "voyager" {
  source = "./helm/voyager"
  name = "${var.name}"
  chart_name = "${var.chart_name}"
  chart_version = "${var.chart_version}"
  namespace = "${var.namespace}"
  overrides = "${var.overrides}"
}

