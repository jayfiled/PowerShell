Function enter-data
{
Write-Host ""
$Global:machinename = Read-Host "Enter the computername you wish to delete: "
Write-Host ""
}

enter-data

#function connect-sccm #I dont think it works because it is a function


$Credential = Get-Credential

$Session = New-PSSession -ComputerName chevsccm1 -ConfigurationName Microsoft.PowerShell32 #-Credential $Credential

Invoke-Command -Session $Session -ScriptBlock {

    cd "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\"

    Import-module .\ConfigurationManager.psd1

    CD CHE:\
}

Remove-CMDevice -Name "$Global:machinename"

$Done = Get-CMDevice -Name "$Global:machinename"

if ($done -eq $Error)
{
Write-Host ""
Write-Host "Successfully Deleted"
Write-Host ""
}

else
{
Write-Host ""
Write-Host "Something went wrong"
Write-Host ""
}

Remove-PSSession $Session

<# -- Add a loop as an option to delete more devices

$Reply = Read-Host "Would you like to delete another? Type 'Yes' or 'No' "

if ($Reply -eq 'Yes')
{

enter-data

}

Else
{

Write-Host "Ok, bye ";Remove-PSSession $Session

#>

#Delete the computer from AD

#Option to ask if you also want to delete from AD


$DelAD = Read-Host "Would you also like to delete from AD? Type y or n"

if ($DelAD -eq "y" )
{
import-module ActiveDirectory

Get-AdComputer -Identity "$Global:machinename" | Remove-ADObject -Recursive -Confirm:$false

    $Confirm = Get-ADComputer -Identity "$Global:machinename"

    if ($Confirm -eq $Error)
    {

    Write-Host ""
    Write-Host "Deleted"
    Write-Host ""

    }

    Else
    {
    Write-Host ""
    Write-Host "Sorry, I wasn't able to delete it"
    Write-Host ""
    }

}

Else

{
Write-Host ""
Write-Host "Ok, bye "
Write-Host ""
}


#Another way to acheive the same:

<#

Write-Host ""
Write-Host "This is a script to delete an computer from AD and from SCCM Config Manager"
Write-Host ""

$DelAD = Read-Host "Enter the computername: "

import-module ActiveDirectory

Get-AdComputer -Identity "$DelAD" | Remove-ADObject -Recursive -Confirm:$false


$Credential = Get-Credential

$Session = New-PSSession -ComputerName chevsccm1 -ConfigurationName Microsoft.PowerShell32 -Credential $Credential

Invoke-Command -Session $Session -ScriptBlock {

    cd "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\"

    Import-module .\ConfigurationManager.psd1

    CD CHE:
}


Remove-CMDevice -Name "$DelAD"

$Done = Get-CMDevice -Name "$DelAD"

if ($Done -eq $Error)
{

Write-Host "Successfully Deleted"

}

else
{

Write-Host "Something went wrong"

}

Remove-PSSession $Session

#>