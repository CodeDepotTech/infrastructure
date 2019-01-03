

resource "helmcmd_release" "istio" {
  #provider = "${var.provider}"
  provider = "helmcmd.istio"
  name = "${var.helm_istio_name}"
  chart_name = "${var.helm_istio_chart_name}"
  chart_version = "${var.helm_istio_chart_version}"
  namespace = "${var.helm_istio_namespace}"
  overrides = "${var.helm_istio_overrides}"
}