#!/bin/bash
# Current CaaSP Images: 1.15.2
# "skuba cluster images" to get the latest bootstrap images
REGISTRY="smt.example.com"
CONTAINER_LIST="
gcr.io/google-samples/node-hello:1.0
gcr.io/google_containers/metrics-server-amd64:v0.3.6
gcr.io/google_containers/kubernetes-dashboard-amd64:v1.10.0
docker.io/mhausenblas/simpleservice:0.5.0
docker.io/nginx:1.12.0
docker.io/nginx:1.7.9
docker.io/nginx:1.9.0
docker.io/jsevans/tomcat-opensuse:latest
docker.io/busybox
gcr.io/google_containers/hpa-example
gcr.io/google_containers/busybox:1.24
gcr.io/kubernetes-helm/tiller:v2.16.1
quay.io/external_storage/nfs-client-provisioner:v3.1.0-k8s1.11
docker.io/metallb/controller:v0.8.1
docker.io/metallb/speaker:v0.8.1
docker.io/hashicorp/http-echo
docker.io/opensuse/leap 
registry.suse.com/sles12/nginx-ingress-controller:0.15.0
registry.suse.com/sles12/default-http-backend:0.15.0
docker.io/mysql:5.6
registry.suse.com/caasp/v4/hyperkube:v1.15.2
registry.suse.com/caasp/v4/etcd:3.3.11
registry.suse.com/caasp/v4/coredns:1.3.1
registry.suse.com/caasp/v4/pause:3.1
registry.suse.com/caasp/v4/skuba-tooling:0.1.0
registry.suse.com/caasp/v4/caasp-dex:2.16.0
registry.suse.com/caasp/v4/gangway:3.1.0-rev4
registry.suse.com/caasp/v4/kured:1.2.0-rev4
registry.suse.com/caasp/v4/cilium-init:1.5.3
registry.suse.com/caasp/v4/cilium-operator:1.5.3
registry.suse.com/caasp/v4/cilium:1.5.3
registry.suse.com/caasp/v4/skuba-tooling:0.1.0
registry.suse.com/caasp/v4/hyperkube:v1.16.2
registry.suse.com/caasp/v4/etcd:3.3.15
registry.suse.com/caasp/v4/coredns:1.6.2
registry.suse.com/caasp/v4/pause:3.1
registry.suse.com/caasp/v4/gangway:3.1.0-rev4
registry.suse.com/caasp/v4/kured:1.2.0-rev4
registry.suse.com/caasp/v4/cilium-init:1.5.3
registry.suse.com/caasp/v4/cilium-operator:1.5.3
registry.suse.com/caasp/v4/cilium:1.5.3
registry.suse.com/caasp/v4/caasp-dex:2.16.0
"

echo
echo "Mirroring container images ..."
echo "-------------------------------------------------------"
for IMAGE in ${CONTAINER_LIST}
do
  echo "-${IMAGE}"
  skopeo copy --dest-tls-verify=false docker://${IMAGE} docker://${REGISTRY}:5000/${IMAGE}
done
