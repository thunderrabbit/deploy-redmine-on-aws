#!/bin/bash

# get repos that will install redmine and SSL it.  eventually should be in Ansible Galaxy
git clone https://bitbucket.org/sbstrm/redmine-ansible.git roles/redmine-ansible
git clone https://bitbucket.org/sbstrm/letsencrypt-ansible.git roles/letsencrypt-ansible
./setup-passwords.sh
./setup-credentials.sh
