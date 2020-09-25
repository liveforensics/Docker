# escape=`
FROM liveforensics/buildbox:2004-jenkinsagent

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
COPY build1.ps1 C:/ProgramData/Jenkins

ENTRYPOINT ["powershell.exe", "-f", "C:/ProgramData/Jenkins/build1.ps1"]
