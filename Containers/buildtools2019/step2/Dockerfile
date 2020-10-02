# escape=`
FROM temp/step1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENTRYPOINT ["powershell.exe", "-f", "C:/ProgramData/Jenkins/jenkins-agent.ps1"]