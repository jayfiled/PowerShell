
#Give Full Access

Write-Host ""
$UsernameFullAccess = Read-Host "Enter the mailbox name to remove access to: "
Write-Host ""

Write-Host ""
$MBFullAccess = Read-Host "Enter the user who needs to be removed: "
Write-Host ""

Write-Host ""
Write-Warning "Connecting to exchange remotely.. please wait"
Write-Host ""

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session


Remove-MailboxPermission -Identity $UsernameFullAccess -User $MBFullAccess  -InheritanceType 'All' -AccessRights 'FullAccess' -Force

$Accessaccounts = Get-MailboxPermission $UsernameFullAccess

#$Output = $Accessaccounts | where {$_.User -Like "*$MBFullAccess*"}

#Write-Warning "Access Granted to: $output"

Remove-PSSession $Session