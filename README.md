# Terraform Azure Component Automation
A project detailing the process of provisioning Azure cloud infrastructure using Terraform, which is an **Infrastructure as Code (IaC)** software tool.

<br />

## Overview ##

The project has several components. The main, being able to deploy Azure resources to the cloud. 

The process is codefied with Terraform, essentially automating the process of deployment rather than manual deployment via Azure Portal.

### Evidences ###

- This folder contains screens of the Terraform deployment (`terraform apply`) as well as the Azure portal which is showcasing the deployed resources and information related to those deployed resources.

### Components ###

#### `backend.tf` ####

- This file deals with the backend configuration for the Azure infrastructure. With values related the resource group name, storage account name, and key. The resource group name is the default playground value given when setting up accounts on Azure portal and subscriptions.

<img src="/images/backend.png" height='250px' width='1000px' alt="Alt text" />

#### `main.tf` ####
<ul>
    <li>Code for setting up the main resources:</li>
    <ul>
        <li><b>Azure VM</b> (name, location, resource group, size, information related to the image, disk, and credentials for the profile to access)</li>
        <img src="/images/main_3.png" height='250px' width='750px' alt="Alt text" />
        <li><b>Azure Storage Account</b> (name, location, resource group, data replication type, and account tier)</li>
        <img src="/images/main_2.png" height='250px' width='750px' alt="Alt text" />
        <li><b>Azure Virtual Network</b> (name, location, address space, and resource group)</li>
        <li><b>Azure Subnet</b> (name, address-prefix, resource group, virtual network name)</li>
        <li><b>Azure Public IP Address</b> (name, location, resource group, allocation method)</li>
        <li><b>Azure Load Balancer</b> (name, location, resource group, and information related to the frontend IP configuration)</li>
        <img src="/images/main_1.png" height='250px' width='1000px' alt="Alt text" />
    </ul>
</ul>

#### `providers.tf` ####
- Information related to the provider (in this case, Azure). Subscription ID is provided as a parameter for the configuration option
<img src="/images/providers.png" height='250px' width='1000px' alt="Alt text" />

#### `variables.tf`
- Information related to the environment variables used to modularize code (string values for the resource group and location provided)
<img src="/images/variables.png" height='250px' width='1000px' alt="Alt text" />

#### `virtual-machines.tf`
<ul>
    <li>Code for provisioning additional resources:</li>
    <ul>
        <li><b>Azure Availability Set</b> (name, location, resource group, managed)</li>
        <li><b>Azure Network Interface</b> (name, location, resource group, and information related to IP configuration)</li>
        <li><b>Azure Storage Container</b> (name, storage account name, container access type)</li>
    </ul>
</ul>
<img src="/images/vm_1.png" height='250px' width='1000px' alt="Alt text" />

<br />

<img src="/images/vm_2.png" height='250px' width='750px' alt="Alt text" />

<br />

<img src="/images/vm_3.png" height='250px' width='1000px' alt="Alt text" />

<br />

## Links

To learn more about <b>Terraform</b> check out the: [Terraform Site](https://www.terraform.io/).

To learn more about <b>Azure Cloud</b> check out the [Azure Cloud Site](https://azure.microsoft.com/).