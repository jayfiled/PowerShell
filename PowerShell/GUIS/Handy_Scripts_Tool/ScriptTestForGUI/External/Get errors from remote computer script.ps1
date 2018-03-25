﻿            $Hostname = Hostname

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

            $Server = Read-Host "Enter the computername: "

            $body =@()

            $body += Get-WinEvent -ComputerName $Server -FilterHashtable @{logname="System"; Level=2; starttime=$StartDate} -ErrorAction SilentlyContinue

            $body | ConvertTo-HTML -Head $css MachineName,ID,LevelDisplayName,TimeCreated,Message > C:\Temp\RemoteLogs\LogSysErrorView.html

            Invoke-Item \\$Hostname\C$\Temp\RemoteLogs\LogSysErrorView.html