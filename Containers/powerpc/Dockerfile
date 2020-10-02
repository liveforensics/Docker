# escape=`
FROM liveforensics/buildbox:2004-jenkinsagent

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD build.ps1 c:\temp\build.ps1
RUN powershell.exe -file c:\temp\build.ps1