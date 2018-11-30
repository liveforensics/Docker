# Dockerfile to build a Jenkins Windows Slave

# Indicates that the windowsservercore image will be used as the base image
# FROM microsoft/windowsservercore
FROM microsoft/dotnet-framework:4.7.2-runtime-windowsservercore-1803

# Metadata indicating an image maintainer
MAINTAINER @liveforensics

# Let's start by installing chocolatey
RUN PowerShell.exe -Command "Invoke-Expression ((new-object system.net.webclient).downloadstring('https://chocolatey.org/install.ps1'))"
# RUN cmd.exe /S /C "choco install -y git"
# RUN refreshenv
# Now we'll install the git client using chocolatey
RUN choco.exe install -y git

# Now we install Java using chocolatey
# I've had to wrap the install in a powershell start-process because the install is successful but the stupid installer is returning an error code
# I think some part of the install cleanup process isn't working properly
RUN PowerShell.exe -Command "Start-Process -FilePath 'choco.exe' -ArgumentList 'install jdk8 /exclude:32 -y' -PassThru -Wait"

RUN mkdir c:\\Persist
RUN mkdir c:\\JenkinsRoot
COPY ./jenkins-agent c:\\Persist 

RUN c:\persist\jenkins-slave.exe install
RUN PowerShell.exe -Command "Start-Service JenkinsSlave"

SHELL ["cmd", "/S", "/C"]
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\\Persist\\vs_buildtools.exe
ADD https://aka.ms/vs/15/release/vs_testagent.exe C:\\Persist\\vs_testagent.exe
ADD Wait-Service.ps1 /Wait-Service.ps1
ADD https://dist.nuget.org/win-x86-commandline/v4.3.0/nuget.exe C:\\Nuget\\nuget.exe


# Install Build Tools excluding workloads and components with known issues.
RUN C:\\Persist\\vs_buildtools.exe --quiet --wait --norestart --nocache \
    --installPath C:\\BuildTools \
    --all \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 \
    --remove Microsoft.VisualStudio.Component.Windows81SDK \
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

# RUN C:\\Persist\\vs_testagent.exe --quiet --wait --norestart --nocache \
#     --installPath C:\\BuildTools \
#     --all \
#     || IF "%ERRORLEVEL%"=="3010" EXIT 0

RUN SETX /M Path "%Path%;C:\\Nuget;C:\\BuildTools\\MSBuild\\15.0\\Bin"

RUN rmdir /S /Q c:\\Persist

CMD powershell.exe -file c:\Wait-Service.ps1 -ServiceName EventLog -AllowServiceRestart

