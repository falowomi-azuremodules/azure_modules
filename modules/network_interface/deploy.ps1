# Azure virtual network subnet deployment

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
    HelpMessage= "Network Interface Name")]
    [Alias ('f')]
    [string] $nicName
)

. ..\bin\confirm_access.ps1

confirm_access

# Get the template file and save in a variable '$templateFile'
$TemplateFile = "..\modules\network_interface\azuredeploy.json"
if ((Test-Path $TemplateFile)) 
{ 
    if (    !([string]::IsNullOrEmpty($subscriptionId)) -and `
            !([string]::IsNullOrEmpty($resourceGroup)) -and `
            !([string]::IsNullOrEmpty($resourceGroupDeploymentName)) -and `
            !([string]::IsNullOrEmpty($vnetName)) -and `
            !([string]::IsNullOrEmpty($subnetName)) -and `
            !([string]::IsNullOrEmpty($nicName))  )
    {
        # Select Azure subscription to deploy resource in
        Select-AzSubscription -Subscription $subscriptionId
        # Check if subnet name is availble in the vnet
        $vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName -ErrorAction SilentlyContinue
        $subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -ErrorAction SilentlyContinue
        
        if ( $subnet )
        {
            $subnetId = $subnet.Id
            # Check if network interface name already exists or not
            $nic = Get-AzNetworkInterface -ResourceGroupName $resourceGroup -Name $nicName -ErrorAction SilentlyContinue

            if ( ! $nic )
            {
                # Deploy network interface in resource group
                Write-Host -Object "Creating network interface name: $nicName in resource group $resourceGroup" -BackgroundColor Green -ForegroundColor White
                New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup `
                -Name $resourceGroupDeploymentName `
                -TemplateFile $templateFile `
                -subnetId $subnetId `
                -nicName $nicName `
                -Mode Incremental

                Write-Host -Object "Network interface name: $nicName was successfully deployed" -BackgroundColor Green -ForegroundColor White
            }
            else
            {
                Write-Host -Object "Network interface name: $nicName is already available in the resource group $resourceGroup" -BackgroundColor Red -ForegroundColor White
            }
        }
        else
        {
            Write-Host -Object "Subnet name: $subnetName isn't available in vnet $vnetName" -BackgroundColor Red -ForegroundColor White
        }
    }

    else
    {
        Write-Host -Object "Either subscription ID, resource group name, deployment name, vnet name, subnet name, nic name or and private ip allocation method is missing " -BackgroundColor Red -ForegroundColor White
    }   
}
else
{
    Write-Host -Object "Template file $TemplateFile does not exist" -BackgroundColor Red -ForegroundColor White
}