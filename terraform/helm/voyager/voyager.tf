
resource "helmcmd_release" "voyager" {
  #provider = "${var.provider}"
  provider = "helmcmd.voyager"
  name = "${var.name}"
  chart_name = "${var.chart_name}"
  chart_version = "${var.chart_version}"
  namespace = "${var.namespace}"
  overrides = "${var.overrides}"
}