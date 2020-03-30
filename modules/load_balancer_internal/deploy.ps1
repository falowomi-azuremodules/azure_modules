# Azure internal load balancer deployment

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
    HelpMessage= "Virtual Network Subnet Name")]
    [Alias ('e')]
    [string] $subnetName,

    [Parameter(Mandatory = $false,
    HelpMessage= "Private IP Address")]
    [Alias ('f')]
    [string] $privateIPAddress,

    [Parameter(Mandatory = $false,
    HelpMessage= "Load Balancer Name")]
    [Alias ('g')]
    [string] $loadBalancerName,

    [Parameter(Mandatory = $false,
    HelpMessage= "Load Balancer 'Basic or Standard'")]
    [Alias ('h')]
    [string] $loadBalancerSkuName
)

# Get the template file and save in a variable '$templateFile'
$TemplateFile = "..\modules\load_balancer_internal\azuredeploy.json"
if ((Test-Path $TemplateFile)) 
{ 
    if (    !([string]::IsNullOrEmpty($subscriptionId)) -and `
            !([string]::IsNullOrEmpty($resourceGroup)) -and `
            !([string]::IsNullOrEmpty($resourceGroupDeploymentName)) -and `
            !([string]::IsNullOrEmpty($vnetName)) -and `
            !([string]::IsNullOrEmpty($subnetName)) -and `
            !([string]::IsNullOrEmpty($privateIPAddress)) -and `
            !([string]::IsNullOrEmpty($loadBalancerName)) -and `
            !([string]::IsNullOrEmpty($loadBalancerSkuName))   )
    {
        # Select Azure subscription to deploy resource in
        Select-AzSubscription -Subscription $subscriptionId

        # Check if subnet name already exists in the vnet
        $vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName -ErrorAction SilentlyContinue
        $subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -ErrorAction SilentlyContinue
        
        if ( $subnet )
        {

            $subnetId = $subnet.Id
            # Check is load balancer already exists
            $lb = Get-AzLoadBalancer -ResourceGroupName $resourceGroup -Name $loadBalancerName -ErrorAction SilentlyContinue

            if ( !$lb )
            {
                # Deploy load balancer Resource
                Write-Host -Object "Creating load balancer  name: $loadBalancerName in resource group $resourceGroup" -BackgroundColor Green -ForegroundColor White
                New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup `
                -Name $resourceGroupDeploymentName `
                -TemplateFile $templateFile `
                -subnetId $subnetId `
                -loadBalancerName $loadBalancerName `
                -loadBalancerSkuName $loadBalancerSkuName `
                -privateIPAddress $privateIPAddress `
                -Mode Incremental

                Write-Host -Object "Load balancer name: $loadBalancerName was successfully deployed" -BackgroundColor Green -ForegroundColor White
            }
            else
            {
                Write-Host -Object "Load balancer name: $loadBalancerName already exist under resource group $resourceGroup" -BackgroundColor Red -ForegroundColor White
            }
        }
        else
        {
            Write-Host -Object "Either vnet '$vnetName' or Subnet '$subnetName' does not exist" -BackgroundColor Red -ForegroundColor White
        }
    }

    else
    {
        Write-Host -Object "Either subscription ID, resource group name, deployment name, vnet name, subnet name, private ip address, load balancer, or/and load balancer sku prefix is missing " -BackgroundColor Red -ForegroundColor White
    } 
}
else
{
    Write-Host -Object "Template file $TemplateFile does not exist" -BackgroundColor Red -ForegroundColor White
}