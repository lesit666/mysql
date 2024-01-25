#!/bin/bash

# catchup steps to configure the controller container, the mysql servers containers and the router container
sudo mkdir -p /etc/ansible
sudo cp /ansible/ansible.cfg /etc/ansible/ansible.cfg
cd /ansible || exit
PYTHONUNBUFFERED=1
ANSIBLE_FORCE_COLOR=true
ansible-playbook --limit="all" --inventory-file=inventory/hosts -v main.yml
