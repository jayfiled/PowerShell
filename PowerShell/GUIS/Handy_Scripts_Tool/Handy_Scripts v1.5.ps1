#Specific information commented out with <# linkpath #> etc

#Load Assemblies
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null


$net = New-Object -ComObject Wscript.Network

#Display the main screen

Function Display-Mainscreen
{
$Form.Controls.Add($Button1)
$Form.Controls.Add($Button2)
$Form.Controls.Add($Button3)
$Form.Controls.Add($Button15)
}

#Display the SMSTS Logs Screen (Remove all Main screen objects)

Function Display-SMSTS
{
$Form.Controls.Remove($Button1)
$Form.Controls.Remove($Button2)
$Form.Controls.Remove($Button3)
$Form.Controls.Remove($Button15)

$Form.Controls.Add($Textbox1)
$Form.Controls.Add($Textbox7)
$Form.Controls.Add($Textbox10)
$Form.Controls.Add($Label1)
$Form.Controls.Add($Button4)
$Form.Controls.Add($Button9)
$Form.Controls.Add($Button14)
$Form.Controls.Add($Button19)
}

#Display the Shortcut Creator Screen (Remove all Main screen objects)

Function Display-Shortcut
{
$Form.Controls.Remove($Button1)
$Form.Controls.Remove($Button2)
$Form.Controls.Remove($Button3)
$Form.Controls.Remove($Button15)

$Form.Controls.Add($Label2)
$Form.Controls.Add($Textbox2)
$Form.Controls.Add($Textbox4)
$Form.Controls.Add($Textbox5)
$Form.Controls.Add($Textbox6)
$Form.Controls.Add($Button5)
$Form.Controls.Add($Button6)
$Form.Controls.Add($Button7)
$Form.Controls.Add($Button8)
$Form.Controls.Add($Button10)

}

Function Display-WhosLoggedIn
{
$Form.Controls.Remove($Button1)
$Form.Controls.Remove($Button2)
$Form.Controls.Remove($Button3)
$Form.Controls.Remove($Button15)

$Form.Controls.Add($Label3)
$Form.Controls.Add($Textbox3)
$Form.Controls.Add($Button11)
$Form.Controls.Add($Listbox1)
$Form.Controls.Add($Button12)
$Form.Controls.Add($Button13)

}

Function Display-Usersdevices
{
$Form.Controls.Remove($Button1)
$Form.Controls.Remove($Button2)
$Form.Controls.Remove($Button3)
$Form.Controls.Remove($Button15)

$Form.Controls.Add($Label4)
$Form.Controls.Add($Textbox8)
$Form.Controls.Add($Textbox9)
$Form.Controls.Add($Button16)
$Form.Controls.Add($Listbox2)
$Form.Controls.Add($Button17)
$Form.Controls.Add($Button18)

}


