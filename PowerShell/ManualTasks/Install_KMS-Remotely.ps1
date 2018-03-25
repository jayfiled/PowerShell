write-host 
$computername = Read-Host "Enter the computername (or IP address) to install the KMS key " 
write-host 

$sls = Get-WmiObject -Query 'SELECT * FROM SoftwareLicensingService' -ComputerName $computername

$sls.InstallProductKey((<#Enter KMS product key#>))
$sls.RefreshLicenseStatus()

start-sleep -seconds 5

$Check = Get-WmiObject -Query 'SELECT * FROM SoftwareLicensingService' -ComputerName $computername

IF ($Check.KeyManagementServiceProductKeyID -eq "06401-00206-491-436591-03-3081-9600.0000-2132017")
{
Write-Host ""
Write-host "KMS Key Installed" -BackgroundColor Yellow -ForegroundColor DarkBlue
Write-Host ""
}

Else

{
Write-Host ""
Write-Error "Something went wrong"
Write-Host ""
}

#Get-service -Computername $computername sppsvc | restart-service

#Reference: https://4sysops.com/archives/change-a-product-key-remotely-with-powershell/#comment-398499
