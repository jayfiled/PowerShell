#Can't use the powershell cmdlets for downloading direct from the internet through proxy, so manually run this task every month and get a coffee.

add-type -AssemblyName microsoft.VisualBasic

add-type -AssemblyName System.Windows.Forms

CD "C:\Program Files\Internet Explorer\"

.\iexplore.exe

start-sleep -Seconds 10

#[Microsoft.VisualBasic.Interaction]::AppActivate("iexplorer")

[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
[System.Windows.Forms.SendKeys]::SendWait("http://cloud.sophos.com/manage/endpoint/downloads")

[System.Windows.Forms.SendKeys]::SendWait("~")
start-sleep -Seconds 15
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait('##Sophos logon email')
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("##sophos logon password")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("~")
start-sleep -Seconds 20
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("~")
start-sleep -Seconds 5
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("~")
start-sleep -Seconds 10
[System.Windows.Forms.SendKeys]::SendWait("~")
