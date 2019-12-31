#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install python -y
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
sudo mkdir docker
sudo mkdir  docker/group_vars
sudo mv /tmp/docker-install.yml /home/ubuntu/docker/docker-install.yml
sudo mv /tmp/hosts /home/ubuntu/docker/hosts

###################
# Export all vars / NOT DELETE

#export servers_logstash
###################
# Run next script
#/tmp/elasticsearch.sh

#########################################

########    bennu_jobs_sh   #############

sudo mkdir /home/ubuntu/bennu_jobs_sh
sudo mv /tmp/Dockerfile /home/ubuntu/bennu_jobs_sh/Dockerfile
sudo mkdir /opt/jobs
sudo mkdir /opt/jobs/sh
sudo mv /tmp/entrypoint.sh /home/ubuntu/bennu_jobs_sh/entrypoint.sh

