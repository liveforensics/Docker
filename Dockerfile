# Dockerfile to build a Jenkins Windows Slave

# Indicates that the windowsservercore image will be used as the base image
# FROM microsoft/windowsservercore
FROM microsoft/dotnet-framework:4.7.1

# Metadata indicating an image maintainer
MAINTAINER @liveforensics

# Let's start by installing chocolatey
RUN PowerShell.exe -Command "Invoke-Expression ((new-object system.net.webclient).downloadstring('https://chocolatey.org/install.ps1'))"
# RUN cmd.exe /S /C "choco install -y git"
# RUN refreshenv
# Now we'll install the git client using chocolatey
RUN choco.exe install -y git
# RUN refreshenv C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\Extensions\TestPlatform
# RUN choco.exe install jdk8 /exclude:32 -y 
# Now we install Java using chocolatey
# I've had to wrap the install in a powershell start-process because the install is successful but the stupid installer is returning an error code
# I think some part of the install cleanup process isn't working properly
# RUN PowerShell.exe -Command "Start-Process -FilePath 'choco.exe' -ArgumentList 'install jdk8 /exclude:32 -y' -PassThru -Wait"
# RUN refreshenv
# RUN PowerShell.exe -Command \
# '$source = "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-windows-x64.exe"; \
# $destination = "c:\users\public\downloads\jdk-7u60-windows-i586.exe"; \
# $client = new-object System.Net.WebClient ; \
# $cookie = "oraclelicense=accept-securebackup-cookie"; \
# $client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookie) ; \
# $client.downloadFile($source, $destination)'
RUN mkdir c:\\Persist
# UN mkdir c:\\JenkinsRoot
# COPY ./jenkins-agent c:\\Persist 
# RUN PowerShell.exe -Command "Start-Process -FilePath 'c:\persist\jenkins-slave.exe' -ArgumentList 'install' -PassThru -Wait"
# RUN c:\persist\jenkins-slave.exe install
# RUN PowerShell.exe -Command "Start-Service JenkinsSlave"

SHELL ["cmd", "/S", "/C"]
ADD https://aka.ms/vs/15/release/vs_enterprise.exe C:\\Persist\\vs_enterprise.exe
ADD https://dist.nuget.org/win-x86-commandline/latest/nuget.exe C:\\Nuget\\nuget.exe


# Install Build Tools excluding workloads and components with known issues.
RUN C:\\Persist\\vs_enterprise.exe --quiet --wait --norestart --nocache \
    --installPath C:\\BuildTools \
    --add Microsoft.Component.MSBuild \
    --add Microsoft.VisualStudio.Component.TestTools.Core \
    --add Microsoft.VisualStudio.Component.TestTools.MicrosoftTestManager \
    --add Microsoft.Net.Component.4.5.TargetingPack \
 || IF "%ERRORLEVEL%"=="3010" EXIT 0



RUN SETX /M Path "%Path%;C:\\Nuget;C:\\BuildTools\\MSBuild\\15.0\\Bin"

RUN rmdir /S /Q c:\\Persist
# Sets a command or process that will run each time a container is run from the new image
# Start developer command prompt with any other commands specified.
# ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat &&

# Default to PowerShell if no other command specified.
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

