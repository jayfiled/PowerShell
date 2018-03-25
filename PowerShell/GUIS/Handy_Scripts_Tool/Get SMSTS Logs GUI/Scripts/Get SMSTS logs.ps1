#Copy Remote PC's SMSTS files to Local Machine and run it

Write-Host "Enter PC name: " -nonewline
$RemotePC = Read-Host
$Hostname = Hostname

New-Item C:\Temp\RemoteSMSTS -ItemType Directory -ErrorAction SilentlyContinue
Copy-Item \\$RemotePC\C$\Windows\CCM\Logs\SMSTS*.log \\$Hostname\C$\Temp\RemoteSMSTS\ -ErrorAction SilentlyContinue
Invoke-Item \\$Hostname\C$\Temp\RemoteSMSTS\SMSTS*.log