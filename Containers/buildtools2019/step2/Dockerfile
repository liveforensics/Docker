# escape=`
FROM temp/step1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Remove-Item c:\temp -recurse -force
RUN Remove-Item c:\vs -recurse -force
RUN New-Item -Type Directory c:\JenkinsRoot 

ENTRYPOINT ["powershell.exe", "-f", "C:/ProgramData/Jenkins/jenkins-agent.ps1"]