# Azure Internal Load Balancer

## Getting Started

These repo would create azure internal load balancer in the specified resource groups


### Prerequisites

Must have an existing resource group

### Parameters

You need to provide the required listed below parameters in the deploy.ps1 script as an inline argument

**Mandatory Parameters**
| Argument Alias | Parameter Name | Description | Type | Example | Notes |
|----------------|----------------|-------------|------|---------|-------|
| -a | subscriptionId | Azure subscription Id. | string | `abcdefgh-1234-abcd-5678-abcd1234efgh` | - |
| -b | resourceGroupName | Existing resource group for the resource deployment. | string | `my_resourceGroup` | - |
| -c | resourceGroupDeploymentName | Azure resource group deployment name. | string | `lbdeployment` | - |
| -d | vnetName | Virtual network name. | string | `Management_Network` | - |
| -e | subnetName | Subnet Name. | string | `WebServer` | - |
| -f | privateIPAddress | Private IP address. | string | `10.0.0.5` | - |
| -g | loadBalancerName | Load balancer name. | string | `AzureLoadBalancer` | - |
| -h | loadBalancerSkuName | Load balancer Sku | string | `Basic` | Require `Basic or Standard` |

### Deployment Usage

Module must be run in the complete-deploy directory. Script arguments 

`-a <subscriptionId> -b <resourceGroupName> -c <resourceGroupDeploymentName> -d <vnetName> -e <subnetName> -f <privateIPAddress> -g <loadBalancerName> -h <loadBalancerSkuName>`

example: See below on how to run the module 'resouce deployment' from powershell

`..\modules\load_balancer_external\deploy.ps1 -a $subscriptionId -b $resourceGroupName -c $resourceGroupDeploymentName -d $vnetName -e $subnetName -f "10.0.0.5" -g $loadBalancerName -h $loadBalancerSkuName`

### Note: *All mandatory parameters must be supplied for the deployment to be successful.*