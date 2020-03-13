#!/bin/bash

echo "deleting all images and restarting the registry service."
rm -rf /srv/registry/docker/registry/v2/*
docker restart registry
