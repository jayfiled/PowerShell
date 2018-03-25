#Connect to SCCM & load SCCM module
cd 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin'
Import-Module .\ConfigurationManager.psd1
cd CHE:

#Add old PC to device collection 'Capture User Data'
$Global:compname = Read-Host "1. Please type the computername to copy user profile FROM? "

$Comp = Get-CMDevice -name "$Global:compname"

$CompID = $Comp.ResourceID

Add-CMDeviceCollectionDirectMembershipRule -CollectionName "Capture User Data" -ResourceId "$CompID"

#Update Machine policy for old computer

Write-Host ""
Write-Host "****If the computer is on and is registered in DNS, please wait while I update the machine policy on that computer so that you can capture their profile straight away... ****"
Write-Host ""

Function Initiate-Policy
{
$trigger = "{00000000-0000-0000-0000-000000000021}"

Invoke-WmiMethod -ComputerName $Global:compname -Namespace root\ccm -Class sms_client -Name TriggerSchedule $trigger
}

Initiate-Policy

Write-Host ""
Write-Host "Done"
Write-Host""

    #Manual - run Capture State TS on old PC
    Write-Host ""
    Write-Host "2. Go and run the Capture State Task Sequence on the PC being replaced before continuing "
    Write-Host""


#Create User State Migration association between old PC and new one

Write-Host ""
Write-Host "3. Add the association between computer being replaced and new computer in Config manager before continuing: (Assets and Compliance --> Overview --> User state migration) "
Write-Host ""

#Add new computer name to device collection 'Restore User State

$Global:compname2 = Read-Host "4. - Please enter the computername to copy user profile TO (Newly imaged PC)? "

$Comp2 = Get-CMDevice -name "$Global:compname2"

$CompID2 = $Comp2.ResourceID

Add-CMDeviceCollectionDirectMembershipRule -CollectionName "Restore User Data" -ResourceId "$CompID2"

#Update Machine Policy for new computer

Function Initiate-Policy1
{
$trigger = "{00000000-0000-0000-0000-000000000021}"

Invoke-WmiMethod -ComputerName $Global:compname2 -Namespace root\ccm -Class sms_client -Name TriggerSchedule $trigger
}

Write-Host ""
Write-Host "****If the new computer is on and registered in DNS, please wait while I update the machine policy on that computer so that you can capture their profile straight away... ****"
Write-Host ""

Initiate-Policy1

Write-Host ""
Write-Host "Done"
Write-Host""

    #Manual - run Restore State TS on old PC

    Write-Host ""
    Write-Host "5. Now go and run the Restore state task sequence on the new computer "
    Write-Host ""