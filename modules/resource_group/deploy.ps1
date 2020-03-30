# Azure resource group deployment

Param(
       
    [Parameter(Mandatory = $false,
    HelpMessage= "Subscription ID")]
    [Alias ('a')]
    [string] $subscriptionId,
      
    [Parameter(Mandatory = $false,
    HelpMessage= "Resource Group Name")]
    [Alias ('b')]
    [string] $resourceGroupName,

    [Parameter(Mandatory = $false,
    HelpMessage= "Deployment Name")]
    [Alias ('c')]
    [string] $resourceDeploymentName,

    [Parameter(Mandatory = $false,
    HelpMessage= "location")]
    [Alias ('d')]
    [string] $location
)

# Get the template file and save in a variable '$templateFile'
$TemplateFile = "..\modules\resource_group\azuredeploy.json"
if ((Test-Path $TemplateFile)) 
{ 
    if (    !([string]::IsNullOrEmpty($subscriptionId)) -and `
            !([string]::IsNullOrEmpty($resourceGroupName)) -and `
            !([string]::IsNullOrEmpty($resourceDeploymentName)) -and `
            !([string]::IsNullOrEmpty($location))  )
    {
        # Select Azure subscription to deploy resource in
        $sub = Select-AzSubscription -Subscription $subscriptionId -ErrorAction SilentlyContinue

        if ( $sub )
        {

            # Check if resource group already exists
            $rg = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue

            if ( !$rg )
            {
                # Deploy resource group in the subscription
                Write-Host -Object "Creating resource group name: $resourceGroupName in subscription $($sub.Subscription.Name)" -BackgroundColor Green -ForegroundColor White
                New-AzDeployment -Name $resourceDeploymentName `
                -TemplateFile $TemplateFile `
                -resourceGroupName $resourceGroupName `
                -Location $location `
                -resourceGroupLocation $location

                Write-Host -Object "Resource group name: $resourceGroupName was successfully deployed" -BackgroundColor Green -ForegroundColor White
            }
            else
            {
                Write-Host -Object "Resource group name: $resourceGroupName already esist under subscription $($sub.Subscription.Name)" -BackgroundColor Red -ForegroundColor White
            }
        }
        else
        {
            Write-Host -Object "Subscription Id: $subscriptionId doesn't exist under $((Get-AzContext).Tenant) Tenant" -BackgroundColor Red -ForegroundColor White
        }
    }

    else
    {
        Write-Host -Object "Either subscription ID, resource group name, location is missing " -BackgroundColor Red -ForegroundColor White
    }
}
else
{
    Write-Host -Object "Template file $TemplateFile does not exist" -BackgroundColor Red -ForegroundColor White
}