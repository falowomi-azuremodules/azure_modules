# Azure Resource Group

## Getting Started

These repo would create azure resource group in a subscription


### Prerequisites

Must have a subscription

### Parameters

You need to provide the required listed below parameters in the deploy.ps1 script as an inline argument

**Mandatory Parameters**
| Argument Alias | Parameter Name | Description | Type | Example | Notes |
|----------------|----------------|-------------|------|---------|-------|
| -a | subscriptionId | Azure subscription Id. | string | `abcdefgh-1234-abcd-5678-abcd1234efgh` | - |
| -b | resourceGroupName | Existing resource group for the resource deployment. | string | `my_resourceGroup` | - |
| -c | resourceDeploymentName | Azure resource deployment name. | string | `rgdeployment` | - |
| -d | location | Location where the reseouce group is deployed. | string | `northcentralus` | - |

### Deployment Usage

Module must be run in the complete-deploy directory. Script arguments 

`-a <subscriptionId> -b <resourceGroup> -c <resourceDeploymentName> -d <location>`

example: See below on how to run the module 'resouce deployment' from powershell

`..\modules\resource_group\deploy.ps1 -a $subscriptionId -b $resourceGroup -c $resourceDeploymentName -d $location`

### Note: *All mandatory parameters must be supplied for the deployment to be successful.*