# Azure standard sku public IP address deployment

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
    HelpMessage= "Public IP Address Name")]
    [Alias ('d')]
    [string] $publicIpName
)

. ..\bin\confirm_access.ps1

confirm_access

# Get the template file and save in a variable '$templateFile'
$TemplateFile = "..\modules\public_ip_standard\azuredeploy.json"
if ((Test-Path $TemplateFile)) 
{ 
    if (    !([string]::IsNullOrEmpty($subscriptionId)) -and `
            !([string]::IsNullOrEmpty($resourceGroup)) -and `
            !([string]::IsNullOrEmpty($resourceGroupDeploymentName)) -and `
            !([string]::IsNullOrEmpty($publicIpName)) )
    {
        # Select Azure subscription to deploy resource in
        Select-AzSubscription -Subscription $subscriptionId
        # Check if public IP address name already exists in the resource group
        $pip = Get-AzPublicIpAddress -ResourceGroupName $resourceGroup -Name $publicIpName -ErrorAction SilentlyContinue
        
        if ( ! $subnet )
        {
            # Deploy public IP address
            Write-Host -Object "Creating public IP address name: $publicIpName in resource group $resourceGroup" -BackgroundColor Green -ForegroundColor White
            New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup `
            -Name $resourceGroupDeploymentName `
            -TemplateFile $templateFile `
            -publicIpName $publicIpName `
            -Mode Incremental

            Write-Host -Object "Public IP address name: $publicIpName was successfully deployed" -BackgroundColor Green -ForegroundColor White
        }
        else
        {
            Write-Host -Object "Public IP address name: $publicIpName already exist in resource group $resourceGroup" -BackgroundColor Red -ForegroundColor White
        }
    }

    else
    {
        Write-Host -Object "Either subscription ID, resource group name, deployment name, or and public IP address name is missing " -BackgroundColor Red -ForegroundColor White
    }   
}
else
{
    Write-Host -Object "Template file $TemplateFile does not exist" -BackgroundColor Red -ForegroundColor White
}