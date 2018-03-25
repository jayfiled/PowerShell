

#Connect to sccm posh remotely

#$Credential = Get-Credential

<#

$Session = New-PSSession -ComputerName chevsccm1 -ConfigurationName Microsoft.PowerShell32 -Credential $Credential

Invoke-Command -Session $Session -ScriptBlock {

    cd "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\"

    Import-module .\ConfigurationManager.psd1

    CD CHE:
}

#>

$Session = Enter-PSSession -Computername chevsccm1 -ConfigurationName Microsoft.Powershell32 #-Credential $Credential

cd '\\chevsccm1\C$\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin'

Import-Module .\ConfigurationManager.psd1 -Verbose

cd '\\chevsccm1\C$\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin'

cd CHE:



$remoteMachine = Read-Host "Please enter the computername: "

Initiate-Policy

Function Initiate-Policy
{
$trigger = "{00000000-0000-0000-0000-000000000021}"

Invoke-WmiMethod -ComputerName $remotemachine -Namespace root\ccm -Class sms_client -Name TriggerSchedule $trigger
}

#Add a loop to do more than one

Remove-PSSession $Session














#Ref: https://social.technet.microsoft.com/Forums/en-US/de0487a7-c0c7-4b33-b865-33e3f1cd2943/sccm-2012-sp1-howto-remotely-execute-powershell-commands?forum=configmanagersdk