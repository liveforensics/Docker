Write-Host "SPLUNK Installer Script"

$file = "C:\Program Files\SplunkUniversalForwarder\etc\system\local\inputs.conf"

$exe = "C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe"

Remove-Item -Path $file -Force

Add-Content $file "[default]"
Add-Content $file "host = %REPLACEME%"
Add-Content $file "`r`n[batch://c:\SplunkForward]"
Add-Content $file "move_policy = sinkhole"
Add-Content $file "crcSalt = <SOURCE>"
Add-Content $file "disabled = false"
Add-Content $file "sourcetype = JenkinsSlave"

Get-Content $file

