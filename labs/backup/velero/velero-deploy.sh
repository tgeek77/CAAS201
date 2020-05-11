#!/usr/bin/bash

helm install \
    --name velero \
    --namespace velero \
    --set-file credentials.secretContents.cloud=credentials-velero \
    --set configuration.provider=aws \
    --set configuration.backupStorageLocation.name=default \
    --set configuration.backupStorageLocation.name=caasp \
    --set configuration.backupStorageLocation.=caasp \
    --set configuration.backupStorageLocation.bucket=caasp \
    --set configuration.backupStorageLocation.config.region=example \
    --set configuration.backupStorageLocation.config.s3ForcePathStyle=true \
    --set configuration.backupStorageLocation.config.s3Url=http://192.168.111.2:9000 \
    --set snapshotsEnabled=true \
    --set deployRestic=true \
    --set configuration.volumeSnapshotLocation.name=default \
    --set configuration.volumeSnapshotLocation.config.region=minio \
    --set initContainers[0].name=velero-plugin-for-aws \
    --set initContainers[0].image=registry.suse.com/caasp/v4/velero-plugin-for-aws:1.0.1 \
    --set initContainers[0].volumeMounts[0].mountPath=/target \
    --set initContainers[0].volumeMounts[0].name=plugins \
    suse/velero
