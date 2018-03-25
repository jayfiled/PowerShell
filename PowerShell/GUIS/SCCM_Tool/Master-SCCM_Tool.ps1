<#

Home page with buttons:

1. Remote policy update  2. Groups  3. Imaging 

2. Groups page contains:

Import AD module (check to see if it works without defining it)

    Get AD SCCM groups and display in list item

    Select AD SCCM group and add or remove username or machine name from text field
    
    --Not sure if the below 2 are possible--

    Initiate an AD group forest update

    Deploy software to group

3. Imagining contains:

    Remote Connection to SCCM

    Delete nominated computername from devices

Connect to AD

    Delete nominated machine name from AD


Disconnect from remote SCCM session with form close. 

Future functions:


#>


#Load Assemblies
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

$net = New-Object -ComObject Wscript.Network

#Import Config manager module

#$Credential = Get-Credential

$Session = New-PSSession -ComputerName chevsccm1 -ConfigurationName Microsoft.PowerShell32 #-Credential $Credential

Invoke-Command -Session $Session -ScriptBlock {

    cd "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\"

    Import-module .\ConfigurationManager.psd1

    CD CHE:
}

#Function to Display the Main Screen

Function Display-Mainscreen
{
$Form.Controls.Add($Textbox1)
$Form.Controls.Add($Textbox2)
$Form.Controls.Add($Button1)
$Form.Controls.Add($Button2)
}


#Function to Update  the Chosen machine name's Policy

Function Initiate-Policy
{
$trigger = "{00000000-0000-0000-0000-000000000021}"

$remoteMachine = $Textbox1.Text

Invoke-WmiMethod -ComputerName $remotemachine -Namespace root\ccm -Class sms_client -Name TriggerSchedule $trigger
}

Function Delete-Machine
{

$Global:machinename = $Textbox2.Text

Remove-CMDevice -Name $Global:Machinename -Force

$DeviceDel = Get-CMDevice -Name $Global:Machinename

if ($DeviceDel -ne $True)
{

[System.Windows.Forms.MessageBox]::Show("Deleted Successfully","Success","OK","Information")

}

else
{

[System.Windows.Forms.MessageBox]::Show("Something went wrong, try manually","Failed","OK","Information")

}

}

#A function to add old PC to device collection 'Capture User Data'

Function Capture-Data
{

$Capturename = $Textbox3.Text

$Global:Comp = Get-CMDevice -name "$Capturename"

$CompID = $Global:Comp.ResourceID

Add-CMDeviceCollectionDirectMembershipRule -CollectionName "Capture User Data" -ResourceId "$compID"

}


#-----Button Click Actions-----#

	#Return Button Click Function
	#OK Button Click Function

#-----Define All GUI Objects-----#

	# Define Label
	# Define Label 2
	# Define Label 3

    # Define Remote Machine Textbox
    $Textbox1 = New-Object System.Windows.Forms.TextBox
    $TextBox1.Location = New-Object System.Drawing.Size(40,80)
    $Textbox1.Size = New-Object System.Drawing.Size(120,40)
    $Textbox1.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox1.Multiline = $True

    #Define Delete CM Device textbox
    $Textbox2 = New-Object System.Windows.Forms.TextBox
    $TextBox2.Location = New-Object System.Drawing.Size(40,140)
    $Textbox2.Size = New-Object System.Drawing.Size(120,40)
    $Textbox2.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox2.Multiline = $True

	# Define List Box
	# Define Button 1
        #Go button to make variable and pass it to the Initiate Policy function
    $Button1 = New-Object System.Windows.Forms.Button
    $Button1.Location = New-Object System.Drawing.Size(200,80)
    $Button1.Size = New-Object System.Drawing.Size(120,40)
    $Button1.BackColor = "DodgerBlue"
    $Button1.FlatAppearance.BorderSize = "0"
    $Button1.FlatStyle = "Flat"
    $Button1.Text = "Policy U/D"
    $Button1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button1.Add_Click({Initiate-Policy})

    # Define Button 5
    $Button2 = New-Object System.Windows.Forms.Button
    $Button2.Location = New-Object System.Drawing.Size(200,140)
    $Button2.Size = New-Object System.Drawing.Size(140,40)
    $Button2.BackColor = "DodgerBlue"
    $Button2.FlatAppearance.BorderSize = "0"
    $Button2.FlatStyle = "Flat"
    $Button2.Text = "Delete"
    $Button2.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button2.Add_Click({Delete-Machine})


	# Define Button 2
	# Define Button 3
	# Define Button 4

#-----Draw the Empty Form-----#
$Form = New-Object System.Windows.Forms.Form
$Form.Width = 600
$Form.Height = 350
$Form.StartPosition = "CenterScreen"
$Form.BackColor = "LightGray"
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
$Form.Text = "Trigger Machine Update Remotely"
#$Form.Icon = New-Object System.Drawing.Icon("C:\Scripts\Icons\Script.ico")
$Form.Add_KeyDown({if($_.Keycode -eq "Enter"){}})
    $Form.Add_KeyDown({if($_.Keycode -eq "Escape")
    {$Form.Close()}})
Display-Mainscreen

#-----Populate the Form-----#
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()