#-----Button Click Actions-----#

	#Return Button Click Functions
        #Function to Return to the Main Screen from SMSTS Logs section
        Function Return-SMSTStoMain
        {
        $Form.Controls.Remove($Textbox1)
        $Form.Controls.Remove($Textbox7)
        $Form.Controls.Remove($Textbox10)
        $Form.Controls.Remove($Label1)
        $Form.Controls.Remove($Button4)
        $Form.Controls.Remove($Button9)
        $Form.Controls.Remove($Button14)
        $Form.Controls.Remove($Button19)

        Display-Mainscreen
        }

        #Function to Return to the Main Screen from Copy Shortcuts section
        Function Return-ShortcuttoMain
        {
        $Form.Controls.Remove($Textbox2)
        $Form.Controls.Remove($Textbox4)
        $Form.Controls.Remove($Textbox5)
        $Form.Controls.Remove($Textbox6)
        $Form.Controls.Remove($Label6)
        $Form.Controls.Remove($Label2)
        $Form.Controls.Remove($Button5)
        $Form.Controls.Remove($Button6)
        $Form.Controls.Remove($Button7)
        $Form.Controls.Remove($Button8)
        $Form.Controls.Remove($Button10)

        Display-Mainscreen
        }

        #Function to Return to the Main Screen from the "Who's logged in section"
        Function Return-LoggedInToMain
        {
        $Form.Controls.Remove($Textbox3)
        $Form.Controls.Remove($Label3)
        $Form.Controls.Remove($Button3)
        $Form.Controls.Remove($Button11)
        $Form.Controls.Remove($Listbox1)
        $Form.Controls.Remove($Button12)
        $Form.Controls.Remove($Button13)

        Display-Mainscreen
        }

        #Function to Return to the main screen from the 'Users' devices' section
        Function Return-Usersdevicestomain
        {
        $Form.Controls.Remove($Textbox8)
        $Form.Controls.Remove($Textbox9)
        $Form.Controls.Remove($Label4)
        $Form.Controls.Remove($Button16)
        $Form.Controls.Remove($Button17)
        $Form.Controls.Remove($Button18)
        $Form.Controls.Remove($Listbox2)
        $Form.Controls.Remove($Button12)
        $Form.Controls.Remove($Button13)

        Display-Mainscreen
        }

    #Log File retreival

	    #SMSTS Go Button Click Function - need to build error actions and make sure it checks the logs folder for the SMSTSLog folder too
            Function Get-SMSTS
            {
            #Create Text & Hostname Variables
            $RemotePC = $Textbox1.Text
            $Hostname = Hostname

            #Deletes any log files locally and then copies the SMSTS file from remote PC to own, then opens it
            New-Item C:\Temp\RemoteSMSTS -ItemType Directory -ErrorAction SilentlyContinue
            Remove-Item \\$Hostname\C$\Temp\RemoteSMSTS\*.log -ErrorAction SilentlyContinue
            Copy-Item \\$RemotePC\C$\Windows\CCM\Logs\SMSTSLog\SMSTS*.log \\$Hostname\C$\Temp\RemoteSMSTS -ErrorAction SilentlyContinue
            Copy-Item \\$RemotePC\C$\Windows\CCM\Logs\SMSTS*.log \\$Hostname\C$\Temp\RemoteSMSTS -ErrorAction SilentlyContinue
            Invoke-Item \\$Hostname\C$\Temp\RemoteSMSTS\SMSTS*.log
            }

        #Critical SYstem Event Log gatherer Go button function
            Function Get-Event
            {
            $Hostname = Hostname

            New-Item C:\Temp\RemoteLogs -ItemType Directory -ErrorAction SilentlyContinue
            Remove-Item \\$Hostname\C$\Temp\RemoteLogs\*.log

            $css= "<style>"
            $css= $css+ "BODY{ text-align: center; background-color:white;}"
            $css= $css+ "TABLE{    font-family: 'Lucida Sans Unicode', 'Lucida Grande', Sans-Serif;font-size: 12px;margin: 10px;width: 100%;text-align: center;border-collapse: collapse;border-top: 7px solid #004466;border-bottom: 7px solid #004466;}"
            $css= $css+ "TH{font-size: 13px;font-weight: normal;padding: 1px;background: #cceeff;border-right: 1px solid #004466;border-left: 1px solid #004466;color: #004466;}"
            $css= $css+ "TD{padding: 1px;background: #e5f7ff;border-right: 1px solid #004466;border-left: 1px solid #004466;color: #669;hover:black;}"
            $css= $css+  "TD:hover{ background-color:#004466;}"
            $css= $css+ "</style>" 
 
            $StartDate = (get-date).adddays(-2)

            $Server = $Textbox7.Text

            $body =@()

            $body += Get-WinEvent -ComputerName $Server -FilterHashtable @{logname="System"; Level=1; starttime=$StartDate} -ErrorAction SilentlyContinue

            $body | ConvertTo-HTML -Head $css MachineName,ID,LevelDisplayName,TimeCreated,Message > C:\Temp\RemoteLogs\LogAppView.html

            Invoke-Item \\$Hostname\C$\Temp\RemoteLogs\LogAppView.html
            }

        #Error System Event Log gatherer Go button Function
            Function Get-ErrorEvent
            {
            $Hostname = Hostname

            New-Item C:\Temp\RemoteLogs -ItemType Directory -ErrorAction SilentlyContinue
            Remove-Item \\$Hostname\C$\Temp\RemoteLogs\*.log

            $css= "<style>"
            $css= $css+ "BODY{ text-align: center; background-color:white;}"
            $css= $css+ "TABLE{    font-family: 'Lucida Sans Unicode', 'Lucida Grande', Sans-Serif;font-size: 12px;margin: 10px;width: 100%;text-align: center;border-collapse: collapse;border-top: 7px solid #004466;border-bottom: 7px solid #004466;}"
            $css= $css+ "TH{font-size: 13px;font-weight: normal;padding: 1px;background: #cceeff;border-right: 1px solid #004466;border-left: 1px solid #004466;color: #004466;}"
            $css= $css+ "TD{padding: 1px;background: #e5f7ff;border-right: 1px solid #004466;border-left: 1px solid #004466;color: #669;hover:black;}"
            $css= $css+  "TD:hover{ background-color:#004466;}"
            $css= $css+ "</style>" 
 
            $StartDate = (get-date).adddays(-2)

            $Server = $Textbox10.Text

            $body =@()

            $body += Get-WinEvent -ComputerName $Server -FilterHashtable @{logname="System"; Level=2; starttime=$StartDate} -ErrorAction SilentlyContinue

            $body | ConvertTo-HTML -Head $css MachineName,ID,LevelDisplayName,TimeCreated,Message > C:\Temp\RemoteLogs\LogSysErrorView.html

            Invoke-Item \\$Hostname\C$\Temp\RemoteLogs\LogSysErrorView.html
            }

     
    #Shortcut Creator:
        #Copy Administrator Button Function
            Function Copy-Administrator
            {
            #Define the variable for Remote PC

            $RemotePC2 = $Textbox2.Text

            Copy-Item <# linkpath #> \\$RemotePC2\C$\Users\Public\Desktop

           # Test for to see if the shortcut is there & display message box with the outcome
            $AdminLNK = Test-Path "\\$RemotePC2\c$\Users\Public\Desktop\Administrator*.lnk"

            If ($AdminLNK -eq $true)
            {
            [System.Windows.Forms.MessageBox]::Show("Copied Successfully","Success","OK","Information")
            }

            Else 
            {
            [System.Windows.Forms.MessageBox]::Show("PC turned off, or PC name wrong","Failed","OK","Information")
            }

            }

        #Copy Reports Button Function

            Function Copy-Reports
            {
            #Define the variable for Remote PC

            $RemotePC4 = $Textbox4.Text

            Copy-Item <# linkpath #> \\$RemotePC4\C$\Users\Public\Desktop

                   # Test for to see if the shortcut is there & display message box with the outcome
            $ReportsLNK = Test-Path "\\$RemotePC4\c$\Users\Public\Desktop\Reports.lnk"

            If ($ReportsLNK -eq $true)
            {
            [System.Windows.Forms.MessageBox]::Show("Copied Successfully","Success","OK","Information")
            }

            Else 
            {
            [System.Windows.Forms.MessageBox]::Show("PC turned off, or PC name wrong","Failed","OK","Information")
            }

            }

        #Copy Sabre Button Function ## Improve by making a shortcut from C:\Sabre Red Workspace\Profiles\3EO9_1034\mysabre.exe & copying to Public Desktop

            Function Copy-Sabre
            {
            #Define the variable for Remote PC

            $RemotePC5 = $Textbox5.Text

            Copy-Item "\\$RemotePC5\ <# linkpath #> " "\\$RemotePC5\c$\users\public\desktop"
            Rename-Item "\\$RemotePC5\c$\users\public\desktop\*Sabre*.lnk" "Sabre Red Workspace.lnk"
            Del "\\$RemotePC5\ <# linkpath #> "

                   # Test for to see if the shortcut is there & display message box with the outcome
            $SabreLNK = Test-Path "\\$RemotePC5\c$\Users\Public\Desktop\Sabre*.lnk"

            If ($SabreLNK -eq $true)
            {
            [System.Windows.Forms.MessageBox]::Show("Copied Successfully","Success","OK","Information")
            }

            Else 
            {
            [System.Windows.Forms.MessageBox]::Show("PC turned off, or PC name wrong","Failed","OK","Information")
            }

            }

        #Copy Snipping Button Function

            Function Copy-Snipping
            {
            #Define the variable for Remote PC

            $RemotePC6 = $Textbox6.Text

            $Shell = New-Object -ComObject ("WScript.Shell")

            $ShortCut = $Shell.CreateShortcut("\\$RemotePC6\c$\Users\Public\Desktop\SnippingTool.lnk")

            $ShortCut.TargetPath="SnippingTool.exe"
            $ShortCut.Arguments="/clip"
            $ShortCut.WorkingDirectory = "C:\Windows\System32\";
            $ShortCut.WindowStyle = 1;
            $ShortCut.Hotkey = "CTRL+SHIFT+S";
            $ShortCut.IconLocation = "SnippingTool.exe, 0";
            $ShortCut.Description = "Snipping Tool";
            $ShortCut.Save()

        # Test for to see if the shortcut is there & display message box with the outcome

        $SnipLNK = Test-Path "\\$RemotePC6\c$\Users\Public\Desktop\Snipping*.lnk"

            If ($SnipLNK -eq $true)
            {
            [System.Windows.Forms.MessageBox]::Show("Copied Successfully","Success","OK","Information")
            }

            Else 
            {
            [System.Windows.Forms.MessageBox]::Show("PC turned off, or PC name wrong","Failed","OK","Information")
            }

            }



        #Who's Logged in ---Ideally I'd like the $Username variable to show up in a message box, see comment

            Function Get-Username
            {
            #Define the variable for Remote PC
    
            $Computername = $Textbox3.Text

            Get-WmiObject –ComputerName $Computername –Class Win32_ComputerSystem | Select-Object UserName
    
            #Message box controls:
            #[System.Windows.Forms.MessageBox]::Show("The currently logged on user is $Username :","Success","OK","Information")
            }

            Function Output-Loggedin
            {
    
            $AddedUser = Get-Username
            ForEach ($User in $AddedUser)
                            {
            [void] $ListBox1.Items.Add($User)

                            }

            }

        #Log onto computer in 'Whos Logged on'
            Function Log-On
            {
            $RemotePC7 = $Textbox3.Text
            cd "C:\Program Files\UltraVNC\"
             .\vncviewer.exe $RemotePC7
             }

        #Users' Devices functions            
            #Define a function that imports a csv file, uses name from textbox8, stores it as a variable and filters the csv based on that user

            Function Match-User
            {
        
            $csv = Import-CSV <# linkpath #>

            $Name = $Textbox8.Text

            <#$Global:Output =#>$csv | Where-Object {$_.User_name0 -like "*$Name*"}# | Format-Table User, Computer_Name
        
            }

        #Function to display the output in listbox2

        Function Output-Device
        {

            
            $AddedUser2 = Match-User
            ForEach ($User2 in $AddedUser2)
                            {
            [void] $ListBox2.Items.Add($User2)
            
                            }

        }

        #Log onto computer in 'USers' Devices'
            Function Log-On2
            {
            $RemotePC8 = $Textbox9.Text
            cd "C:\Program Files\UltraVNC\"
             .\vncviewer.exe $RemotePC8
             }


