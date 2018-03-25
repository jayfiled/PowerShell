#Script requires RSAT to be installed on PC

#Connect to AD

Import-Module ActiveDirectory

#Function to get a username based off a part of their name and display possible candidates in a listbox

$Readhost = Read-Host "Do you know the username? ( y / n ) "

    Switch ($Readhost)
    {
    Y {Write-Host "Okie dokie"}
    N {Get-Username}
    } 

Function Get-Username
{

$Name = Read-Host "Ok, enter a part of their name to get a list of matches: "

$Output = (Get-ADUser -Identity *$Name*)

$Output | Write-Host

pause

}

#Create Variables

$User = Read-Host "Enter the username of the staff member to disable:"
$In3Months = ((Get-Date).AddMonths(3))

    #Disable nominated user
Disable-ADAccount -Name $User

    #Delete after xx to Description
Set-ADUser -Identity $User -Description "Delete after $In3Months"

    #Remove membership from all security & distribution lists
Get-ADprincipalGroupmembership -identity $User | where
{$_.Name -NotLike "Domain Users"} | foreach
{Remove-ADprincipalGroupmembership -identity $User -MemberOf $_ -Confirm:$FALSE}


#Connect to Exchange

    #Option to forward email

    #Hide from Exchange lists

    #Add full access permissions to select user

#Disconnect from Exchange


#Open Administrator to remove number, mailbox etc

#Open DiMetro to disable

#Open Salesforce to remove



<#

Ref: https://social.technet.microsoft.com/Forums/windowsserver/en-US/ce8c6622-2916-4c47-9a10-b867752fc945/get-date-and-add-one-month?forum=winserverpowershell



#>