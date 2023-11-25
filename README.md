# Monitoring (**WIP**)

Main repo for managing the central monitoring stack.

Currently just dashboards generated via a make file and committed into the `./manifests` directory.

```bash
# Update the manifests
make generate

# Clean the repo and delete any files that are generated
make clean
```

## Static dashboards

There are some dashboards that I've added to this repo to track them, but they originate from community made or upstream projects.

Istio dashboards downloaded from: https://istio.io/latest/docs/ops/integrations/grafana/#option-1-quick-start

FluxCD dashboards referenced on https://fluxcd.io/flux/monitoring/metrics/#flux-grafana-dashboards and downloaded from https://github.com/fluxcd/flux2-monitoring-example/tree/main/monitoring/configs/dashboards
