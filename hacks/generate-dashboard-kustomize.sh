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
- name: dashboards-static
  files:
$(find static -iname '*.json' | while read line; do echo "  - $line"; done)
  options:
    labels:
      grafana_dashboard: "1"
      app.kubernetes.io/component: monitoring
EOF
cd -
