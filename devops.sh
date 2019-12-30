#!/bin/bash
echo "Iniciando y desplegando ejercicio DevOps"
terraform init
terraform plan
terraform apply -auto-approve