#-----Define All GUI Objects-----#

	# Define SMSTS screen's label
    $Label1 = New-Object System.Windows.Forms.Label
    $Label1.Location = New-Object System.Drawing.Size(40,40)
    $Label1.AutoSize = $True
    $Label1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label1.ForeColor = "Black"
    $Label1.Text = "Enter the computer name:"


	# Define Shortcut Creator Label
    $Label2 = New-Object System.Windows.Forms.Label
    $Label2.Location = New-Object System.Drawing.Size(40,40)
    $Label2.AutoSize = $True
    $Label2.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label2.ForeColor = "Black"
    $Label2.Text = "Enter the computer name and choose which program you want to copy:"

	# Define Whos logged in Label
    $Label3 = New-Object System.Windows.Forms.Label
    $Label3.Location = New-Object System.Drawing.Size(40,40)
    $Label3.AutoSize = $True
    $Label3.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label3.ForeColor = "Black"
    $Label3.Text = "Enter the computer name to see who's logged in:"

    	# Define Users' devices label
    $Label4 = New-Object System.Windows.Forms.Label
    $Label4.Location = New-Object System.Drawing.Size(40,20)
    $Label4.AutoSize = $True
    $Label4.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label4.ForeColor = "Black"
    $Label4.Text = "Enter the username or part of their surname and click Go:"

	# Define Whos logged in List Box
    $Listbox1 = New-Object System.Windows.Forms.ListBox
    $Listbox1.Location = New-Object System.Drawing.Size(40,210)
    $Listbox1.Size = New-Object System.Drawing.Size(240,80)
    $Listbox1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)

	# Define Users' devices Listbox
    $Listbox2 = New-Object System.Windows.Forms.ListBox
    $Listbox2.Location = New-Object System.Drawing.Size(40,210)
    $Listbox2.Size = New-Object System.Drawing.Size(550,200)
    $Listbox2.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)

    # Define SMSTS Text box
    $Textbox1 = New-Object System.Windows.Forms.TextBox
    $TextBox1.Location = New-Object System.Drawing.Size(40,80)
    $Textbox1.Size = New-Object System.Drawing.Size(120,40)
    $Textbox1.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox1.Multiline = $True
    $Textbox1.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-SMSTS}})


    # Define Administrator Shortcut Text box
    $Textbox2 = New-Object System.Windows.Forms.TextBox
    $TextBox2.Location = New-Object System.Drawing.Size(40,80)
    $Textbox2.Size = New-Object System.Drawing.Size(120,40)
    $Textbox2.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox2.Multiline = $True
    $Textbox2.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Copy-Administrator}})
    

    #Define Whos Logged In Text box
    $Textbox3 = New-Object System.Windows.Forms.TextBox
    $TextBox3.Location = New-Object System.Drawing.Size(40,80)
    $Textbox3.Size = New-Object System.Drawing.Size(120,40)
    $Textbox3.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox3.Multiline = $True
    $Textbox3.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-Username}})

    #Define Reports copy text box
    $Textbox4 = New-Object System.Windows.Forms.TextBox
    $TextBox4.Location = New-Object System.Drawing.Size(180,80)
    $Textbox4.Size = New-Object System.Drawing.Size(120,40)
    $Textbox4.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox4.Multiline = $True
    $Textbox4.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Copy-Reports}})

    #Define Sabre Copy text box
    $Textbox5 = New-Object System.Windows.Forms.TextBox
    $TextBox5.Location = New-Object System.Drawing.Size(320,80)
    $Textbox5.Size = New-Object System.Drawing.Size(120,40)
    $Textbox5.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox5.Multiline = $True
    $Textbox5.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Copy-Sabre}})

    #Define Snipping Copy text box
    $Textbox6 = New-Object System.Windows.Forms.TextBox
    $TextBox6.Location = New-Object System.Drawing.Size(460,80)
    $Textbox6.Size = New-Object System.Drawing.Size(120,40)
    $Textbox6.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox6.Multiline = $True
    $Textbox6.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Copy-Snipping}})

    #Define Get event log text box
    $Textbox7 = New-Object System.Windows.Forms.TextBox
    $TextBox7.Location = New-Object System.Drawing.Size(40,140)
    $Textbox7.Size = New-Object System.Drawing.Size(120,40)
    $Textbox7.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox7.Multiline = $True
    $Textbox7.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-Event}})

    #Define Users' devices textbox for username
    $Textbox8 = New-Object System.Windows.Forms.TextBox
    $TextBox8.Location = New-Object System.Drawing.Size(40,80)
    $Textbox8.Size = New-Object System.Drawing.Size(120,40)
    $Textbox8.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox8.Multiline = $True
    <# Testing autocomplete
