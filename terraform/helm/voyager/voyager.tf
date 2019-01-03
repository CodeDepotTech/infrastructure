
resource "helmcmd_release" "voyager" {
  #provider = "${var.provider}"
  provider = "helmcmd.voyager"
  name = "${var.helm_voyager_name}"
  chart_name = "${var.helm_voyager_chart_name}"
  chart_version = "${var.helm_voyager_chart_version}"
  namespace = "${var.helm_voyager_namespace}"
  overrides = "${var.helm_voyager_overrides}"
}