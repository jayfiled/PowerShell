#Load Assemblies
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null


$net = New-Object -ComObject Wscript.Network

#Function to Display the Main Screen



#-----Button Click Actions-----#

	#Return Button Click Function
	#OK Button Click Function

#-----Define All GUI Objects-----#

	# Define Label
	# Define Label 2
	# Define Label 3
	# Define List Box
	# Define Button 1
    # Define Button 5
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
$Form.Text = "Program name--"
$Form.Icon = New-Object System.Drawing.Icon("C:\Scripts\Icons\Script.ico")
$Form.Add_KeyDown({if($_.Keycode -eq "Enter"){}})
    $Form.Add_KeyDown({if($_.Keycode -eq "Escape")
    {$Form.Close()}})

#-----Populate the Form-----#
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()


<#

#For Example the below script to generate a Windows form GUI for a simple Powershell cmdlet for Hyper-V

#Load Assemblies
[System.Reflection.Assembly]::LoadWithPartialName(“System.Windows.Forms”) | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName(“System.Drawing”) | Out-Null
$net = New-Object -ComObject Wscript.Network
 
 
 
 
# Display the Main Screen
Function Display-MainScreen
{
$Form.Controls.Add($ListBox1)
$Form.Controls.Add($Button1)
$Form.Controls.Add($Button2)
$Form.Controls.Add($Label2)
}
 
 
 
 
# ———- Button Click Actions ——
 
 
#Define Return Button Click Function
Function Return-MainScreen
{
 
$Form.Controls.Remove($Label)
$Form.Controls.Remove($Label3)
$Form.Controls.Remove($Button3)
$Form.Controls.Remove($Button4)
$Form.Refresh()
Display-MainScreen
}
 
 
 
 
#Define OK Button Click Function
Function Display-VMInfo($ChosenItem)
{
 
#Clear the window
$Form.Controls.Remove($ListBox1)
$Form.Controls.Remove($Label2)
$Form.Controls.Remove($Button1)
$Form.Controls.Remove($Button2)
$Form.Refresh()
 
#Create Output
Add-Type -AssemblyName System.Windows.Forms
 
#Create text
$Label.Text = $ChosenItem
$Form.Controls.Add($Label)
$Form.Controls.Add($Label3)
$Form.Controls.Add($Button3)
$Form.Controls.Add($Button4)
}
 
 
 
 
 
#—— Define All GUI Objects——-
 
# Define Label – This is a text box object that will display VM data
$Label = New-Object System.Windows.Forms.textbox
$Label.Location = new-object System.Drawing.Size(50,50)
$Label.Size = New-Object System.Drawing.Size(250,150)
$Label.MultiLine = $True
 
 
# Define Label2 – The Please Make a Selection Text
$Label2 = New-Object System.Windows.Forms.Label
$Label2.AutoSize = $True
$Label2.Location = new-object System.Drawing.Size(20,50)
$Label2.ForeColor = “DarkBlue”
$Label2.Text = “Please select a virtual machine from the list.”
 
 
# Define Label3 – The This is Your Selected Virtual Machine Text
$Label3 = New-Object System.Windows.Forms.Label
$Label3.AutoSize = $True
$Label3.Location = new-object System.Drawing.Size(50,30)
$Label3.ForeColor = “DarkBlue”
$Label3.Text = “Your selected virtual machine:”
 
 
# Define List Box – This will display the virtual machines that can be selected
$ListBox1 = New-Object System.Windows.Forms.ListBox
$ListBox1.Location = New-Object System.Drawing.Size(20,80)
$ListBox1.Size = New-Object System.Drawing.Size(260,20)
$ListBox1.Height = 80
 
                # This code populates the list box with virtual machine names
                $VirtualMachines = Get-VM
                ForEach ($VM in $VirtualMachines)
                                {
                                [void] $ListBox1.Items.Add($VM.Name)
                                }
 
 
# Define Button 1  – This is the selection screen’s OK button
$Button1 = new-object System.Windows.Forms.Button
$Button1.Location = new-object System.Drawing.Size(20,170)
$Button1.Size = new-object System.Drawing.Size(70,30)
$Button1.BackColor =”LightGray”
$Button1.Text = “OK”
$Button1.Add_Click({$ChosenItem=$ListBox1.SelectedItem;Display-VMInfo $ChosenItem})
 
 
# Define Button 2 – This is the selection screen’s Cancel button
$Button2 = New-Object System.Windows.Forms.Button
$Button2.Location = New-Object System.Drawing.Size(120,170)
$Button2.Size = New-Object System.Drawing.Size(70,30)
$Button2.BackColor =”LightGray”
$Button2.Text = “Cancel”
$Button2.Add_Click({$Form.Close()})
 
 
# Define Button 3 – This is the Return to Main Screen button
$Button3 = New-Object System.Windows.Forms.Button
$Button3.Location = New-Object System.Drawing.Size(50,220)
$Button3.Size = New-Object System.Drawing.Size(70,30)
$Button3.BackColor =”LightGray”
$Button3.Text = “Return”
$Button3.Add_Click({Return-MainScreen})
 
 
# Define Button 4 – This button doesn’t do anything yet, but we will use it eventually.
$Button4 = New-Object System.Windows.Forms.Button
$Button4.Location = New-Object System.Drawing.Size(140,220)
$Button4.Size = New-Object System.Drawing.Size(150,30)
$Button4.BackColor =”LightGray”
$Button4.Text = “Reserved for Future Use”
$Button4.Add_Click({$Form.Close()})
 
# ——– This is the end of the object definition section ——
 
 
 
# —–Draw the empty form—-
$Form = New-Object System.Windows.Forms.Form
$Form.width = 525
$Form.height = 350
$Form.BackColor = “lightblue”
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
$Form.Text = “Hyper-V Virtual Machines”
$Form.maximumsize = New-Object System.Drawing.Size(525,350)
$Form.startposition = “centerscreen”
$Form.KeyPreview = $True
$Form.Add_KeyDown({if ($_.KeyCode -eq “Enter”) {}})
 $Form.Add_KeyDown({if ($_.KeyCode -eq “Escape”)
     {$Form.Close()}})
 
#—-Populate the form—-
Display-MainScreen
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()

#>