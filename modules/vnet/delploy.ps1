#Azure virtual network deployment

Param(
       
    [Parameter(Mandatory = $false,
    HelpMessage= "Subscription ID")]
    [Alias ('a')]
    [string] $subscriptionId,
      
    [Parameter(Mandatory = $false,
    HelpMessage= "Resource Group Name")]
    [Alias ('b')]
    [string] $resourceGroup,

    [Parameter(Mandatory = $false,
    HelpMessage= "Resource Group Deployment Name")]
    [Alias ('c')]
    [string] $resourceGroupDeploymentName,

    [Parameter(Mandatory = $false,
    HelpMessage= "Virtual Network Name")]
    [Alias ('d')]
    [string] $vnetName,

    [Parameter(Mandatory = $false,
    HelpMessage= "Virtual Network Address Prefix")]
    [Alias ('e')]
    [string] $vnetAddressPrefix
)

#if ()
if (    !([string]::IsNullOrEmpty($subscriptionId)) -and `
        !([string]::IsNullOrEmpty($resourceGroup)) -and `
		!([string]::IsNullOrEmpty($resourceGroupDeploymentName)) -and `
		!([string]::IsNullOrEmpty($vnetName)) -and `
		!([string]::IsNullOrEmpty($vnetAddressPrefix))   )
{
    #Select Azure subscription to deploy resource in
    Select-AzSubscription -Subscription $subscriptionId

    #Get the template file and save in a variable '$templateFile'
    $templateFile = "..\modules\vnet\azuredeploy.json"

    #Deploy Vnet Resource
    Write-Host -Object "Creating vnet name: $vnetName in resource group $resourceGroup" -BackgroundColor Green -ForegroundColor White
    New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup `
    -Name $resourceGroupDeploymentName `
    -TemplateFile $templateFile `
    -vnetName $vnetName `
    -vnetAddressPrefix $vnetAddressPrefix `
    -Mode Incremental

    Write-Host -Object "Vnet name: $vnetName was successfully deployed" -BackgroundColor Green -ForegroundColor White
}

else
{
    Write-Host -Object "Either subscription ID, resource group name, deployment name, vnet name, or/and vnet address prefix is missing " -BackgroundColor Red -ForegroundColor White
}