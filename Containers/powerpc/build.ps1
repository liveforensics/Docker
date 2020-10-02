[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.8.6/python-3.8.6-embed-amd64.zip" -OutFile "c:/temp/python-3.8.6-embed-amd64.zip"
Expand-Archive -Path 'c:/temp/python-3.8.6-embed-amd64.zip' -DestinationPath 'c:\python3'

Invoke-WebRequest -Uri "http://sysprogs.com/getfile/34/powerpc-eabi-gcc4.9.0.exe" -OutFile "c:/temp/powerpc.exe"


$CurrentPath = (Get-Itemproperty -path 'hklm:\system\currentcontrolset\control\session manager\environment' -Name Path).Path
$NewPath = $CurrentPath + ';C:\python3'
Set-ItemProperty -path 'hklm:\system\currentcontrolset\control\session manager\environment' -Name Path -Value $NewPath