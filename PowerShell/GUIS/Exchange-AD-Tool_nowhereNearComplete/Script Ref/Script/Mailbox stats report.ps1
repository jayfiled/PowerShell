#Connect to Exchange
#$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session

#Change the username in line 11 to -resultsize unlimited for all mailboxes

$Username = Read-Host "Enter the user name: "

$AllMailboxes = @()
$Mailboxes = Get-Mailbox $Username | Select DisplayName, Database, IssueWarningQuota, ProhibitSendQuota, ProhibitSendReceiveQuota, Alias
foreach ($Mailbox in $Mailboxes){
    $MailboxStats = "" |Select  DisplayName,Database,IssueWarningQuota,ProhibitSendQuota,ProhibitSendReceiveQuota,TotalItemSize,ItemCount,StorageLimitStatus
    $Stats = Get-MailboxStatistics -Identity $Mailbox.Alias
    $MailboxStats.DisplayName = $Mailbox.DisplayName 
    $MailboxStats.Database = $Mailbox.Database
    $MailboxStats.IssueWarningQuota = $Mailbox.IssueWarningQuota
    $MailboxStats.ProhibitSendQuota =$Mailbox.ProhibitSendQuota
    $MailboxStats.ProhibitSendReceiveQuota =$Mailbox.ProhibitSendReceiveQuota
    $MailboxStats.TotalItemSize = $Stats.TotalItemSize
    $MailboxStats.ItemCount = $Stats.ItemCount
    $MailboxStats.StorageLimitStatus = $Stats.StorageLimitStatus
    $AllMailboxes += $MailboxStats
}
$OutPath = "<#SomewhereOnYourComputer.csv#>"
Remove-Item -Path $OutPath -ErrorAction SilentlyContinue
$AllMailboxes | Export-Csv $OutPath
Invoke-Item $OutPath

Remove-PSSession $Session