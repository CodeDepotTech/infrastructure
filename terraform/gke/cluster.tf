# global
variable "zone" {}


data "google_container_engine_versions" "central1f" {
  zone = "${var.zone}"
}

locals {
  latest_node_version = "${data.google_container_engine_versions.central1f.latest_node_version}"
}

# resource google_container_cluster
variable "cluster_name" {}

resource "google_container_cluster" "cluster_01" {
  name = "${var.cluster_name}"
  zone = "${var.zone}"
  node_version = "${local.latest_node_version}"
  min_master_version = "${local.latest_node_version}"
  logging_service = "none"
  monitoring_service = "none" 
  remove_default_node_pool = true
  addons_config {
    http_load_balancing {
      disabled = true
    }
  }
}

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

resource "google_container_node_pool" "bastion_pool" {
  name        = "${var.bastion_pool_name}"
  zone        = "${var.zone}"
  cluster     = "${var.cluster_name}"
  initial_node_count  = "${var.bastion_count}"

  autoscaling {
    min_node_count = "${var.bastion_pool_min_count}"
    max_node_count = "${var.bastion_pool_max_count}"
  }

  management {
    auto_repair = "${var.auto_repair}"
    auto_upgrade = "${var.auto_upgrade}"
  }

  node_config {
    disk_size_gb = "${var.bastion_disk_size_gb}"
    disk_type = "${var.bastion_disk_type}"
    # image_type = "${var.bastion_image_type}"
    machine_type = "${var.bastion_machine_type}"
    preemptible = "${var.bastion_pool_preemptible}"
    # tags = ${var.tags}
    tags = ["bastion"] 

    # oauth_scopes = ${var.oauth_scopes}
    oauth_scopes = [
      "compute-rw",
      "storage-ro",
    ]

    # taint = ${var.taint}
    taint {
      key = "voyager"
      value = false
      effect = "NO_SCHEDULE"
    }
  }
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

resource "google_container_node_pool" "istio_pool" {
  name        = "${var.istio_pool_name}"
  zone        = "${var.zone}"
  cluster     = "${var.cluster_name}"
  initial_node_count  = "${var.istio_pool_count}"

  autoscaling {
    min_node_count = "${var.istio_pool_min_count}"
    max_node_count = "${var.istio_pool_max_count}"
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

  node_config {    
    disk_size_gb = "${var.istio_disk_size_gb}"
    disk_type = "${var.istio_disk_type}"
    image_type = "${var.istio_image_type}"
    preemptible = "${var.istio_pool_preemptible}"
    machine_type = "${var.istio_machine_type}"

    oauth_scopes = [
      "compute-rw",
      "storage-ro",
    ]
  }
}