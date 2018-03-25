#Server names replaced with <#Servername#>

#Load Assemblies
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

$net = New-Object -ComObject Wscript.Network


#Function to Display the Main Screen

Function Display-MainScreen
{
$Form.Controls.Add($Button1)
$Form.Controls.Add($Button2)
$Form.Controls.Add($Button3)
$Form.Controls.Add($Button4)
$Form.Controls.Add($Button5)

}

#Function to display the New User screen

Function Display-NewUser
{
$Form.Controls.Remove($Button1)
$Form.Controls.Remove($Button2)
$Form.Controls.Remove($Button3)
$Form.Controls.Remove($Button4)
$Form.Controls.Remove($Button5)

$Form.Controls.Add($Label1)
$Form.Controls.Add($DropDownBox1)
$Form.Controls.Add($Button6)
$Form.Controls.Add($Button7)
$Form.Controls.Add($Label2)
$Form.Controls.Add($Label3)
$Form.Controls.Add($Label4)
$Form.Controls.Add($Label5)
$Form.Controls.Add($Label6)
$Form.Controls.Add($Label7)
$Form.Controls.Add($TextBox1)
$Form.Controls.Add($TextBox2)
$Form.Controls.Add($TextBox3)
$Form.Controls.Add($MaskedTextbox1)
$Form.Controls.Add($TextBox5)
$Form.Controls.Add($TextBox6)
}

Function Return-NewUsertoMain

{
$Form.Controls.Remove($DropDownBox1)
$Form.Controls.Remove($Button6)
$Form.Controls.Remove($Button7)
$Form.Controls.Remove($Label1)
$Form.Controls.Remove($Label2)
$Form.Controls.Remove($Label3)
$Form.Controls.Remove($Label4)
$Form.Controls.Remove($Label5)
$Form.Controls.Remove($Label6)
$Form.Controls.Remove($Label7)
$Form.Controls.Remove($TextBox1)
$Form.Controls.Remove($TextBox2)
$Form.Controls.Remove($TextBox3)
$Form.Controls.Remove($MaskedTextbox1)
$Form.Controls.Remove($TextBox5)
$Form.Controls.Remove($TextBox6)

Display-Mainscreen

}

#Function to Display the Mailbox Info screen

Function Display-Mailboxinfo

{
$Form.Controls.Remove($Button1)
$Form.Controls.Remove($Button2)
$Form.Controls.Remove($Button3)

$Form.Controls.Add($Button4) #Go button
$Form.Controls.Add($Button5) #Back button
$Form.Controls.Add($Textbox1)
$Form.Controls.Add($Listbox1)

}

#Function to return to the MainScreen from mailbox info

Function Return-NewUser
{
$Form.Controls.Remove($DropDownBox1)
$Form.Controls.Remove($ListBox1)
$Form.Controls.Remove($ListBox2)
$Form.Controls.Remove($ListBox3)
$Form.Controls.Remove($ListBox4)
$Form.Controls.Remove($ListBox5)
$Form.Controls.Remove($ListBox6)
$Form.Controls.Remove($TextBox1)
$Form.Controls.Remove($TextBox2)
$Form.Controls.Remove($TextBox3)
$Form.Controls.Remove($TextBox4)

Display-MainScreen

}

