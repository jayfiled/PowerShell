#connect to exchange:

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session

#Quickly get the forwarding address of a mailbox

$mb = Read-Host "Enter the mailbox name: "

$check = Get-Mailbox $mb

if ($check -eq $Error)
{Write-Warning "Mailbox name incorrect or too many results with similar mailbox name" }

Else 
{$MBfor = Get-Mailbox *$MB*;Write-Output $MBfor.ForwardingAddress}

Remove-PSSession $Session