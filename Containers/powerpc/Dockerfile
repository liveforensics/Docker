# escape=`
FROM liveforensics//inbound-agent:windowsservercore-2004

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD build.ps1 c:\temp\build.ps1
ADD powerpc-eabi.zip c:\temp\powerpc-eabi.zip
RUN powershell.exe -file c:\temp\build.ps1