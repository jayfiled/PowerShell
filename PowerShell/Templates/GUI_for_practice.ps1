#Load Assemblies
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null


$net = New-Object -ComObject Wscript.Network

#Function to Display the Main Screen
Function Display-Mainscreen
{
$Form.Controls.Add($Textbox1)
$Form.Controls.Add($Button5)
}

#-----Button Click Actions-----#

	#Return Button Click Function
	#OK Button Click Function

    #Copy program shortcut Button Function


#-----Define All GUI Objects-----#

	# Define Label
	# Define Label 2
	# Define Label 3
	# Define List Box

    # Define SMSTS Text box
    $Textbox1 = New-Object System.Windows.Forms.TextBox
    $TextBox1.Location = New-Object System.Drawing.Size(40,80)
    $Textbox1.Size = New-Object System.Drawing.Size(120,40)
    $Textbox1.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox1.Multiline = $True

	# Define Button 1

    # Define Button 5
        #Copy Administrator Button
    $Button5 = New-Object System.Windows.Forms.Button
    $Button5.Location = New-Object System.Drawing.Size(40,130)
    $Button5.Size = New-Object System.Drawing.Size(120,40)
    $Button5.BackColor = "DodgerBlue"
    $Button5.FlatStyle = "Flat"
    $Button5.FlatAppearance.BorderColor = "CadetBlue"
    $Button5.Text = "Admin"
    $Button5.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button5.Add_click({Copy-Administrator})

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
$Form.Text = "Copy Administrator"
$Form.Icon = New-Object System.Drawing.Icon("C:\Scripts\Icons\Script.ico")
$Form.Add_KeyDown({if($_.Keycode -eq "Enter"){}})
    $Form.Add_KeyDown({if($_.Keycode -eq "Escape")
    {$Form.Close()}})
Display-MainScreen

#-----Populate the Form-----#
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()