#Functions

    #Function to change the New User page to New Contact

        Function New-ContactDisplay

        {

        }

    #Function to change the Contacts page to New User

        Function New-UserDisplay

        {

        }


    #Function to Connect to Exchange

        Function Connect
        {
        $UserCredential = Get-Credential

        $Global:Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<#Servername#>Powershell/ -Authentication Kerberos -Credential $UserCredential

        Import-PSSession $Session
        }


    #Function to Disconnect from Exchange

        Function Disconnect
        {

        Remove-PSSession $Global:Session

        }

    Function Load-ADModule

    {

    Import-Module ActiveDirectory

    }

    #Function to create the new user -------------test with a script first..

    Function Create-User

    {
    Connect

    $Firstname = $Textbox1.Text
    $MiddleInitial = $Textbox2.Text
    $Surname = $Textbox3.Text
    $Password = $Textbox4.Text | ConvertTo-SecureString -AsPlainText -Force
    $CopiedUser = $Textbox5.Text #Need to add one with a label stating that they need a username to copy
    $Template = Get-AdUser -identity $CopiedUser -Properties Title
    $ExchDB = $Textbox6.Text #Need to add one with a label that states which server are they on
    
    # Create new User & mailbox based on text fields
    $NewUser = New-Mailbox -Name "$Firstname $Surname" -Alias "$Firstname.$Surname" -OrganizationalUnit <#Domain name\OUName #> -UserPrincipalName "$Firstname.$Surname@<#domainName#>" -SamAccountName "$Firstname.$Surname" -FirstName $Firstname -Initials $MiddleInitial -LastName $Lastname -Template $CopiedUser -Password $Password -ResetPasswordOnNextLogon $false -Database "Mailbox Database $ExchDB"
    	
	#$NewUser = New-ADUser -Surname $Surname -GivenName $GivenName -DisplayName "$Surname, $GivenName" -SamAccountName "$GivenName.$Surename" -Name "$Surename, $GivenName" -PassThru
	
	# Copy from old User
	$NewUser | Add-ADPrincipalGroupMembership -MemberOf (Get-ADPrincipalGroupMembership $Template | Where { $_.Name -ne 'Domain Users' })
    
    Disconnect

    }

    #Function to get the size, send and prohibit quota etc from a mailbox

        Function Get-UserMailbox
        {

        $Username = $Textbox1.Text

        $UserMailbox = @()
        $Mailboxes = Get-Mailbox $Username | Select DisplayName, Database, IssueWarningQuota, ProhibitSendQuota, ProhibitSendReceiveQuota, Alias
        foreach ($Mailbox in $Mailboxes){
            $MailboxStats = "" |Select  DisplayName,Database,IssueWarningQuota,ProhibitSendQuota,ProhibitSendReceiveQuota,TotalItemSize,ItemCount,StorageLimitStatus
            $Stats = Get-MailboxStatistics -Identity $Mailbox.Alias
            $MailboxStats.DisplayName = $Mailbox.DisplayName 
            $MailboxStats.Database = $Mailbox.Database
            $MailboxStats.IssueWarningQuota = $Mailbox.IssueWarningQuota
            $MailboxStats.ProhibitSendQuota =$Mailbox.ProhibitSendQuota
            $MailboxStats.ProhibitSendReceiveQuota =$Mailbox.ProhibitSendReceiveQuota
            $MailboxStats.TotalItemSize = $Stats.TotalItemSize
            $MailboxStats.ItemCount = $Stats.ItemCount
            $MailboxStats.StorageLimitStatus = $Stats.StorageLimitStatus
            $UserMailbox += $MailboxStats
        }

        [void] $ListBox1.Items.Add($UserMailbox)

        }

    #Function to display the mailbox info in a listbox

        Function Display-UserMailbox
            {
    
            $Mailboxoutput = Get-Usermailbox
            ForEach ($Line in $Mailboxoutput)
                            {
            [void] $ListBox1.Items.Add($Line)

                            }

            }

        #Function Display-UserMailbox

#-----Button Click Actions-----#

	#Return Button Click Function
	#OK Button Click Function

#-----Define a tooltip object
$tooltip1 = New-Object System.Windows.Forms.ToolTip

        #Define a scriptblock to display the tooltip
            $ShowHelp={
             #display popup help
                #each value is the name of a control on the form.
    
             Switch ($this.name) {
                "NewUser"  {$tip = "New Users and Contacts"}
                "MailboxInfo" {$tip = "Get a users Mailbox limits, size, add and remove access / send permissions"}
                "Termination" {$tip = "Tools for managing a user termination request"}
                "UserContact" {$tip = "Click here to toggle contact and user creation"}
             }
             $tooltip1.SetToolTip($this,$tip)
            }
        #end ShowHelp

