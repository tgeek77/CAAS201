#!/bin/bash

REGISTRY="rmt.example.com"
CONTAINER_LIST="
gcr.io/google_containers/kubernetes-dashboard-amd64:v1.10.0
quay.io/external_storage/nfs-client-provisioner:latest
gcr.io/google_containers/busybox:1.24
mysql:5.6

#osbkit/minibroker:latest
splatform/minibroker:latest

registry.suse.com/cap/stratos-metrics-firehose-exporter:1.0.0-e913e7f-cap

registry.suse.com/cap/uaa-mysql:a2709f8c092ec8cc0df1c7cf0e875051dbf3a336
registry.suse.com/cap/uaa-secret-generation:e8b7807efc48eff191ae2486a98b444c50ac9329
registry.suse.com/cap/uaa-uaa:298ab0e141103f82a4c6d8c916ed08023305a62a

registry.suse.com/cap/scf-adapter:236f11b6f91d7dfca2cd4d8234d8f664a427a96c
registry.suse.com/cap/scf-api-group:5ceeb87a494a134680d8bf0e0c7a134e87f1a457
registry.suse.com/cap/scf-autoscaler-api:35837cc09beabffe547905c2dfa82288d47c92a9
registry.suse.com/cap/scf-autoscaler-eventgenerator:4a794e53a742080bc6212145444600cf768221c7
registry.suse.com/cap/scf-autoscaler-metrics:de32bfb59af45db06e5ff5b87251a9fa86003227
registry.suse.com/cap/scf-autoscaler-operator:97a1fad8a57590aaafa10581290a5366bb4f3695
registry.suse.com/cap/scf-autoscaler-postgres:784872609486f93489bfb3d1570abcdb3000ce7d
registry.suse.com/cap/scf-autoscaler-scalingengine:e75aea925ffe4e30ec54944d150afac3a2262702
registry.suse.com/cap/scf-autoscaler-scheduler:9fe3b956677ffed0da86d876b5931cbd2e3924e6
registry.suse.com/cap/scf-autoscaler-servicebroker:fe2a36e7b8b4029e6316e60b38f171637327b2d9
registry.suse.com/cap/scf-blobstore:173daf329db4cb571e3643f0c9e5ca18155fa984
registry.suse.com/cap/scf-cc-clock:24ae5e2fe5e3fa14efa022a78f64f196de840a53
registry.suse.com/cap/scf-cc-uploader:18afd8d33f43fb8cd640a1dd14bb80ebfc1c0966
registry.suse.com/cap/scf-cc-worker:51e2cd76307404ee4928fb92e6e013eb0a07fc1a
registry.suse.com/cap/scf-cf-usb-group:24479a374bd409d65f15db9954437b336eee6249
registry.suse.com/cap/scf-credhub-user:bddee32d4a2b6d717a01315bbf5487faa39c9e06
registry.suse.com/cap/scf-diego-api:b7d2c0bf0675edcaf499a71418a66918121b948c
registry.suse.com/cap/scf-diego-brain:51dc5786d36cab7a890e796caf25a5eadb5942d6
registry.suse.com/cap/scf-diego-cell:230ec1ae51f71993325fd76fd82673988a4949ae
registry.suse.com/cap/scf-diego-ssh:e04d1c0066a2d484da5e18a0094f3a727f44a454
registry.suse.com/cap/scf-doppler:a4e9b85c1dfda0f10ded70931c2621789f063f7f
registry.suse.com/cap/scf-log-api:07ca1a6afb5ed642cd56f080a7cbf491bd69788f
registry.suse.com/cap/scf-loggregator-agent:e6c3e7dff097a17b664461549ec727297c99f9b0
registry.suse.com/cap/scf-mysql:f7f4f881174a3445c068a19fd7b4c2de49a5776b
registry.suse.com/cap/scf-nats:e76694d49a5ab7561afae2fbcc2a3093a581f666
registry.suse.com/cap/scf-nfs-broker:bd158cd7daec3c5aa5ed174cbac878db97e2f5e7
registry.suse.com/cap/scf-post-deployment-setup:9c4d63483b0615695398d08f67f04d9e0f161571
registry.suse.com/cap/scf-router:1c569d8ece786c20e3d9b4623b3f10fa075b1e4d
registry.suse.com/cap/scf-routing-api:898e75afa129b740453be44ed0ff32f54f8a2e69
registry.suse.com/cap/scf-secret-generation:e1c0732a5afb51ce0e9c263d4b5e1dd45661014b
registry.suse.com/cap/scf-syslog-scheduler:f7609fad159eb92983b3591e0836cb6d69375610
registry.suse.com/cap/scf-tcp-router:e7b6077f358935445a23a3674821530c4b92f154

registry.suse.com/cap/stratos-console:2.3.0-3ce40f5d6-cap
registry.suse.com/cap/stratos-postflight-job:2.3.0-3ce40f5d6-cap
registry.suse.com/cap/stratos-proxy:2.3.0-3ce40f5d6-cap
registry.suse.com/cap/stratos-mariadb:2.3.0-3ce40f5d6-cap

"

echo
echo "Mirroring container images ..."
echo "-------------------------------------------------------"
for IMAGE in ${CONTAINER_LIST}
do
  echo "-${IMAGE}"
  skopeo copy docker://${IMAGE} docker://${REGISTRY}:5000/${IMAGE}
done

