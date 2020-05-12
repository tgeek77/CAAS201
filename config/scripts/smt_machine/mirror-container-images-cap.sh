#!/bin/bash
# Current CaaSP Images: 1.15.2
# "skuba cluster images" to get the latest bootstrap images
REGISTRY="smt.example.com"
REMOTE="registry.suse.com/cap"
CONTAINER_LIST="
stratos-console:2.7.0-35f5964bd-cap
stratos-jetstream:2.7.0-35f5964bd-cap
stratos-mariadb:2.7.0-35f5964bd-cap
stratos-postflight-job:2.7.0-35f5964bd-cap

stratos-fdbdoclayer:3.1.0-0d657242b-cap
stratos-fdbserver:3.1.0-0d657242b-cap
stratos-chartsync:3.1.0-0d657242b-cap
stratos-config-init:3.1.0-0d657242b-cap
stratos-mariadb:3.1.0-0d657242b-cap
stratos-console:3.1.0-0d657242b-cap
stratos-jetstream:3.1.0-0d657242b-cap

stratos-metrics-cf-exporter:1.1.2-85daaa2-cap
stratos-metrics-firehose-exporter:1.1.2-85daaa2-cap
stratos-metrics-firehose-init:1.1.2-85daaa2-cap
stratos-metrics-nginx:1.1.2-85daaa2-cap
stratos-metrics-configmap-reload:1.1.2-85daaa2-cap
stratos-metrics-init-chown-data:1.1.2-85daaa2-cap
stratos-metrics-kube-state-metrics:1.1.2-85daaa2-cap
stratos-metrics-node-exporter:1.1.2-85daaa2-cap
stratos-metrics-prometheus:1.1.2-85daaa2-cap
"

echo
echo "Mirroring container images ..."
echo "-------------------------------------------------------"
for IMAGE in ${CONTAINER_LIST}
do
  echo "-${IMAGE}"
  skopeo copy --dest-tls-verify=false docker://${REMOTE}/${IMAGE} docker://${REGISTRY}:5000/${REMOTE}/${IMAGE}
done