#-----Define All GUI Objects-----#

	# Define Label 1
        #Label to choose a User or Contact

    $Label1 = New-Object System.Windows.Forms.Label
    $Label1.Location = New-Object System.Drawing.Size(40,20)
    $Label1.Size = New-Object System.Drawing.Size(450,40)
    $Label1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label1.ForeColor = "Black"
    $Label1.Text = "Choose a User or Contact from the dropdown list: "


	# Define Label 2
        #Enter Firstname label
    $Label2 = New-Object System.Windows.Forms.Label
    $Label2.Location = New-Object System.Drawing.Size(40,130)
    $Label2.Size = New-Object System.Drawing.Size(100,40)
    $Label2.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label2.ForeColor = "Black"
    $Label2.Text = "Firstname: "

	# Define Label 3
        #Enter Middle initial label
    $Label3 = New-Object System.Windows.Forms.Label
    $Label3.Location = New-Object System.Drawing.Size(40,190)
    $Label3.Size = New-Object System.Drawing.Size(100,40)
    $Label3.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label3.ForeColor = "Black"
    $Label3.Text = "Middle Initial: "

    #Define Label 4
        #Enter Surname label
    $Label4 = New-Object System.Windows.Forms.Label
    $Label4.Location = New-Object System.Drawing.Size(40,250)
    $Label4.Size = New-Object System.Drawing.Size(100,40)
    $Label4.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label4.ForeColor = "Black"
    $Label4.Text = "Surname: "

    #Define Label 5
        #Enter Password label
    $Label5 = New-Object System.Windows.Forms.Label
    $Label5.Location = New-Object System.Drawing.Size(40,295)
    $Label5.Size = New-Object System.Drawing.Size(100,40)
    $Label5.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label5.ForeColor = "Black"
    $Label5.Text = "Password: "

    #Define Label 6
        #Enter Username to copy label
    $Label6 = New-Object System.Windows.Forms.Label
    $Label6.Location = New-Object System.Drawing.Size(40,340)
    $Label6.Size = New-Object System.Drawing.Size(100,40)
    $Label6.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label6.ForeColor = "Black"
    $Label6.Text = "Copy user: "

    #Define Label 7
        #Enter Exchange DB name label
    $Label7= New-Object System.Windows.Forms.Label
    $Label7.Location = New-Object System.Drawing.Size(40,385)
    $Label7.Size = New-Object System.Drawing.Size(100,40)
    $Label7.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Label7.ForeColor = "Black"
    $Label7.Text = "Exchange DB: "

    #Define Text Box 1
        #Textbox to take the firstname for user creation
    $Textbox1 = New-Object System.Windows.Forms.TextBox
    $TextBox1.Location = New-Object System.Drawing.Size(140,130)
    $Textbox1.Size = New-Object System.Drawing.Size(120,25)
    $Textbox1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Textbox1.Multiline = $True

    #Define Text Box 2
        #Textbox for middle initial
    $Textbox2 = New-Object System.Windows.Forms.TextBox
    $TextBox2.Location = New-Object System.Drawing.Size(140,190)
    $Textbox2.Size = New-Object System.Drawing.Size(40,25)
    $Textbox2.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Textbox2.Multiline = $True

    #Define Text Box 3
        #Textbox for Surname
    $Textbox3 = New-Object System.Windows.Forms.TextBox
    $TextBox3.Location = New-Object System.Drawing.Size(140,250)
    $Textbox3.Size = New-Object System.Drawing.Size(120,25)
    $Textbox3.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Textbox3.Multiline = $True

    #Define Text Box 4
        #Textbox for password input
    $MaskedTextbox1 = New-Object Windows.Forms.MaskedTextBox
    $MaskedTextbox1.Location = New-Object System.Drawing.Size(140,295)
    $MaskedTextbox1.Size = New-Object System.Drawing.Size(120,25)
    $MaskedTextbox1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $MaskedTextbox1.PasswordChar = '*'
    $MaskedTextbox1.Multiline = $True
        <# Old text box:
        $Textbox4 = New-Object System.Windows.Forms.TextBox
        $TextBox4.Location = New-Object System.Drawing.Size(140,295)
        $Textbox4.Size = New-Object System.Drawing.Size(120,25)
        $Textbox4.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
        $Textbox4.Multiline = $True
        #>
    #Define Text Box 5
        #Textbox for Username to copy
    $Textbox5 = New-Object System.Windows.Forms.TextBox
    $TextBox5.Location = New-Object System.Drawing.Size(140,340)
    $Textbox5.Size = New-Object System.Drawing.Size(120,25)
    $Textbox5.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Textbox5.Multiline = $True

    #Define Text Box 6
        #Textbox for Exchange DB
    $Textbox6 = New-Object System.Windows.Forms.TextBox
    $TextBox6.Location = New-Object System.Drawing.Size(140,385)
    $Textbox6.Size = New-Object System.Drawing.Size(120,25)
    $Textbox6.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Textbox6.Multiline = $True

	# Define List Box for mailbox info output
    $Listbox1 = New-Object System.Windows.Forms.ListBox
    $Listbox1.Location = New-Object System.Drawing.Size(40,150)
    $Listbox1.Size = New-Object System.Drawing.Size(480,160)
    $Listbox1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)

    #Define dropdown list 1


            #Dropdown list
            $DropDownBox1 = New-Object System.Windows.Forms.ComboBox
            $DropDownBox1.Location = New-Object System.Drawing.Size(40,60)
            $DropDownBox1.Size = New-Object System.Drawing.Size(180,40)
            $DropDownBox1.DropDownHeight = 100
            $DropDownBox1.FlatStyle = "Flat"
            $DropDownBox1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)

        #Specify if it is for a contact or user
            #Array
            $wksList=@("New User","New Contact")

            #Populate the Dropdown with the array values
            foreach ($wks in $wksList) {
                      $DropDownBox1.Items.Add($wks)
                              } 
            #end foreach



