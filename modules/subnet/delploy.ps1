#Azure virtual network subnet deployment

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
    HelpMessage= "Subnet Name")]
    [Alias ('e')]
    [string] $subnetName,

    [Parameter(Mandatory = $false,
    HelpMessage= "Subnet Address Prefix")]
    [Alias ('f')]
    [string] $subnetAddressPrefix
)

#if ()
if (    !([string]::IsNullOrEmpty($subscriptionId)) -and `
        !([string]::IsNullOrEmpty($resourceGroup)) -and `
		!([string]::IsNullOrEmpty($resourceGroupDeploymentName)) -and `
		!([string]::IsNullOrEmpty($vnetName)) -and `
		!([string]::IsNullOrEmpty($subnetName)) -and `
        !([string]::IsNullOrEmpty($subnetAddressPrefix))  )
{
    #Select Azure subscription to deploy resource in
    Select-AzSubscription -Subscription $subscriptionId

    #Get the template file and save in a variable '$templateFile'
    $templateFile = "..\modules\subnet\azuredeploy.json"

    #Deploy subnet in an existing vnet Resource
    Write-Host -Object "Creating subnet name: $subnetName in vnet $vnetName" -BackgroundColor Green -ForegroundColor White
    New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup `
    -Name $resourceGroupDeploymentName `
    -TemplateFile $templateFile `
    -vnetName $vnetName `
    -subnetName $subnetName `
    -subnetAddressPrefix $subnetAddressPrefix `
    -Mode Incremental

    Write-Host -Object "Subnet name: $subnetName was successfully deployed" -BackgroundColor Green -ForegroundColor White
}

else
{
    Write-Host -Object "Either subscription ID, resource group name, deployment name, vnet name, subnet name or/and subnet address prefix is missing " -BackgroundColor Red -ForegroundColor White
}