$Textbox8.AutoCompleteSource = 'CustomSource'
$Textbox8.AutoCompleteMode='SuggestAppend'
$Textbox8.AutoCompleteCustomSource= Get-content 'Link path' | % {$Textbox8.AutoCompleteCustomSource.AddRange($_) }
     #>
    $Textbox8.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Match-User;Output-Device}})

    #Define Users' devices textbox for PC name to log onto
    $Textbox9 = New-Object System.Windows.Forms.TextBox
    $TextBox9.Location = New-Object System.Drawing.Size(750,210)
    $Textbox9.Size = New-Object System.Drawing.Size(120,40)
    $Textbox9.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox9.Multiline = $True
    $Textbox9.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Log-On2}})

    #Define Get event log text box
    $Textbox10 = New-Object System.Windows.Forms.TextBox
    $TextBox10.Location = New-Object System.Drawing.Size(40,200)
    $Textbox10.Size = New-Object System.Drawing.Size(120,40)
    $Textbox10.Font = New-Object System.Drawing.Font("Calibri",16,[System.Drawing.FontStyle]::Regular)
    $Textbox10.Multiline = $True
    $Textbox10.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-ErrorEvent}})

	# Define Button 1
        #Button that goes to the SMSTS logs section
    $Button1 = New-Object System.Windows.Forms.Button
    $Button1.Location = New-Object System.Drawing.Size(40,40)
    $Button1.Size = New-Object System.Drawing.Size(140,80)
    $Button1.BackColor = "DodgerBlue"
    $Button1.FlatAppearance.BorderSize = "0"
    $Button1.FlatStyle = "Flat"
    $Button1.Text = "Logs"
    $Button1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button1.Add_Click({Display-SMSTS})
    $Button1.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-SMSTS}})
    


	# Define Button 2
        #Button that goes to the copy shortcuts section (Desktop, Reports, Administrator, Sabre, Snipping Tool)
    $Button2 = New-Object System.Windows.Forms.Button
    $Button2.Location = New-Object System.Drawing.Size(200,40)
    $Button2.Size = New-Object System.Drawing.Size(140,80)
    $Button2.BackColor = "DodgerBlue"
    $Button2.FlatAppearance.BorderSize = "0"
    $Button2.FlatStyle = "Flat"
    $Button2.Text = "Shortcut Creator"
    $Button2.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button2.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Display-Shortcut}})
    $Button2.Add_Click({Display-Shortcut})

	# Define Button 3
        #Button that goes to the "Who's Logged in" section
    $Button3 = New-Object System.Windows.Forms.Button
    $Button3.Location = New-Object System.Drawing.Size(360,40)
    $Button3.Size = New-Object System.Drawing.Size(140,80)
    $Button3.BackColor = "DodgerBlue"
    $Button3.FlatAppearance.BorderSize = "0"
    $Button3.FlatStyle = "Flat"
    $Button3.Text = "Whos Logged in?"
    $Button3.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button3.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Display-WhosLoggedIn}})
    $Button3.Add_Click({Display-WhosLoggedIn})

	# Define Button 4
        #SMSTS 'Go' Button
    $Button4 = New-Object System.Windows.Forms.Button
    $Button4.Location = New-Object System.Drawing.Size(180,80)
    $Button4.Size = New-Object System.Drawing.Size(130,40)
    $Button4.BackColor = "DodgerBlue"
    $Button4.FlatStyle = "Flat"
    $Button4.FlatAppearance.BorderColor = "CadetBlue"
    $Button4.Text = "Get SMSTS"
    $Button4.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button4.Add_click({Get-SMSTS})
    $Button4.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-SMSTS}})
    $Button4.Add_KeyDown({if ($_.KeyCode -eq 8){Return-SMSTStoMain}})

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
    $Button5.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Copy-Administrator}})
    $Button5.Add_click({Copy-Administrator})
    $Button5.Add_KeyDown({if ($_.KeyCode -eq 8){Return-ShortcuttoMain}})

    # Define Button 6
        #Copy Reports Button
    $Button6 = New-Object System.Windows.Forms.Button
    $Button6.Location = New-Object System.Drawing.Size(180,130)
    $Button6.Size = New-Object System.Drawing.Size(120,40)
    $Button6.BackColor = "DodgerBlue"
    $Button6.FlatStyle = "Flat"
    $Button6.FlatAppearance.BorderColor = "CadetBlue"
    $Button6.Text = "Reports"
    $Button6.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button6.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Copy-Reports}})
    $Button6.Add_KeyDown({if ($_.KeyCode -eq 8){Return-ShortcuttoMain}})
    $Button6.Add_click({Copy-Reports})

    # Define Button 7
        #Copy and Rename Sabre Button
    $Button7 = New-Object System.Windows.Forms.Button
    $Button7.Location = New-Object System.Drawing.Size(320,130)
    $Button7.Size = New-Object System.Drawing.Size(120,40)
    $Button7.BackColor = "DodgerBlue"
    $Button7.FlatStyle = "Flat"
    $Button7.FlatAppearance.BorderColor = "CadetBlue"
    $Button7.Text = "Sabre"
    $Button7.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button7.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Copy-Sabre}})
    $Button7.Add_KeyDown({if ($_.KeyCode -eq 8){Return-ShortcuttoMain}})
    $Button7.Add_click({Copy-Sabre})

    # Define Button 8
        #Copy Snipping Tool Button
    $Button8 = New-Object System.Windows.Forms.Button
    $Button8.Location = New-Object System.Drawing.Size(460,130)
    $Button8.Size = New-Object System.Drawing.Size(120,40)
    $Button8.BackColor = "DodgerBlue"
    $Button8.FlatStyle = "Flat"
    $Button8.FlatAppearance.BorderColor = "CadetBlue"
    $Button8.Text = "Snipping"
    $Button8.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button8.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Copy-Snipping}})
    $Button8.Add_KeyDown({if ($_.KeyCode -eq 8){Return-ShortcuttoMain}})
    $Button8.Add_click({Copy-Snipping})

    #Define Button 9
        #Return to Main Screen from SMSTS
    $Button9 = New-Object System.Windows.Forms.Button
    $Button9.Location = New-Object System.Drawing.Size(860,400)
    $Button9.Size = New-Object System.Drawing.Size(120,40)
    $Button9.BackColor = "DodgerBlue"
    $Button9.FlatStyle = "Flat"
    $Button9.FlatAppearance.BorderColor = "CadetBlue"
    $Button9.Text = "Back.."
    $Button9.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button9.Add_KeyDown({if ($_.KeyCode -eq 8){Return-SMSTStoMain}})
    $Button9.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Return-SMSTStoMain}})
    $Button9.Add_click({Return-SMSTStoMain})

    #Define Button 10
        #Return to Main Screen from Shortcuts
    $Button10 = New-Object System.Windows.Forms.Button
    $Button10.Location = New-Object System.Drawing.Size(860,400)
    $Button10.Size = New-Object System.Drawing.Size(120,40)
    $Button10.BackColor = "DodgerBlue"
    $Button10.FlatStyle = "Flat"
    $Button10.FlatAppearance.BorderColor = "CadetBlue"
    $Button10.Text = "Back.."
    $Button10.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button10.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Return-ShortcuttoMain}})
    $Button10.Add_KeyDown({if ($_.KeyCode -eq 8){Return-ShortcuttoMain}})
    $Button10.Add_click({Return-ShortcuttoMain})

    #Define Button 11
        #Return to Main Screen from Who's Logged in
    $Button11 = New-Object System.Windows.Forms.Button
    $Button11.Location = New-Object System.Drawing.Size(860,400)
    $Button11.Size = New-Object System.Drawing.Size(120,40)
    $Button11.BackColor = "DodgerBlue"
    $Button11.FlatStyle = "Flat"
    $Button11.FlatAppearance.BorderColor = "CadetBlue"
    $Button11.Text = "Back.."
    $Button11.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button11.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Return-LoggedInToMain}})
    $Button11.Add_KeyDown({if ($_.KeyCode -eq 8){Return-LoggedInToMain}})
    $Button11.Add_click({Return-LoggedInToMain})

    #Define Button 12
        #Who's logged in 'Go' button
    #Define Button
    $Button12 = New-Object System.Windows.Forms.Button
    $Button12.Location = New-Object System.Drawing.Size(40,130)
    $Button12.Size = New-Object System.Drawing.Size(120,40)
    $Button12.BackColor = "DodgerBlue"
    $Button12.FlatStyle = "Flat"
    $Button12.FlatAppearance.BorderColor = "CadetBlue"
    $Button12.Text = "Go"
    $Button12.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button12.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-Username;Output-Loggedin}})
    $Button12.Add_KeyDown({if ($_.KeyCode -eq 8){Return-LoggedInToMain}})
    $Button12.Add_click({Get-Username;Output-Loggedin})

    #Define Button 13
        #Who's logged in 'Log on button' button
    #Define Button
    $Button13 = New-Object System.Windows.Forms.Button
    $Button13.Location = New-Object System.Drawing.Size(170,310)
    $Button13.Size = New-Object System.Drawing.Size(120,40)
    $Button13.BackColor = "DodgerBlue"
    $Button13.FlatStyle = "Flat"
    $Button13.FlatAppearance.BorderColor = "CadetBlue"
    $Button13.Text = "Log in"
    $Button13.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button13.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Log-On}})
    $Button13.Add_KeyDown({if ($_.KeyCode -eq 8){Return-LoggedInToMain}})
    $Button13.Add_click({Log-On})

    #Define Button 14
        #Get Logfiles 'Go' button
    #Define Button
    $Button14 = New-Object System.Windows.Forms.Button
    $Button14.Location = New-Object System.Drawing.Size(180,140) 
    $Button14.Size = New-Object System.Drawing.Size(130,40)
    $Button14.BackColor = "DodgerBlue"
    $Button14.FlatStyle = "Flat"
    $Button14.FlatAppearance.BorderColor = "CadetBlue"
    $Button14.Text = "Get Critical Events"
    $Button14.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button14.Add_click({Get-Event})
    $Button14.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-Event}})
    $Button14.Add_KeyDown({if ($_.KeyCode -eq 8){Return-SMSTStoMain}})

	# Define Button 15
        #Button that goes to the 'Users' Devices' section
    $Button15 = New-Object System.Windows.Forms.Button
    $Button15.Location = New-Object System.Drawing.Size(520,40)
    $Button15.Size = New-Object System.Drawing.Size(140,80)
    $Button15.BackColor = "DodgerBlue"
    $Button15.FlatAppearance.BorderSize = "0"
    $Button15.FlatStyle = "Flat"
    $Button15.Text = "Users' Devices"
    $Button15.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button15.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Display-UsersDevices}})
    $Button15.Add_Click({Display-Usersdevices})

    #Define button 16
        #Users' devices 'Go' button
    $Button16 = New-Object System.Windows.Forms.Button
    $Button16.Location = New-Object System.Drawing.Size(40,130)
    $Button16.Size = New-Object System.Drawing.Size(120,40)
    $Button16.BackColor = "DodgerBlue"
    $Button16.FlatStyle = "Flat"
    $Button16.FlatAppearance.BorderColor = "CadetBlue"
    $Button16.Text = "Go"
    $Button16.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button16.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Match-User;Output-Device}})
    $Button16.Add_KeyDown({if ($_.KeyCode -eq 8){Return-UsersDevicesToMain}})
    $Button16.Add_click({Match-User;Output-Device})

    #Define button 17
        #Users' devices return to main button
    $Button17 = New-Object System.Windows.Forms.Button
    $Button17.Location = New-Object System.Drawing.Size(860,400)
    $Button17.Size = New-Object System.Drawing.Size(120,40)
    $Button17.BackColor = "DodgerBlue"
    $Button17.FlatStyle = "Flat"
    $Button17.FlatAppearance.BorderColor = "CadetBlue"
    $Button17.Text = "Back.."
    $Button17.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button17.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Return-UsersDevicesToMain}})
    $Button17.Add_KeyDown({if ($_.KeyCode -eq 8){Return-UsersDevicesToMain}})
    $Button17.Add_click({Return-UsersDevicesToMain})

    #Define Button 18
        #Users' devices 'Log on button' button
    #Define Button
    $Button18 = New-Object System.Windows.Forms.Button
    $Button18.Location = New-Object System.Drawing.Size(610,210)
    $Button18.Size = New-Object System.Drawing.Size(120,40)
    $Button18.BackColor = "DodgerBlue"
    $Button18.FlatStyle = "Flat"
    $Button18.FlatAppearance.BorderColor = "CadetBlue"
    $Button18.Text = "Log in"
    $Button18.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button18.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Log-On2}})
    $Button18.Add_KeyDown({if ($_.KeyCode -eq 8){Return-UsersDevicesToMain}})
    $Button18.Add_click({Log-On2})

    #Define Button 19
        #Get Logfiles 'Go' button
    #Define Button
    $Button19 = New-Object System.Windows.Forms.Button
    $Button19.Location = New-Object System.Drawing.Size(180,200) 
    $Button19.Size = New-Object System.Drawing.Size(130,40)
    $Button19.BackColor = "DodgerBlue"
    $Button19.FlatStyle = "Flat"
    $Button19.FlatAppearance.BorderColor = "CadetBlue"
    $Button19.Text = "Get Error Events"
    $Button19.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button19.Add_click({Get-ErrorEvent})
    $Button19.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Get-ErrorEvent}})
    $Button19.Add_KeyDown({if ($_.KeyCode -eq 8){Return-SMSTStoMain}})

        
#-----Draw the Empty Form-----#
$Form = New-Object System.Windows.Forms.Form
$Form.Width = 1000
$Form.Height = 500
$Form.StartPosition = "CenterScreen"
$Form.BackColor = "LightGray"
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
$Form.Text = "Handy Scripts Beta v1.5"
$Form.Icon = New-Object System.Drawing.Icon("..\Icons\Script.ico")
$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter"){}})
    $Form.Add_KeyDown({if ($_.KeyCode -eq "Escape")
    {$Form.Close()}})
Display-Mainscreen

#-----Populate the Form-----#
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()