#Define Main page buttons:

	# Define Button 1
        #Display the new user page
    $Button1 = new-object System.Windows.Forms.Button
    $Button1.Location = new-object System.Drawing.Size(40,40)
    $Button1.Size = new-object System.Drawing.Size(100,100)
    $Button1.BackColor = "DodgerBlue"
    $Button1.FlatAppearance.BorderSize = "0"
    $Button1.FlatStyle = "Flat"
    $Button1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button1.Text = “New User”
    $Button1.Name = "NewUser"
    $Button1.add_MouseHover($ShowHelp)
    $Button1.Add_Click({Display-NewUser})

    # Define Button 2
        #Display the Mailbox Info page
    $Button2 = new-object System.Windows.Forms.Button
    $Button2.Location = new-object System.Drawing.Size(160,40)
    $Button2.Size = new-object System.Drawing.Size(100,100)
    $Button2.BackColor = "DodgerBlue"
    $Button2.FlatAppearance.BorderSize = "0"
    $Button2.FlatStyle = "Flat"
    $Button2.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button2.Text = “Mailbox info”
    $Button2.Name = "MailboxInfo"
    $Button2.add_MouseHover($ShowHelp)
    $Button2.Add_Click({Display-Mailboxinfo})

	# Define Button 3
        #Display the Disable User page
    $Button3 = new-object System.Windows.Forms.Button
    $Button3.Location = new-object System.Drawing.Size(280,40)
    $Button3.Size = new-object System.Drawing.Size(100,100)
    $Button3.BackColor = "DodgerBlue"
    $Button3.ForeColor = "Black"
    $Button3.FlatAppearance.BorderSize = "0"
    $Button3.FlatStyle = "Flat"
    $Button3.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button3.Text = “Disable User”
    $Button3.Name = "Termination"
    $Button3.add_MouseHover($ShowHelp)
    $Button3.Add_Click({Display-Mailboxinfo})

    # Define Button 4
        #Display the Email Management page

    #Define Button 5
        #Display the 'Create and Manage distribution lists' page

