# escape=`
FROM liveforensics/buildbox:2004-jenkinsagent

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD build.ps1 c:\temp\build.ps1
ADD python-3.8.6-embed-amd64 c:\temp\python.zip

RUN Expand-Archive -Path 'c:/temp/python.zip' -DestinationPath 'c:\python3'; `
    $CurrentPath = (Get-Itemproperty -path 'hklm:\system\currentcontrolset\control\session manager\environment' -Name Path).Path; `
    $NewPath = $CurrentPath + ';C:\python3'; `
    Set-ItemProperty -path 'hklm:\system\currentcontrolset\control\session manager\environment' -Name Path -Value $NewPath; `
    Remove-Item c:\temp\python.zip -force  

ENTRYPOINT ["powershell.exe", "-f", "C:/temp/build.ps1"]