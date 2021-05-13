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
