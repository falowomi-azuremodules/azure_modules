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

#Get the template file and save in a variable '$templateFile'
$TemplateFile = "..\modules\vnet\azuredeploy.json"
if ((Test-Path $TemplateFile)) 
{ 
    if (    !([string]::IsNullOrEmpty($subscriptionId)) -and `
            !([string]::IsNullOrEmpty($resourceGroup)) -and `
            !([string]::IsNullOrEmpty($resourceGroupDeploymentName)) -and `
            !([string]::IsNullOrEmpty($vnetName)) -and `
            !([string]::IsNullOrEmpty($vnetAddressPrefix))   )
    {
        # Select Azure subscription to deploy resource in
        Select-AzSubscription -Subscription $subscriptionId

        # Check is vnet already exists
        $vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName -ErrorAction SilentlyContinue

        if ( !$vnet )
        {
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
            Write-Host -Object "Vnet name: $vnetName already exist under resource group $resourceGroup" -BackgroundColor Red -ForegroundColor White
        }
    }

    else
    {
        Write-Host -Object "Either subscription ID, resource group name, deployment name, vnet name, or/and vnet address prefix is missing " -BackgroundColor Red -ForegroundColor White
    } 
}
else
{
    Write-Host -Object "Template file $TemplateFile does not exist" -BackgroundColor Red -ForegroundColor White
}