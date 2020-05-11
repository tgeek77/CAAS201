#!/bin/bash
# Image versions are tied to Skuba.
# Current Skuba Version: 1.2.4
# Image version: 1.16.2
# "skuba cluster images" to get the latest bootstrap images
REGISTRY="smt.example.com"
REMOTE="registry.suse.com/caasp/v4"
CONTAINER_LIST="
hyperkube:v1.16.2
etcd:3.3.15
coredns:1.6.2
pause:3.1
skuba-tooling:0.1.0
cilium-init:1.5.3
cilium-operator:1.5.3
cilium:1.5.3
caasp-dex:2.16.0
gangway:3.1.0-rev4
kured:1.2.0-rev4
velero:1.3.1
velero-plugin-for-aws:1.0.1
"

echo
echo "Mirroring container images ..."
echo "-------------------------------------------------------"
for IMAGE in ${CONTAINER_LIST}
do
  echo "-${IMAGE}"
  skopeo copy --dest-tls-verify=false docker://${REMOTE}/${IMAGE} docker://${REGISTRY}:5000/${REMOTE}/${IMAGE}
done
