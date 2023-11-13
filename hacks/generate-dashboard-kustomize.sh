#!/usr/bin/env bash

cd manifests/dashboards
cat <<EOF > kustomization.yaml
configMapGenerator:
- name: dashboards-generated
  files:
$(find generated -iname '*.json' | while read line; do echo "  - $line"; done)
  options:
    labels:
      grafana_dashboard: "1"
      app.kubernetes.io/component: monitoring
    annotations:
      grafana_folder: "kubernetes"
- name: dashboards-flux
  files:
$(find static -iname 'flux*.json' | while read line; do echo "  - $line"; done)
  options:
    labels:
      grafana_dashboard: "1"
      app.kubernetes.io/component: monitoring
    annotations:
      grafana_folder: "flux"
EOF
cd -
