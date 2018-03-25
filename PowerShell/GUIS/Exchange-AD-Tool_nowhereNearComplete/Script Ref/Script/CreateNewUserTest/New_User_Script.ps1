#Connect remotely to the exchange server & load Exchange module

$UserCredential = Get-Credential

$Global:Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#servername#>/Powershell/ -Authentication Kerberos -Credential $UserCredential

Import-PSSession $Session
   
Remove-PSSession $Global:Session


Param (
    
    [Parameter(Mandatory=$True)]
    $givenname,

    [Parameter(Mandatory=$True)]
    $surname,

    [Parameter(Mandatory=$True)]    
    $template,

    $password = "Welcome2APT!",
    [switch]$enabled,
    $changepw = $true,
    $ou,
    [switch]$useTemplateOU
)
$name = "$givenname $surname"
$samaccountname = "$($givenname[0])$surname"
$password_ss = ConvertTo-SecureString -String $password -AsPlainText -Force
$template_obj = Get-ADUser -Identity $template
If ($useTemplateOU) {
    $ou = $template_obj.DistinguishedName -replace '^cn=.+?(?<!\\),'
}
$params = @{
    "Instance"=$template_obj
    "Name"=$name
    "DisplayName"=$name
    "GivenName"=$givenname
    "SurName"=$surname
    "AccountPassword"=$password_ss
    "Enabled"=$enabled
    "ChangePasswordAtLogon"=$changepw
}
If ($ou) {
    $params.Add("Path",$ou)
}
New-ADUser @params

<#

#This may be an alternative approach

$OU = $Template |
    Select-Object @{n='ParentContainer';e={$_.distinguishedname -replace "CN=$($_.cn),"}}

Get-ADUser -Identity "ICT Template" -Properties memberof | select -ExpandProperty memberof | % {Add-ADGroupMember -Identity $_ -Members $SamAccountName}

#From here: https://community.spiceworks.com/topic/442889-copy-ad-user-with-powershell

#>