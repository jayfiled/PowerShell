#Connect to Exchange
#$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ #-Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session

$Username = Read-Host "Enter the user name: "

$SetWarn = Read-Host "How many MB before they get a warning? (Write MB or KB after the number with no spaces) "
$SetProhib = Read-Host "How many MB before they aren't able to send? (Write MB or KB after the number with no spaces) "

Set-Mailbox $Username -UseDatabaseQuotaDefaults $false -IssueWarningQuota $SetWArn -ProhibitSendQuota $SetProhib

$LimitCheck = Get-mailbox $Username

$LimitWarn = $LimitCheck.IssueWarningQuota

$LimitSend = $LimitCheck.ProhibitSendQuota

Write-Warning "Warning has been set to $LimitWarn and prohibited send at $LimitSend"


Remove-PSSession $Session




# Help on PowerShell's Else statements - http://www.computerperformance.co.uk/powershell/powershell_if_statement.htm
# $File = Get-Help about_if 
# If ($File -Match "The if Statement") {"We have the correct help file"}
# Else {"The string is wrong"}