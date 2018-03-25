#Import csv

$csv = Import-CSV "<#Name of report.csv#>"


#Defining functions

#Function to prompt for a username then check display the row with their computername

    Function Match-User

    {

    $Name = Read-Host "Enter the user name, or part of their surname: "

    $Global:Output = $csv | Where-Object {$_.User -like "*$Name*"} | Format-Table User, Computer_Name

    }


Match-User

$Global:Output

$Answer = Read-Host "Again? Type Y or N "

if ($Answer -eq "Y")
{Match-User; $Global:Output}
Else
{Exit}