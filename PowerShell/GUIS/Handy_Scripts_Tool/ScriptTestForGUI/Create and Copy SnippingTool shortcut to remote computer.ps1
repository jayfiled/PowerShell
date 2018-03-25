$Global:computername = Read-Host "Computername to copy to: "

$Shell = New-Object -ComObject ("WScript.Shell")

$ShortCut = $Shell.CreateShortcut("\\$Global:Computername\c$\Users\Public\Desktop\SnippingTool.lnk")

$ShortCut.TargetPath="SnippingTool.exe"
$ShortCut.Arguments="/clip"
$ShortCut.WorkingDirectory = "C:\Windows\System32\";
$ShortCut.WindowStyle = 1;
$ShortCut.Hotkey = "CTRL+SHIFT+S";
$ShortCut.IconLocation = "SnippingTool.exe, 0";
$ShortCut.Description = "Snipping Tool";
$ShortCut.Save()