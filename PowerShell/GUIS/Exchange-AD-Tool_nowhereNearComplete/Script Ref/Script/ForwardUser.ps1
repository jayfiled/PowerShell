Function Check-User
{

Write-Host ""
$CheckUser = Read-Host "Enter part of the users name or surname: "
Write-Host ""

$CheckUserMB = Get-Mailbox *$CheckUser*

Foreach ($result in $CheckUserMB) {Write-Host $result.Alias}

Write-Host ""
Write-Warning "Now you can copy and paste the username in the next section.. "
Write-Host ""
Start-Sleep -Seconds 2

}


Write-Host ""
$User = Read-Host "Enter the name or part of the name of the person you'd like to forward to to get a list of email addresses: "
Write-Host ""

Write-Host ""
Write-Warning "Connecting to exchange remotely.. please wait"
Write-Host ""

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session

$MBuser = Get-Mailbox *$User*

Write-Host ""
Write-Host "Copy the email address you want to forward to"
Write-Host ""

foreach ($user in $MBuser) {Write-host $user.PrimarySmtpAddress}

Write-Host ""
$Forwardto = Read-Host "Paste that address here: "
Write-Host ""

Write-Host ""
$q = Read-Host "Do you know the username of the person you want to forward? y/n "
Write-Host ""

if ($q -eq "n") {

    Check-User

}
Else {continue}

Function Check-User
{

Write-Host ""
$CheckUser = Read-Host "Enter part of the users name or surname: "
Write-Host ""

$CheckUserMB = Get-Mailbox *$CheckUser*

Foreach ($result in $CheckUserMB) {Write-Host $result.Alias}

Write-Host ""
Write-Warning "Now you can copy and paste the username in the next step.. "
Write-Host ""
Start-Sleep -Seconds 2

}


Write-Host ""
$Forward = Read-Host "Who do you want to forward? (Enter their username): "
Write-Host ""

Set-Mailbox -Identity $Forward -ForwardingAddress $Forwardto


Write-Host ""
Write-Host "$Forward's email is now forwarding to: " (Get-Mailbox $Forward).ForwardingAddress
Write-Host ""

Remove-PSSession $Session