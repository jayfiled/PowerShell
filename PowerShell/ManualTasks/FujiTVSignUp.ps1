add-type -AssemblyName microsoft.VisualBasic

add-type -AssemblyName System.Windows.Forms

CD "C:\Program Files (x86)\Google\Chrome\Application\"

.\FUJITVRegister.url

start-sleep -Seconds 10

$numpath = ".\Resource\NumberForFuji.txt"

[int]$j = Get-Content -path $numpath

$h = ++$j

$h | set-content $numpath -force

start-sleep -Seconds 1

[System.Windows.Forms.SendKeys]::SendWait("jayfiled"+"{+}"+"$h@gmail.com")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1

#Use this password for registration

[System.Windows.Forms.SendKeys]::SendWait("#Type-Password#")
start-sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1

#Repeat password

[System.Windows.Forms.SendKeys]::SendWait("#Type-Password#")
start-sleep -Milliseconds 500


[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait(" ")
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

#Ref:

#https://stackoverflow.com/questions/33707193/how-to-convert-string-to-integer-in-powershell

#https://msdn.microsoft.com/en-us/library/aa266279(v=vs.60).aspx

#http://www.vbforums.com/showthread.php?419959-Resolved-Sending-quot-space-quot-with-SendKeys

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-content?view=powershell-6

