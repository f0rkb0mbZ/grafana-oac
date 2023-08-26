# Automate your Grafana OSS stack deployment in GCP with IaC tools

This is a companion repository of my talk on the same mentioned above.

Slide Deck: [link](https://bit.ly/45co2ge)

## Prerequisites
1. Replace the default values in `variables.tf` with your own configuration, e.g. replace <your_cloudflare_api_token> with the actual token.
2. Create a gcp service account with full permission and download the service account json key.
3. Replace the string <your_gcp_service_account> in `provider.tf` with the service account file name.

## Install Terraform
Go to this [link](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform) to download and install as per your OS specific instruction.

## Install Ansible
Go to this [link](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) to download and install ansible. Unfortunately ansible does not run on windows, however you can hack your way to run ansible in windows using Windows Subsystem for Linux (WSL) or run ansible inside a linux docker container. Make sure ansible and all of it's commands, like `ansible-galaxy`, `ansible-playbook` are available in system `$PATH`.

## Run the installation
```bash
$ terraform init # Initializes terraform in current directory, and download provider dependencies
$ terraform plan -out=tfplan # Plans the infrastructure according to our config and outputs a frozen binary plan file named tfplan
$ terraform apply tfplan # Applies the plan and starts provisioning the resources. Does not stop until every action is completed.
$ terraform destroy # Cleans up all the provisioned infrastructure
```
