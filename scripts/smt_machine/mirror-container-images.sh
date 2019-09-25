#!/bin/bash

REGISTRY="smt.example.com"
CONTAINER_LIST="
gcr.io/google_containers/kubernetes-dashboard-amd64:v1.10.0
mhausenblas/simpleservice:0.5.0
nginx:1.12.0
nginx:1.7.9
nginx:1.9.0
jsevans/tomcat-opensuse:latest
kope.io/k8s-1.8-debian-jessie-amd64-hvm-ebs-2018-01-14
busybox
gcr.io/google_containers/hpa-example
gcr.io/google_containers/busybox:1.24
"

echo
echo "Mirroring container images ..."
echo "-------------------------------------------------------"
for IMAGE in ${CONTAINER_LIST}
do
  echo "-${IMAGE}"
  skopeo copy --dest-tls-verify=false docker://${IMAGE} docker://${REGISTRY}:5000/${IMAGE}
done
