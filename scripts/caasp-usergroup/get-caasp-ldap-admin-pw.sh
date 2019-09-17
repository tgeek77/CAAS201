#!/bin/bash

# ldap password is now stored as a text file on the admin node.

ssh -qt root@192.168.110.99 cat /var/lib/misc/infra-secrets/openldap-password | tee ldappass.txt
