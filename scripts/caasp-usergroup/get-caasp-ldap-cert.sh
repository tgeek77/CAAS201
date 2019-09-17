#!/bin/bash

#OPENLDAP_CONTAINER_ID=$(ssh root@192.168.110.99 docker ps | grep openldap | awk '{ print $1 }')

#ssh -qt root@admin docker exec -i '$(docker ps | grep openldap | awk '{ print $1 }')' cat /etc/openldap/pki/ca.crt > ./ca.pem

ssh -qt root@admin "docker exec -i `docker ps | grep openldap | awk '{ print $1 }'` cat /etc/openldap/pki/ca.crt"
