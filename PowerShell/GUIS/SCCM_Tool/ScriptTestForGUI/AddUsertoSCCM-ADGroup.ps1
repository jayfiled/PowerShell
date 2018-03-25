Import-Module ActiveDirectory

Write-Host "You'll be asked to enter the username of the person you wish to Add to remote access groups"

$Username = Read-Host "Enter Username:"

Add-ADGroupMember -Identity "Xenapp Remote Users" -Members "$Username"

