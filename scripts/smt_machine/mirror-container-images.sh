#!/bin/bash
# Current CaaSP Images: 1.15.2
# "skuba cluster images" to get the latest bootstrap images
# add smt.example.com:5000/ to any image to download offline
REGISTRY="smt.example.com"
CONTAINER_LIST="
gcr.io/google_containers/kubernetes-dashboard-amd64:v1.10.0
gcr.io/google_containers/hpa-example:v1.13.1
k8s.gcr.io/cluster-autoscalerv:v1.13.1
spotinst/kubernetes-cluster-autoscaler:0.6.0
mhausenblas/simpleservice:0.5.0
nginx:1.12.0
nginx:1.7.9
nginx:1.9.0
jsevans/tomcat-opensuse:latest
kope.io/k8s-1.8-debian-jessie-amd64-hvm-ebs-2018-01-14
busybox
gcr.io/google_containers/busybox:1.24
     registry.suse.com/caasp/v4/pause:3.1
     registry.suse.com/caasp/v4/skuba-tooling:0.1.0
     registry.suse.com/caasp/v4/hyperkube:v1.15.2
     registry.suse.com/caasp/v4/etcd:3.3.11
     registry.suse.com/caasp/v4/coredns:1.3.1
     registry.suse.com/caasp/v4/cilium-init:1.5.3
     registry.suse.com/caasp/v4/cilium-operator:1.5.3
     registry.suse.com/caasp/v4/cilium:1.5.3
     registry.suse.com/caasp/v4/caasp-dex:2.16.0
     registry.suse.com/caasp/v4/gangway:3.1.0-rev4
     registry.suse.com/caasp/v4/kured:1.2.0
"

echo
echo "Mirroring container images ..."
echo "-------------------------------------------------------"
for IMAGE in ${CONTAINER_LIST}
do
  echo "-${IMAGE}"
  skopeo copy --dest-tls-verify=false docker://${IMAGE} docker://${REGISTRY}:5000/${IMAGE}
done
