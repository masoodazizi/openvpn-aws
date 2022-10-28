# Setup OpenVPN Server in AWS
Deploy the resources and configuration needed to setup a VPN server on AWS

## Prerequisite

The AMI must be first subscribed by AWS Marketplace.
If the product ID is consistent, you can access the OpenVPN Access product by the following link, if you have already signed in:
https://aws.amazon.com/marketplace/server/configuration?productId=fe8020db-5343-4c43-9e65-5ed4a825c931

AMI ID for a specific region can also be obtained from the page above.

## Variables

The Terraform variables are defined in the file `terraform.tfvars`. They need to be updated before execution.
