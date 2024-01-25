#!/bin/bash

# catchup ssl configuration for mysql servers
sudo mkdir -p /etc/ansible
sudo cp /ansible/ansible.cfg /etc/ansible/ansible.cfg
cd /ansible || exit
PYTHONUNBUFFERED=1
ANSIBLE_FORCE_COLOR=true
ansible-playbook --limit="all" --inventory-file=inventory/hosts -v ssl.yml
