#Give Full Access

Write-Host ""
$UsernameFullAccess = Read-Host "Enter the mailbox name to get access to: "
Write-Host ""

Write-Host ""
$MBFullAccess = Read-Host "Enter the user who needs permission: "
Write-Host ""

Write-Host ""
Write-Warning "Connecting to exchange remotely.. please wait"
Write-Host ""

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session


Add-MailboxPermission -Identity $UsernameFullAccess -User $MBFullAccess -AccessRights 'FullAccess'

$Accessaccounts = Get-MailboxPermission $UsernameFullAccess

#$Output = $Accessaccounts | where {$_.User -Like "*$MBFullAccess*"}

#Write-Warning "Access Granted to: $output"

Remove-PSSession $Session