# escape=`
FROM liveforensics/inbound-agent:windowsservercore-2004

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD build.ps1 c:\temp\build.ps1
# ADD python-3.8.6-embed-amd64 c:\temp\python.zip

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.8.6/python-3.8.6-embed-amd64.zip" -OutFile "c:/temp/python.zip"; `
    Expand-Archive -Path 'c:/temp/python.zip' -DestinationPath 'c:\python3'; `
    New-Item -Type Directory c:\nuget; `
    Invoke-WebRequest -Uri "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile "C:/nuget/nuget.exe"; `
    $CurrentPath = (Get-Itemproperty -path 'hklm:\system\currentcontrolset\control\session manager\environment' -Name Path).Path; `
    $NewPath = $CurrentPath + ';C:\python3;c:\nuget'; `
    Set-ItemProperty -path 'hklm:\system\currentcontrolset\control\session manager\environment' -Name Path -Value $NewPath
    # Remove-Item c:\temp\python.zip -force  

ENTRYPOINT ["powershell.exe", "-f", "C:/temp/build.ps1"]