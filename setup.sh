#!/bin/bash

# get repo that will install redmine; eventually it will be from Ansible Galaxy
git clone https://bitbucket.org/sbstrm/redmine-ansible.git roles/redmine-ansible
./setup-passwords.sh
./setup-credentials.sh
