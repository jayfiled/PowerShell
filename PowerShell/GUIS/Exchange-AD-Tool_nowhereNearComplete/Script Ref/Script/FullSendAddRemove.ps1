Function Full-Add
{

Write-Host ""
$UsernameFullAccess = Read-Host "Enter the mailbox name to get access to: "
Write-Host ""

Write-Host ""
$MBFullAccess = Read-Host "Enter the user who needs permission: "
Write-Host ""

Write-Host ""
Write-Warning "Connecting to exchange remotely, then applying permissions.. please wait"
Write-Host ""

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session


Add-MailboxPermission -Identity $UsernameFullAccess -User $MBFullAccess -AccessRights 'FullAccess'

<#

$Accessaccounts = Get-MailboxPermission $UsernameFullAccess

Write-Host ""
Write-Warning "This is the list of all accounts with Full Access to $UsernameFullAccess - Check the changes you made : "
Write-Host $Accessaccounts

#>

Remove-PSSession $Session

}

Function Full-Remove
{


Write-Host ""
$UsernameFullAccess = Read-Host "Enter the mailbox name to remove access from: "
Write-Host ""

Write-Host ""
$MBFullAccess = Read-Host "Enter the user who needs to be removed: "
Write-Host ""

Write-Host ""
Write-Warning "Connecting to exchange remotely.. please wait"
Write-Host ""

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session


Remove-MailboxPermission -Identity $UsernameFullAccess -User $MBFullAccess  -InheritanceType 'All' -AccessRights 'FullAccess' -confirm:$false

<#

$Accessaccounts = Get-MailboxPermission $UsernameFullAccess

Write-Host ""
Write-Warning "This is the list of all accounts with Full Access to $UsernameFullAccess - Check the changes you made : "
Write-Host $Accessaccounts

#>

Remove-PSSession $Session


}

Function Send-Add
{

Write-Host ""
$UsernameSendAccess = Read-Host "Enter the mailbox name to get give send access to: "
Write-Host ""

Write-Host ""
$MBSendAccess = Read-Host "Enter the user who needs to send from it: "
Write-Host ""

Write-Host ""
Write-Warning "Connecting to exchange remotely.. please wait"
Write-Host ""



$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session

Import-Module Activedirectory

Add-ADPermission -Identity $UsernameSendAccess -User "APT\$MSSendAccess" -ExtendedRights 'Send-as'

Remove-PSSession $Session

}

Function Send-Remove
{


Write-Host ""
$UsernameRemoveSend = Read-Host "Enter the mailbox name to remove access from: "
Write-Host ""

Write-Host ""
$MBRemoveSend = Read-Host "Enter the user who needs to be removed: "
Write-Host ""

Write-Host ""
Write-Warning "Connecting to exchange remotely.. please wait"
Write-Host ""

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session

Import-Module Activedirectory

Remove-ADPermission -Identity $UsernameRemoveSend -User "apt\$MBRemoveSend" -InheritanceType 'All' -ExtendedRights 'send-as' -ChildObjectTypes $null -InheritedObjectType $null -Properties $null

Remove-PSSession $Session

}

#Do you want to Add / remove Full access permissions, or add / remove Send As permissions check

Write-Host ""
Write-Warning "You'll need the account alias for this to work, i.e, M.X.Lloyd "
Write-Host ""

Write-Host ""
$which = Read-Host "Do you want to Add / remove Full access permissions, or add / remove Send As permissions? Type: addfull / removefull / addsend / removesend then press enter "
Write-Host ""

switch ($which)
{
    addfull {Full-Add}
    removefull {Full-Remove}
    addsend {Send-Add}
    removesend {Send-Remove}
}


