

provider "google" {
  version = "~> 1.16"
  credentials = "${var.google_credentials}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}


module "gke" {
  source = "./gke"
  zone = "${var.zone}"
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

 # # istio node pool
 # istio_pool_name="${var.istio_pool_name}"
 # clustermodule "gke" {
 # source = "./gke"
 # zone = "${var.zone}"
 # # google provider
 # # google_credentials="${var.google_credentials}"
 # # project="${var.project}"
 # # region="${var.region}"
 # zone="${var.zone}"

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

// _name="${var.cluster_name}"
//   istio_pool_count="${var.istio_pool_count}"
//   istio_pool_min_count="${var.istio_pool_min_count}"
//   istio_pool_max_count="${var.istio_pool_max_count}"
//   istio_disk_size_gb="${var.istio_disk_size_gb}"
//   istio_disk_type="${var.istio_disk_type}"
//   istio_image_type="${var.istio_image_type}"
//   istio_pool_preemptible="${var.istio_pool_preemptible}"
//   istio_machine_type="${var.istio_machine_type}"
// }



provider "helmcmd" {
  #alias = "${var.alias}"
  alias = "voyager"
  chart_source_type = "${var.chart_source_type}"
  chart_source = "${var.chart_source}"
  debug = "${var.debug}"
  kube_context = "${var.kube_context}"
}



module "voyager" {
  #provider = "${var.provider}"
  source = "./helm/voyager"
  name = "${var.name}"
  chart_name = "${var.chart_name}"
  chart_version = "${var.chart_version}"
  namespace = "${var.namespace}"
  overrides = "${var.overrides}"
}

