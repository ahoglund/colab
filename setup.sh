#!/bin/bash

sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update -y
sudo apt-get install -y ansible

cd /tmp
git clone git@github.com:ahoglund/colab.git

cd /tmp/colab
sudo ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml
