# Dockerfile to build a Jenkins Windows Slave

# Indicates that the windowsservercore image will be used as the base image
# FROM microsoft/windowsservercore
FROM microsoft/dotnet-framework:4.7.2-runtime-windowsservercore-1803

# Metadata indicating an image maintainer
MAINTAINER @liveforensics

RUN mkdir c:\\Persist
ADD Wait-Service.ps1 /Wait-Service.ps1


# Let's start by installing chocolatey
RUN PowerShell.exe -Command "Invoke-Expression ((new-object system.net.webclient).downloadstring('https://chocolatey.org/install.ps1'))"

# Now we'll install the git client using chocolatey
RUN choco.exe install -y git

# Now we install Java using chocolatey
# I've had to wrap the install in a powershell start-process because the install is successful but the stupid installer is returning an error code
# I think some part of the install cleanup process isn't working properly
RUN PowerShell.exe -Command "Start-Process -FilePath 'choco.exe' -ArgumentList 'install jdk8 /exclude:32 -y' -PassThru -Wait"

COPY ./jenkins-agent c:\\Persist 

RUN c:\persist\jenkins-slave.exe install
RUN PowerShell.exe -Command "Start-Service JenkinsSlave"

# RUN PowerShell.exe -Command \
#     # "stop-service jenkinsslave; \
#     "Enable-LocalUser administrator; \
#     $secpasswd = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force; \
#     Set-LocalUser Administrator -Password $secpasswd"

# RUN sc.exe config jenkinsslave type= own obj= "\Administrator" password= "P@ssw0rd"

# RUN PowerShell.exe -Command "Start-Service JenkinsSlave"
ADD Change-Logon.ps1 /Change-Logon.ps1
RUN rmdir /S /Q c:\\Persist

CMD powershell.exe -file c:\Wait-Service.ps1 -ServiceName EventLog -AllowServiceRestart



 