#Define New user page buttons



    #Define Button 6
        #The change user or contact based off dropdown list selection button
    $Button6 = new-object System.Windows.Forms.Button
    $Button6.Location = new-object System.Drawing.Size(240,60)
    $Button6.Size = new-object System.Drawing.Size(120,28)
    $Button6.BackColor = "DodgerBlue"
    $Button6.ForeColor = "Black"
    $Button6.FlatAppearance.BorderSize = "0"
    $Button6.FlatStyle = "Flat"
    $Button6.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button6.Text = “Go”
    $Button6.Name = "UserContact"
    $Button6.add_MouseHover($ShowHelp)
    $Button6.Add_Click({Create-User})

    #Define Button 7
        #The Create Button
    $Button7 = new-object System.Windows.Forms.Button
    $Button7.Location = new-object System.Drawing.Size(680,390)
    $Button7.Size = new-object System.Drawing.Size(100,70)
    $Button7.BackColor = "DodgerBlue"
    $Button7.ForeColor = "Black"
    $Button7.FlatAppearance.BorderSize = "0"
    $Button7.FlatStyle = "Flat"
    $Button7.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Regular)
    $Button7.Text = “Create User”
    $Button7.Name = "Termination"
    $Button7.add_MouseHover($ShowHelp)
    $Button7.Add_Click({Create-User})


	<#
     Define Button 4
        #The Go button on the Get mailbox info page
    $Button4 = new-object System.Windows.Forms.Button
    $Button4.Location = new-object System.Drawing.Size(40,90)
    $Button4.Size = new-object System.Drawing.Size(100,30)
    $Button4.BackColor = "DodgerBlue"
    $Button4.ForeColor = "Black"
    $Button4.FlatAppearance.BorderSize = "0"
    $Button4.FlatStyle = "Flat"
    $Button4.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Bold)
    $Button4.Text = “Go”
    $Button4.Add_Click({Get-UserMailbox})

	# Define Button 5
        #The back button from the mailbox info page
    $Button5 = new-object System.Windows.Forms.Button
    $Button5.Location = new-object System.Drawing.Size(160,90)
    $Button5.Size = new-object System.Drawing.Size(100,30)
    $Button5.BackColor = "DodgerBlue"
    $Button5.ForeColor = "Black"
    $Button5.FlatAppearance.BorderSize = "0"
    $Button5.FlatStyle = "Flat"
    $Button5.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Bold)
    $Button5.Text = “Back”
    $Button5.Add_Click({Return-MainfromMailInfo})
    #>

#-----Draw the Empty Form-----#
$Form = New-Object System.Windows.Forms.Form
$Form.Width = 800
$Form.Height = 500
$Form.StartPosition = "CenterScreen"
$Form.BackColor = "LightGray"
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
$Form.Text = "New User & Mailbox program"
$Form.Icon = New-Object System.Drawing.Icon("C:\Scripts\Icons\Script.ico")
$Form.Add_KeyDown({if($_.Keycode -eq "Enter"){}})
    $Form.Add_KeyDown({if($_.Keycode -eq "Escape")
    {$Form.Close()}})
Display-Mainscreen

#-----Populate the Form-----#
$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()

<#
REF:

- ShowHelp scriptblock: https://www.petri.com/add-popup-tips-powershell-winforms-script
- Dropdown lists: https://sysadminemporium.wordpress.com/2012/11/27/powershell-gui-for-your-scripts-episode-2/



#>