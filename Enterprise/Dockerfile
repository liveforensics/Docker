# Dockerfile to build a Jenkins Windows Slave

# Indicates that the windowsservercore image will be used as the base image
# FROM microsoft/windowsservercore
FROM microsoft/dotnet-framework:4.7.2-runtime-windowsservercore-1803

# Metadata indicating an image maintainer
MAINTAINER @liveforensics

RUN mkdir c:\\Persist
ADD https://aka.ms/vs/15/release/vs_enterprise.exe C:\\Persist\\vs_enterprise.exe
ADD Wait-Service.ps1 /Wait-Service.ps1
ADD https://dist.nuget.org/win-x86-commandline/v4.3.0/nuget.exe C:\\Nuget\\nuget.exe
ADD https://aka.ms/VsCollect/collect.exe c:\\Persist\\collect.exe
ADD Create-Account.ps1 c:\\persist\\Create-Account.ps1

RUN powershell.exe -file c:\\persist\\create-account.ps1

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

# Install Build Tools excluding workloads and components with known issues.
RUN C:\\Persist\\vs_enterprise.exe --quiet --wait --norestart --nocache \
    --installPath C:\\BuildTools \
    --add Microsoft.Component.MSBuild \
    --add Microsoft.VisualStudio.Component.TestTools.Core \
    --add Microsoft.VisualStudio.Component.TestTools.MicrosoftTestManager \
    --add Microsoft.Net.Component.4.5.TargetingPack \
 || IF "%ERRORLEVEL%"=="3010" EXIT 0


RUN SETX /M Path "%Path%;C:\\Nuget;C:\\BuildTools\\MSBuild\\15.0\\Bin;C:\BuildTools\Common7\IDE\Extensions\TestPlatform;C:\BuildTools\Team Tools\Dynamic Code Coverage Tools"

RUN rmdir /S /Q c:\\Persist

CMD powershell.exe -file c:\Wait-Service.ps1 -ServiceName EventLog -AllowServiceRestart



 




