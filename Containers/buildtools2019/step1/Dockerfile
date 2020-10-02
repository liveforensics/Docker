# escape=`
FROM liveforensics/buildbox:2004-powerpc

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD build.ps1 c:\temp\build.ps1

ENTRYPOINT ["powershell.exe", "-f", "C:/temp/build1.ps1"]