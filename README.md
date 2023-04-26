# Terraform Azure Component Automation
A project detailing the process of provisioning Azure cloud infrastructure using Terraform, which is an **Infrastructure as Code (IaC)** software tool.

<br />

## Overview ##

The project has several components. The main, being able to deploy Azure resources to the cloud. 

The process is codefied with Terraform, essentially automating the process of deployment rather than manual deployment via Azure Portal.

### Components ###

#### `backend.tf` ####

- Details to be added later

#### `main.tf` ####
<ul>
    <li>Code for setting up the main resources:</li>
    <ul>
        <li><b>Azure VM</b> (name, location, resource group, size, information related to the image, disk, and credentials for the profile to access)</li>
        <li><b>Azure Storage Account</b> (name, location, resource group, data replication type, and account tier)</li>
        <li><b>Azure Virtual Network</b> (name, location, address space, and resource group)</li>
        <li><b>Azure Subnet</b> (name, address-prefix, resource group, virtual network name)</li>
        <li><b>Azure Public IP Address</b> (name, location, resource group, allocation method)</li>
        <li><b>Azure Load Balancer</b> (name, location, resource group, and information related to the frontend IP configuration)</li>
    </ul>
</ul>

#### `providers.tf` ####
- Information related to the provider (in this case, Azure). Subscription ID is provided as a parameter for the configuration option

#### `variables.tf`
- Information related to the environment variables used to modularize code (string values for the resource group and location provided)

#### `virtual-machines.tf`
<ul>
    <li>Code for provisioning additional resources:</li>
    <ul>
        <li><b>Azure Availability Set</b> (name, location, resource group, managed)</li>
        <li><b>Azure Network Interface</b> (name, location, resource group, and information related to IP configuration)</li>
        <li><b>Azure Storage Container</b> (name, storage account name, container access type)</li>
    </ul>
</ul>

#### More details will be added as the project completes.
<br />

## Links

To learn more about <b>Terraform</b> check out the: [Terraform Site](https://www.terraform.io/)

To learn more about <b>Azure Cloud</b> check out the [Azure Cloud Site](https://azure.microsoft.com/).
