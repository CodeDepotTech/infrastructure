# variable "provider" {}
variable "name" {}
variable "chart_name" {}
variable "chart_version" {}
variable "namespace" {}
variable "overrides" {}

resource "helmcmd_release" "voyager" {
  provider = "helmcmd.voyager"
  name = "${var.name}"
  chart_name = "${var.chart_name}"
  chart_version = "${var.chart_version}"
  namespace = "${var.namespace}"
  overrides = "${var.overrides}"
}