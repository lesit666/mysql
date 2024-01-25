#!/bin/bash

cd /ansible || exit
PYTHONUNBUFFERED=1
ANSIBLE_FORCE_COLOR=true
ansible-playbook --limit="initial_mysql" --inventory-file=inventory/hosts -v main.yml --tags="transfer_mysql_sample_schemas,setup_mysql_sample_schemas"
