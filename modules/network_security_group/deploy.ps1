# Azure network security group deployment

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
    HelpMessage= "Network Security Group Name")]
    [Alias ('d')]
    [string] $nsgName
)

. ..\bin\confirm_access.ps1

confirm_access

# Get the template file and save in a variable '$templateFile'
$TemplateFile = "..\modules\network_security_group\azuredeploy.json"
if ((Test-Path $TemplateFile)) 
{ 
    if (    !([string]::IsNullOrEmpty($subscriptionId)) -and `
            !([string]::IsNullOrEmpty($resourceGroup)) -and `
            !([string]::IsNullOrEmpty($resourceGroupDeploymentName)) -and `
            !([string]::IsNullOrEmpty($nsgName))  )
    {
        # Select Azure subscription to deploy resource in
        Select-AzSubscription -Subscription $subscriptionId
        # Check if nsg already exist in the resource group
        $nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Name $nsgName -ErrorAction SilentlyContinue
        
        if ( ! $nsg )
        {
            # Deploy subnet in an existing vnet Resource
            Write-Host -Object "Creating subnet name: $nsgName in resource group $resourceGroup" -BackgroundColor Green -ForegroundColor White
            New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup `
            -Name $resourceGroupDeploymentName `
            -TemplateFile $templateFile `
            -nsgName $nsgName `
            -Mode Incremental

            Write-Host -Object "Network security group name: $nsgName was successfully deployed" -BackgroundColor Green -ForegroundColor White
        }
        else
        {
            Write-Host -Object "Network security group name: $nsgName already exist in the resource group $resourceGroup" -BackgroundColor Red -ForegroundColor White
        }
    }

    else
    {
        Write-Host -Object "Either subscription ID, resource group name, deployment name, network security group name is missing " -BackgroundColor Red -ForegroundColor White
    }   
}
else
{
    Write-Host -Object "Template file $TemplateFile does not exist" -BackgroundColor Red -ForegroundColor White
}