# Cray-sysmgmt-health

This chart is a wrapper for the Prometheus Operator

## Grafana Dashboards

The dashboards are divided in two locations. dashboards & dashboards_json
* `templates/grafana/dashboards/**.yaml` These are all the dashboards already converted to yaml syntax so they can be parsed by helm and create the configmaps.
* `dashboards_json/**.json` These are all the dashboards in their original json format, these dashboards are imported by `templates/grafana/configmap-dashboards.yaml`


#### Grafana - Istio dashboards
When an Istio dashboard upgrade is required, we need to copy the json dashboards into `dashboards_json` folder and then execute the `fix_datasources.sh` script to update all the datasources properties. This is required as we are using upstream dashboards but we use the grafana from Prometheus-Operator

```
cd dashboards_json/istio
bash ./fix_datasources.sh
```

Note: current version of Istio dashboards is from Istio release-1.5.7-patch branch.
https://github.com/istio/istio/tree/release-1.5.7-patch/manifests/istio-telemetry/grafana/dashboards


## Prometheus

### References

* API: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md
* Documentation: https://github.com/prometheus-operator/prometheus-operator/tree/master/Documentation

### Automatic discovery of Pods and Services

The `kubernetes-pods` PodMonitor looks for Pods with annotations and monitors
those Pods automatically.

The annotations are:

* `prometheus.io/scrape`: Tells this PodMonitor to include this Pod. Set it to
  `true` to enable scraping.
* `prometheus.io/path`: Sets the metrics path to use. Defaults to `/metrics`
* `prometheus.io/port`: Sets the port to use. If not set then the scrape
  endpoint won't have a port.

The Istio sidecar injector sets these annotations on the Pods that this monitor
looks for so that each Pod's istio-proxy sidecar will be scraped.

The annotations could be used by other Pods, too, but it's more likely
monitoring of other services would be done using annotations on the Service.

The `kubernetes-service-endpoints` ServiceMonitor looks for Services with
annotations and monitors those Services automatically.

The annotations are:

* `prometheus.io/scrape`: Tells this PodMonitor to include this Pod. Set it to
  `true` to enable scraping.
* `prometheus.io/scheme`: Either `http` or `https`.
* `prometheus.io/path`: Sets the metrics path to use. Defaults to `/metrics`
* `prometheus.io/port`: Sets the port to use. If not set then the scrape
  endpoint won't have a port.
