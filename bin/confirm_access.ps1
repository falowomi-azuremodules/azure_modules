# Confirm access before deployment

Function confirm_access()
{
    $getContect = Get-AzContext -ErrorAction SilentlyContinue
    if( ![string]::IsNullOrEmpty($getContect) )
    {
        Write-Host -Object "Currently logged in as '$($getContect.Account.Id)'" -ForegroundColor White -BackgroundColor Green
    }
    else
    {
        Write-Host -Object "Azure context is null or empty. Please login to azure using 'Login-AzAccount from the PowerShell you are running the modules." -ForegroundColor White -BackgroundColor Red
        Break
    }
}