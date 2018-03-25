


Function Remote {

$global:comp = Read-host "Computername? "

Write-Host ""
Write-Warning "This takes about 12 seconds.. "
Write-Host ""

Write-Host ""
Write-Warning "Turning on Remote Management Service on $global:comp .. "
Write-Host ""

$Service = Get-Service -Computername $global:comp winrm

$Service | start-service

Start-Sleep -Seconds 10

Write-Host ""
Write-Warning "Getting the info from $global:comp .. "
Write-Host ""

Get-WmiObject Win32_PnPSignedDriver -Computername $global:comp | select devicename, driverversion | where {$_.devicename -like "*intel*ethernet*"}

}

Function Stop-Services
{

Write-Host ""
Write-Warning "Stopping the Remote Management service on $global:comp .. "
Write-Host ""

Start-Sleep -Seconds 10

$Service | Start-Service

}

Function Local {

$global:comp = hostname

Get-WmiObject Win32_PnPSignedDriver -Computername $global:comp | select devicename, driverversion | where {$_.devicename -like "*intel*ethernet*"}


}


$global:comp = Read-host "Remote PC? y/n : "

if ($global:comp -eq "y"){

Remote; Stop-Services

} Else {

Local

}