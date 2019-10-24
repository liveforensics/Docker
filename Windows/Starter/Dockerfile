# escape=`

# Copyright (C) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license. See LICENSE.txt in the project root for license information.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-1903

# Reset the shell.
SHELL ["cmd", "/S", "/C"]

RUN mkdir c:\Persist
RUN mkdir c:\Jenkins
RUN mkdir c:\JenkinsRoot
RUN mkdir c:\SplunkForward
ADD https://download.splunk.com/products/universalforwarder/releases/7.3.2/windows/splunkforwarder-7.3.2-c60db69f8e32-x64-release.msi  c:\persist\splunk_installer.msi
ADD SplunkInstall.ps1 c:\persist\SplunkInstall.ps1
ADD Wait-Service.ps1 /Wait-Service.ps1
ADD https://dist.nuget.org/win-x86-commandline/v5.3.0/nuget.exe C:\Nuget\nuget.exe
ADD Create-Account.ps1 c:\persist\Create-Account.ps1
ADD ./jenkins-agent c:\Jenkins 

ENV JENKINS_SECRET '0011111111111111111111111111111111111111111111111111111111111111c632'
ENV JENKINS_URL 'http://doh.com/computer/DockerOne/slave-agent.jnlp'
ENV SPLUNK_HOST 'dockerdude.ukwest.cloudapp.azure.com'
ENV SPLUNK_PORT '10009'

RUN powershell.exe -file c:\\persist\\create-account.ps1
RUN SETX /M Path "%Path%;C:\Program Files\SplunkUniversalForwarder\bin\;C:\Nuget;c:\python27amd64;C:\BuildTools\MSBuild\Current\Bin;C:\BuildTools\Common7\IDE\Extensions\TestPlatform;C:\BuildTools\Team Tools\Dynamic Code Coverage Tools"
# Set up environment to collect install errors.
COPY Install.cmd C:\Temp\
ADD https://aka.ms/vscollect.exe C:\Temp\collect.exe

# Let's start by installing chocolatey
RUN PowerShell.exe -Command "Invoke-Expression ((new-object system.net.webclient).downloadstring('https://chocolatey.org/install.ps1'))"

# Now we'll install the git client using chocolatey
RUN choco.exe install -y git

# Now we install Java using chocolatey
# I've had to wrap the install in a powershell start-process because the install is successful but the stupid installer is returning an error code
# I think some part of the install cleanup process isn't working properly
RUN PowerShell.exe -Command "Start-Process -FilePath 'choco.exe' -ArgumentList 'install jdk8 /exclude:32 -y' -PassThru -Wait"

RUN PowerShell.exe -Command "Start-Process -FilePath 'msiexec.exe' -ArgumentList '/i c:\persist\splunk_installer.msi AGREETOLICENSE=yes SPLUNKPASSWORD=P@ssw0rd PERFMON=diskspace,memory LAUNCHSPLUNK=0 /quiet' -PassThru -Wait"
# RUN ["msiexec.exe", "/i", "c:\persist\splunk_installer.msi", "AGREETOLICENSE=yes", "SPLUNKPASSWORD=P@ssw0rd", "PERFMON=diskspace,memory", "LAUNCHSPLUNK=0", "/quiet"]
RUN powershell.exe -file c:\persist\SplunkInstall.ps1


# Download channel for fixed install.
ARG CHANNEL_URL=https://aka.ms/vs/16/release/channel
ADD ${CHANNEL_URL} C:\Temp\VisualStudio.chman

# Download and install Build Tools for Visual Studio 2017 for native desktop workload.
ADD https://aka.ms/vs/16/release/vs_enterprise.exe C:\Temp\vs_enterprise.exe
# RUN C:\Temp\Install.cmd C:\Temp\vs_enterprise.exe --quiet --wait --norestart --nocache `
#     --channelUri C:\Temp\VisualStudio.chman `
#     --installChannelUri C:\Temp\VisualStudio.chman `
    # --add Microsoft.Component.MSBuild `
    # --add Microsoft.VisualStudio.Workload.NativeDesktop `
    # --add Microsoft.VisualStudio.Workload.ManagedDesktop `
    # --add Microsoft.VisualStudio.Workload.Universal `
    # --add Microsoft.Net.Component.4.5.TargetingPack `
    # --add Microsoft.Net.Component.4.5.1.TargetingPack `
    # --add Microsoft.Net.Component.4.5.2.TargetingPack `
    # --add Microsoft.Net.Component.3.5.DeveloperTools `
    # --add Microsoft.Net.Component.4.6.TargetingPack `
    # --add Microsoft.Net.Component.4.6.1.TargetingPack `
    # --add Microsoft.Net.ComponentGroup.4.6.1.DeveloperTools `
    # --add Microsoft.Net.Component.4.6.2.TargetingPack `
    # --add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools `
    # --add Microsoft.Net.Component.4.7.TargetingPack `
    # --add Microsoft.Net.ComponentGroup.4.7.DeveloperTools `
    # --add Microsoft.Net.Component.4.7.1.TargetingPack `
    # --add Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools `
    # --add Microsoft.Net.Component.4.7.2.TargetingPack `
    # --add Microsoft.Net.Component.4.8.TargetingPack `
    # --add Microsoft.Net.ComponentGroup.4.8.DeveloperTools `
    # --add Microsoft.Net.Component.4.8.SDK `
    # --add Microsoft.Net.Component.4.TargetingPack `
    # --add Microsoft.Net.ComponentGroup.TargetingPacks.Common `
    # --add Microsoft.Component.PythonTools `
    # --add Microsoft.VisualStudio.Workload.Python `
    # --add Component.CPython2.x64 `
    # --add Microsoft.VisualStudio.Component.Windows10SDK `
    # --add Microsoft.VisualStudio.Component.Windows10SDK.16299 `
    # --add Microsoft.VisualStudio.Component.Windows10SDK.17134 `
    # --add Microsoft.VisualStudio.Component.Windows10SDK.17763 `
    # --add Microsoft.VisualStudio.Component.Windows10SDK.18362 `
    # --add Microsoft.Net.Component.4.6.1.SDK `
    # --add Microsoft.Net.Component.4.6.2.SDK `
    # --add Microsoft.Net.Component.4.7.1.SDK `
    # --add Microsoft.Net.Component.4.7.2.SDK `
    # --add Microsoft.Net.Component.4.7.SDK `
    # --add Microsoft.Net.Component.4.8.SDK `
    # --add Microsoft.VisualStudio.Component.VC.140 `
    # --add Microsoft.VisualStudio.Component.VC.v141.x86.x64 `
    # --add Component.CPython3.x64 `
    # --includeRecommended `
    # --installPath C:\BuildTools

RUN rmdir /S /Q c:\Persist
# RUN rmdir /S /Q c:\BuildTools
# RUN rmdir /S /Q "c:\Program Files (x86)\Windows Kits"


# Use developer command prompt and start PowerShell if no other command specified.
# CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass", "-file", "c:\Wait-Service.ps1", "-ServiceName", "EventLog", "-AllowServiceRestart"]
CMD powershell.exe -file c:\Wait-Service.ps1 -ServiceName EventLog -AllowServiceRestart

# c:\programdata\packagecache
# c:\windows\assembly
