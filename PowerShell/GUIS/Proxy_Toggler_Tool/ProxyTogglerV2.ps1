#Load Assemblies
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null


$net = New-Object -ComObject Wscript.Network

#Function to Display the Main Screen

Function Display-Main

{

$Form.Controls.Add($Button1)
$Form.Controls.Add($Button2)

}


#Function to enable the proxy

Function Enable-Proxy
{

Set-Itemproperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyEnable -value 1

Start-Process iexplore.exe
Start-Sleep -Milliseconds 500
Stop-Process -name iexplore

}

Function Disable-Proxy

{

Set-Itemproperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyEnable -value 0 

Start-Process iexplore.exe
Start-Sleep -Milliseconds 500
Stop-Process -name iexplore

}



#-----Button Click Actions-----#

	#Return Button Click Function
	#OK Button Click Function

#-----Define All GUI Objects-----#

	# Define Label
	# Define Label 2
	# Define Label 3
	# Define List Box
	# Define Button 1
        #Button that turns off the proxy
    $Button1 = New-Object System.Windows.Forms.Button
    $Button1.Location = New-Object System.Drawing.Size(40,40)
    $Button1.Size = New-Object System.Drawing.Size(140,80)
    $Button1.BackColor = "DodgerBlue"
    $Button1.FlatAppearance.BorderSize = "0"
    $Button1.FlatStyle = "Flat"
    $Button1.Text = "Disable"
    $Button1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button1.Add_Click({Disable-Proxy})
    $Button1.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Disable-Proxy}})

	# Define Button 2
        #Button that enables the proxy
    $Button2 = New-Object System.Windows.Forms.Button
    $Button2.Location = New-Object System.Drawing.Size(200,40)
    $Button2.Size = New-Object System.Drawing.Size(140,80)
    $Button2.BackColor = "DodgerBlue"
    $Button2.FlatAppearance.BorderSize = "0"
    $Button2.FlatStyle = "Flat"
    $Button2.Text = "Enable"
    $Button2.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button2.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Enable-Proxy}})
    $Button2.Add_Click({Enable-Proxy})

	# Define Button 3
	# Define Button 4

#-----Draw the Empty Form-----#
$Form = New-Object System.Windows.Forms.Form
$Form.Width = 400
$Form.Height = 210
$Form.StartPosition = "CenterScreen"
$Form.BackColor = "LightGray"
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
$Form.Text = "Proper Proxy Toggler"
$Form.Icon = New-Object System.Drawing.Icon("C:\Scripts\Icons\LightningSCCM.ico")
$Form.Add_KeyDown({if($_.Keycode -eq "Enter"){}})
    $Form.Add_KeyDown({if($_.Keycode -eq "Escape")
    {$Form.Close()}})
Display-Main

#-----Populate the Form-----#
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()

