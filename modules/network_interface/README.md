# Azure Network Interface

## Getting Started

These repo would create azure network interface


### Prerequisites

Must have an existing resource group
Must have an existing Vnet and subnet

### Parameters

You need to provide the required listed below parameters in the deploy.ps1 script as an inline argument

**Mandatory Parameters**
| Argument Alias | Parameter Name | Description | Type | Example | Notes |
|----------------|----------------|-------------|------|---------|-------|
| -a | subscriptionId | Azure subscription Id. | string | `abcdefgh-1234-abcd-5678-abcd1234efgh` | - |
| -b | resourceGroupName | Existing resource group for the resource deployment. | string | `my_resourceGroup` | - |
| -c | resourceGroupDeploymentName | Azure resource group deployment name. | string | `subnetdeployment` | - |
| -d | vnetName | Virtual network name. | string | `Management_Network` | - |
| -e | subnetName | Subnet Name. | string | `WebServer` | - |
| -f | nicName | Network interface name. | string | `nic1` | - |

### Deployment Usage

Module must be run in the complete-deploy directory. Script arguments 

`-a <subscriptionId> -b <resourceGroupName> -c <resourceGroupDeploymentName> -d <vnetName> -e <subnetName> -f <nicName>`

example: See below on how to run the module 'resouce deployment' from powershell

`..\modules\network_interface\deploy.ps1 -a $subscriptionId -b $resourceGroupName -c $resourceGroupDeploymentName -d $vnetName -e $subnetName -f $nicName`

### Note: *All mandatory parameters must be supplied for the deployment to be successful.*