#Load Assemblies
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null


$net = New-Object -ComObject Wscript.Network

#Display the main screen

Function Display-Mainscreen
{
$Form.Controls.Add($Label)
$Form.Controls.Add($Textbox)
$Form.Controls.Add($Button1)
}

#-----Button Click Actions-----#

	#Return Button Click Function

	#OK Button Click Function
    Function Get-SMSTS
    {
    #Create Text & Hostname Variables
    $Hostname = Hostname

    #Copy the SMSTS file from remote PC to own, then open it
    New-Item C:\Temp\RemoteSMSTS -ItemType Directory -ErrorAction SilentlyContinue
    Copy-Item \\$RemotePC\C$\Windows\CCM\Logs\SMSTSLog\SMSTS*.log \\$Hostname\C$\Temp\RemoteSMSTS\ -ErrorAction SilentlyContinue
    Invoke-Item \\$Hostname\C$\Temp\RemoteSMSTS\SMSTS*.log
    }

#-----Define All GUI Objects-----#

	# Define Label
    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Size(40,40)
    $Label.AutoSize = $True
    $Label.Font = New-Object System.Drawing.Font("Times New Roman",10,[System.Drawing.FontStyle]::Bold)
    $Label.ForeColor = "Black"
    $Label.Text = "Enter the computer name:"

    #Define Textbox
    $Textbox = New-Object System.Windows.Forms.TextBox
    $TextBox.Location = New-Object System.Drawing.Size(40,80)
    $Textbox.Size = New-Object System.Drawing.Size(120,30)
    $Textbox.Font = New-Object System.Drawing.Font("Times New Roman",15)
    $Textbox.Multiline = $True

	# Define Label 2
	# Define Label 3
	# Define List Box
	# Define Button 1
    $Button1 = New-Object System.Windows.Forms.Button
    $Button1.Location = New-Object System.Drawing.Size(40,130)
    $Button1.Size = New-Object System.Drawing.Size(120,40)
    $Button1.BackColor = "CadetBlue"
    $Button1.FlatStyle = "Flat"
    $Button1.Text = "Go"
    $Button1.Font = New-Object System.Drawing.Font("Times New Roman",10,[System.Drawing.FontStyle]::Bold)
    $Button1.Add_click({$Textbox.Text=$RemotePC;Get-SMSTS})
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
$Form.Text = "Grab SMSTS Logs"
$Form.Icon = New-Object System.Drawing.Icon("C:\Scripts\Get SMSTS Logs GUI\Resources\LogFiles.ico")
$Form.Add_KeyDown({if($_.Keycode -eq "Enter"){}})
    $Form.Add_KeyDown({if ($_.KeyCode -eq "Escape")
    {$Form.Close()}})
Display-Mainscreen

#-----Populate the Form-----#
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()
