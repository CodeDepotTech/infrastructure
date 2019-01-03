
data "google_container_engine_versions" "central1f" {
  zone = "${var.zone}"
}

locals {
  latest_node_version = "${data.google_container_engine_versions.central1f.latest_node_version}"
}


resource "google_container_cluster" "cluster01" {
  name = "${var.cluster_name}"
  zone = "${var.zone}"
  node_version = "${local.latest_node_version}"
  min_master_version = "${local.latest_node_version}"
  logging_service = "none"
  monitoring_service = "none" 
  remove_default_node_pool = true
  node_pool {
    name = "default-pool"
  }
  addons_config {
    http_load_balancing {
      disabled = true
    }
  }
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



resource "google_compute_address" "cluster01" {
  name = "static-address"
  provisioner "local_exec" {
    command = "echo ${google_compute_address.cluster01.address} > static-ip-address.txt"
  }
}


resource "null_resource" "credentials" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials $(terraform output cluster_name) --zone=$(terraform output primary_zone)"
  }
  provisioner "local-exec" {
    command = "echo $(kubectl cluster-info)"
  }
}