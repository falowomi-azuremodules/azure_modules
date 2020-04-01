# Azure Standard Sku Public IP Address

## Getting Started

These repo would create azure standard sku public IP address

### Prerequisites

Must have an existing resource group

### Parameters

You need to provide the required listed below parameters in the deploy.ps1 script as an inline argument

**Mandatory Parameters**
| Argument Alias | Parameter Name | Description | Type | Example | Notes |
|----------------|----------------|-------------|------|---------|-------|
| -a | subscriptionId | Azure subscription Id. | string | `abcdefgh-1234-abcd-5678-abcd1234efgh` | - |
| -b | resourceGroupName | Existing resource group for the resource deployment. | string | `my_resourceGroup` | - |
| -c | resourceGroupDeploymentName | Azure resource group deployment name. | string | `subnetdeployment` | - |
| -d | publicIpName | Public IP address name. | string | `network-pip` | - |

### Deployment Usage

Module must be run in the complete-deploy directory. Script arguments 

`-a <subscriptionId> -b <resourceGroupName> -c <resourceGroupDeploymentName> -d <publicIpName>`

example: See below on how to run the module 'resouce deployment' from powershell

`..\modules\public_ip_standard\deploy.ps1 -a $subscriptionId -b $resourceGroupName -c $resourceGroupDeploymentName -d $publicIpName`

### Note: *All mandatory parameters must be supplied for the deployment to be successful.*