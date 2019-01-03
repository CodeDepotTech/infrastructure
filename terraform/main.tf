

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



provider "helmcmd" {
  #alias = "${var.alias}"
  alias = "voyager"
  chart_source_type = "${var.helm_voyager_chart_source_type}"
  chart_source = "${var.helm_voyager_chart_source}"
  debug = "${var.debug}"
  kube_context = "${var.helm_voyager_kube_context}"
}



module "voyager" {
  #provider = "${var.provider}"
  source = "./helm/voyager"
  name = "${var.helm_voyager_name}"
  chart_name = "${var.helm_voyager_chart_name}"
  chart_version = "${var.helm_voyager_chart_version}"
  namespace = "${var.helm_voyager_namespace}"
  overrides = "${var.helm_voyager_overrides}"
}


provider "helmcmd" {
  #alias = "${var.alias}"
  alias = "istio"
  chart_source_type = "${var.helm_istio_chart_source_type}"
  chart_source = "${var.helm_istio_chart_source}"
  debug = "${var.debug}"
  kube_context = "${var.helm_istio_kube_context}"
}



module "istio" {
  #provider = "${var.provider}"
  source = "./helm/istio"
  name = "${var.helm_istio_name}"
  chart_name = "${var.helm_istio_chart_name}"
  chart_version = "${var.helm_istio_chart_version}"
  namespace = "${var.helm_istio_namespace}"
  overrides = "${var.helm_istio_overrides}"
}


