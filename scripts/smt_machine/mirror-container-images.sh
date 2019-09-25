#!/bin/bash

REGISTRY="smt.example.com"
CONTAINER_LIST="
gcr.io/google_containers/kubernetes-dashboard-amd64:v1.10.0
quay.io/external_storage/nfs-client-provisioner:latest
gcr.io/google_containers/busybox:1.24
mysql:5.6

gcr.io/kubernetes-helm/tiller:v2.8.1
splatform/minibroker:latest

registry.suse.com/cap/stratos-metrics-firehose-exporter:1.0.0-e913e7f-cap

registry.suse.com/cap/uaa-mysql:da2b353ab9ef995e526ced5bd6086cb4bf87d982
registry.suse.com/cap/uaa-uaa:3d27bd075182a032f179e6d7b4c56f0c0dad2c7c
registry.suse.com/cap/uaa-secret-generation:9021d6d286c72bb28748ec22fb939b51533b8c01

registry.suse.com/cap/scf-router:e10ca52925930b1530429c37e985631bc67d8e3f
registry.suse.com/cap/scf-autoscaler-api:54bb8b95df77e1890f1f53a6a873be94d9440b55
registry.suse.com/cap/scf-nats:b2ce1309ad0723495fa2fcc7307d90ad2a701e2e
registry.suse.com/cap/scf-log-api:f48a4af4a7b3e6c7dcb6205a0213e5dc7f392169
registry.suse.com/cap/scf-routing-api:5f091e27556f96d7b6581ce8a592be10b3746d2f
registry.suse.com/cap/scf-credhub-user:734e499f5bacea3a002c416470e435c2e84c1374
registry.suse.com/cap/scf-autoscaler-postgres:aa0502af0b603fcdf0ea61721ba4190e92a64bc1
registry.suse.com/cap/scf-cc-worker:abb781b42300dea81dc3b19cb576799dd0e12496
registry.suse.com/cap/scf-tcp-router:65be3f63230dd2c5ce953010119b8bb78fbeb091
registry.suse.com/cap/scf-diego-ssh:202e4a767bbe85bfa0a4ff1cc24b96f822a4d75c
registry.suse.com/cap/scf-cc-clock:33aa18acfe1f5b3b581adb30c4c568f6a5c5f872
registry.suse.com/cap/scf-nfs-broker:6a671b91e2182821951105bc30d8ab9506e5af2c
registry.suse.com/cap/scf-mysql:9bd4d112c280e103a83a8dd77a90674b84f72a93
registry.suse.com/cap/scf-cf-usb:c29809c2f8e64029268e9d448f59281901d2425f
registry.suse.com/cap/scf-cc-uploader:1f9ead20bd4b6268a3c8cb3150e5a8d57a371936
registry.suse.com/cap/scf-post-deployment-setup:d017d46ab32a8d9b913c028f1bf98b3dc9086a0c
registry.suse.com/cap/scf-syslog-scheduler:a86db5183a5020d78761768459534952cc318a6f
registry.suse.com/cap/scf-secret-generation:264950e2f99eac71ecdac4310d84578310d09500
registry.suse.com/cap/scf-diego-brain:c1fc6a6dab4a9c43b742b35a5c11202599f16f4a
registry.suse.com/cap/scf-blobstore:f7397e573a02230aef520eb39081c9a7a558c74b
registry.suse.com/cap/scf-doppler:b370ae6b9201603b3c02258aeefb97d21d38627a
registry.suse.com/cap/scf-diego-cell:b86a68a37ef10a4c0d70be3b1ebc153185bc9e0c
registry.suse.com/cap/scf-api-group:d0a6d459155cd2beb5494cb6aa22ef02acba8ee7
registry.suse.com/cap/scf-diego-api:d6aee9d19703e2a538777a1968cf895bd1094b89
registry.suse.com/cap/scf-autoscaler-actors:a9335a1ebb2338f0fa79a2e474ce1a2221c75025
registry.suse.com/cap/scf-adapter:a05f1470229de60d6525965430a0c672c205c4ea
registry.suse.com/cap/scf-autoscaler-metrics:947984d1d0d0070ac7005c1ba815e3607915c8af

registry.suse.com/cap/stratos-console:2.2.0-c558096-cap
registry.suse.com/cap/stratos-postflight-job:2.2.0-c558096-cap
registry.suse.com/cap/stratos-jetstream:2.2.0-c558096-cap
registry.suse.com/cap/stratos-mariadb:2.2.0-c558096-cap

registry.suse.com/cap/stratos-metrics-nginx:1.0.0-e913e7f-cap
registry.suse.com/cap/stratos-metrics-firehose-exporter:1.0.0-e913e7f-cap
registry.suse.com/cap/stratos-metrics-kube-state-metrics:1.0.0-e913e7f-cap
registry.suse.com/cap/stratos-metrics-prometheus:1.0.0-e913e7f-cap
registry.suse.com/cap/stratos-metrics-firehose-init:1.0.0-e913e7f-cap
"

echo
echo "Mirroring container images ..."
echo "-------------------------------------------------------"
for IMAGE in ${CONTAINER_LIST}
do
  echo "-${IMAGE}"
  skopeo copy --dest-tls-verify=false docker://${IMAGE} docker://${REGISTRY}:5000/${IMAGE}
done
