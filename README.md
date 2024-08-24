# Terraform - Azure Bootstrap

Bootstraps an environment for Terraform use on Azure.

## Chicken and egg problem

https://community.aws/content/2dy0xjEZtBOuAfGLNP9QNfXz89T/bootstrapping-terraform-automation-amazon-codecatalyst?lang=en

Automating your infrastructure is a great idea, but you need infrastructure to automate your infrastructure. There are three approaches to doing this:

* Clicking in the console to set everything up, aka "ClickOps"
* Using a CLI to create the resources for you with scripts, "Procedural"
* Using Terraform without storing the state file to bootstrap, then add in the state file configurations to store it

We will be using the 3rd option, have a look at the [Stack Overflow](https://stackoverflow.com/questions/47913041/initial-setup-of-terraform-backend-using-terraform/) discussion around approaches for more details on the trade-offs.


## Getting started

Let's get started setting this up! Firstly, login to the Azure CLI using:

```sh
az login
```

Should you have more than one Subscription, you can specify the Subscription to use via the following commands:

```sh
az account list
az account set --subscription="SUBSCRIPTION_ID"
```

Running terraform:

```sh
tofu init
tofu apply
```

Now uncomment backend settings on main.tf and execute:

```sh
tofu init -migrate-state
```

## Useful links

* https://learn.microsoft.com/en-us/azure/developer/terraform/get-started-windows-bash?tabs=bash
* [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=terraform)
* [Abbreviation recommendations for Azure resources](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
* [Import Cloudflare resources](https://developers.cloudflare.com/terraform/advanced-topics/import-cloudflare-resources)

## Useful Azure CLI commands

```sh
az vm list-sizes --location brazilsouth --output table
```

Creating remote state with Azure Storage Account using Azure CLI:

```sh
az group create --location eastus --name tfstate-rg
az storage account create --location eastus --name tfstate1sa --resource-group tfstate-rg --sku Standard_LRS
az storage container create --name tfstate --account-name tfstate1sa
```

```sh
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```
