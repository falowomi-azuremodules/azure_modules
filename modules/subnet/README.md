# Azure Virtual Network Subnet

## Getting Started

These repo would create azure virtual network subnet in an existing vnet


### Prerequisites

Must have an existing resource group
Must have an existing Virtual Network

### Parameters

You need to provide the required listed below parameters in the deploy.ps1 script as an inline argument

**Mandatory Parameters**
| Argument Alias | Parameter Name | Description | Type | Example | Notes |
|----------------|----------------|-------------|------|---------|-------|
| -a | subscriptionId | Azure subscription Id. | string | `abcdefgh-1234-abcd-5678-abcd1234efgh` | - |
| -b | resourceGroupName | Existing resource group for the resource deployment. | string | `my_resourceGroup` | - |
| -c | resourceGroupDeploymentName | Azure resource group deployment name. | string | `vnetdeployment` | - |
| -d | vnetName | Virtual network name. | string | `Management_Network` | - |
| -e | subnetName | Subnet Name. | string | `WebServer` | - |
| -f | subnetAddressPrefix | Subnet address prefix | string | `10.0.0.0` | - |

### Deployment Usage

Module must be run in the complete-deploy directory. Script arguments 

`-a <subscriptionId> -b <resourceGroupName> -c <resourceGroupDeploymentName> -d <vnetName> -e <subnetName> -f <subnetAddressPrefix>`

example: See below on how to run the module 'resouce deployment' from powershell

`..\modules\subnet\deploy.ps1 -a $subscriptionId -b $resourceGroupName -c $resourceGroupDeploymentName -d $vnetName -e $subnetName -f $subnetAddressPrefix`

### Note: *All mandatory parameters must be supplied for the deployment to be successful.*