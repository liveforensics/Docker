# Dockerfile to build a Jenkins Windows Slave

# Indicates that the windowsservercore image will be used as the base image
# FROM microsoft/windowsservercore
# FROM microsoft/dotnet-framework:4.7.2-runtime-windowsservercore-1803
FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-1903

# Metadata indicating an image maintainer
MAINTAINER @liveforensics

RUN mkdir c:\\Persist
RUN mkdir c:\\Jenkins
RUN mkdir c:\\JenkinsRoot
RUN mkdir c:\\vc
ADD https://aka.ms/vs/16/release/vs_enterprise.exe C:\\vc\\vs_enterprise.exe
ADD Wait-Service.ps1 /Wait-Service.ps1
ADD https://dist.nuget.org/win-x86-commandline/v4.3.0/nuget.exe C:\\Nuget\\nuget.exe
ADD https://aka.ms/VsCollect/collect.exe c:\\Persist\\collect.exe
ADD Create-Account.ps1 c:\\persist\\Create-Account.ps1
ADD ./jenkins-agent c:\\Jenkins 

ENV JENKINS_SECRET '00a9c8b49dbcb471d86d33e9107ddcfdeaeb24f56f8661256d2e1f5e78b7c632'
ENV JENKINS_URL 'http://dockerdude.ukwest.cloudapp.azure.com:10008/computer/DockerOne/slave-agent.jnlp'

RUN powershell.exe -file c:\\persist\\create-account.ps1
RUN SETX /M Path "%Path%;C:\\Nuget;C:\\BuildTools\\MSBuild\\15.0\\Bin;C:\BuildTools\Common7\IDE\Extensions\TestPlatform;C:\BuildTools\Team Tools\Dynamic Code Coverage Tools"
# Let's start by installing chocolatey
RUN PowerShell.exe -Command "Invoke-Expression ((new-object system.net.webclient).downloadstring('https://chocolatey.org/install.ps1'))"

# Now we'll install the git client using chocolatey
RUN choco.exe install -y git
RUN choco.exe install -y python2

# Now we install Java using chocolatey
# I've had to wrap the install in a powershell start-process because the install is successful but the stupid installer is returning an error code
# I think some part of the install cleanup process isn't working properly
RUN PowerShell.exe -Command "Start-Process -FilePath 'choco.exe' -ArgumentList 'install jdk8 /exclude:32 -y' -PassThru -Wait"

# Install Build Tools excluding workloads and components with known issues.
RUN C:\\vc\\vs_enterprise.exe --quiet --wait --norestart --nocache --includeRecommended --includeOptional \
    --installPath C:\\BuildTools \
    # --add Microsoft.Component.MSBuild \
    --add Microsoft.VisualStudio.Workload.NativeDesktop \
    # --add Microsoft.VisualStudio.Component.Windows10SDK.18362 \
    # --add Microsoft.VisualStudio.Component.Windows10SDK.16299 \
    # --add Microsoft.VisualStudio.Component.Windows81SDK \
    # --add Microsoft.VisualStudio.Component.TestTools.Core \
    # --add Microsoft.VisualStudio.Component.TestTools.BuildTools \
    # --add Microsoft.VisualStudio.Component.TestTools.MicrosoftTestManager \
    # --add Microsoft.Net.Component.4.5.TargetingPack \
    # --add Microsoft.VisualStudio.Workload.VCTools \
    # --add Microsoft.VisualStudio.Component.Windows81SDK \
    # --add Microsoft.VisualStudio.Component.Windows10SDK.15063.Desktop \
    # --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 \
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

RUN rmdir /S /Q c:\\Persist

CMD powershell.exe -file c:\Wait-Service.ps1 -ServiceName EventLog -AllowServiceRestart



 




