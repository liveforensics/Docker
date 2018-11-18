# Dockerfile to build a Jenkins Windows Slave

# Indicates that the windowsservercore image will be used as the base image
FROM microsoft/windowsservercore

# Metadata indicating an image maintainer
MAINTAINER @liveforensics

# Let's start by installing chocolatey
RUN PowerShell.exe -Command "Invoke-Expression ((new-object system.net.webclient).downloadstring('https://chocolatey.org/install.ps1'))"
# RUN cmd.exe /S /C "choco install -y git"
# RUN refreshenv
# Now we'll install the git client using chocolatey
RUN choco.exe install -y git
# RUN refreshenv
# RUN choco.exe install jdk8 /exclude:32 -y 
# Now we install Java using chocolatey
# I've had to wrap the install in a powershell start-process because the install is successful but the stupid installer is returning an error code
# I think some part of the install cleanup process isn't working properly
RUN PowerShell.exe -Command "Start-Process -FilePath 'choco.exe' -ArgumentList 'install jdk8 /exclude:32 -y' -PassThru -Wait"
# RUN refreshenv
# RUN PowerShell.exe -Command \
# '$source = "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-windows-x64.exe"; \
# $destination = "c:\users\public\downloads\jdk-7u60-windows-i586.exe"; \
# $client = new-object System.Net.WebClient ; \
# $cookie = "oraclelicense=accept-securebackup-cookie"; \
# $client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookie) ; \
# $client.downloadFile($source, $destination)'
RUN mkdir c:\\Persist
RUN mkdir c:\\JenkinsRoot
COPY ./jenkins-agent c:\\Persist 
# RUN PowerShell.exe -Command "Start-Process -FilePath 'c:\persist\jenkins-slave.exe' -ArgumentList 'install' -PassThru -Wait"
RUN c:\persist\jenkins-slave.exe install
RUN PowerShell.exe -Command "Start-Service JenkinsSlave"
# Sets a command or process that will run each time a container is run from the new image
CMD [ "powershell" ]


