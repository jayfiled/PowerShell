#Connect to Exchange & Load Module
#$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/

Import-PSSession $Session

Import-Module "C:\Scripts\Exchange-AD-Tool GUI\Script Ref\Script\GetADUserLastLogonTime.psm1"

$FormUsername = Read-Host "Enter the username: "

$Output = Get-LastLogonTime -SamAccountName $FormUsername

Write-Host $Output

#Write a loop into the script to be able to enter as many names as you want & can terminate with Quit function

Function Quit

{

Remove-PSSession $Session

}
Quit
