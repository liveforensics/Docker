# escape=`

# Copyright (C) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license. See LICENSE.txt in the project root for license information.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-1903

# Reset the shell.
SHELL ["cmd", "/S", "/C"]

RUN mkdir c:\Jenkins
RUN mkdir c:\JenkinsRoot
ADD Wait-Service.ps1 /Wait-Service.ps1
ADD https://dist.nuget.org/win-x86-commandline/v5.3.0/nuget.exe C:\Nuget\nuget.exe
ADD Create-Account.ps1 c:\persist\Create-Account.ps1
ADD ./jenkins-agent c:\Jenkins 

ENV JENKINS_SECRET '0011111111111111111111111111111111111111111111111111111111111111c632'
ENV JENKINS_URL 'http://doh.com/computer/DockerOne/slave-agent.jnlp'

RUN powershell.exe -file c:\\persist\\create-account.ps1
RUN SETX /M Path "%Path%;C:\\Nuget;c:\\python27amd64;C:\\BuildTools\\MSBuild\\Current\\Bin;C:\BuildTools\Common7\IDE\Extensions\TestPlatform;C:\BuildTools\Team Tools\Dynamic Code Coverage Tools"
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
# Download channel for fixed install.
ARG CHANNEL_URL=https://aka.ms/vs/16/release/channel
ADD ${CHANNEL_URL} C:\Temp\VisualStudio.chman

# Download and install Build Tools for Visual Studio 2017 for native desktop workload.
ADD https://aka.ms/vs/16/release/vs_enterprise.exe C:\Temp\vs_enterprise.exe
RUN C:\Temp\Install.cmd C:\Temp\vs_enterprise.exe --quiet --wait --norestart --nocache `
    --channelUri C:\Temp\VisualStudio.chman `
    --installChannelUri C:\Temp\VisualStudio.chman `
    --add Microsoft.Component.MSBuild `
    --add Microsoft.VisualStudio.Workload.NativeDesktop `
    --add Microsoft.VisualStudio.Workload.ManagedDesktop `
    --add Microsoft.VisualStudio.Workload.Python `
    --add Component.CPython2.x64 `
    --installPath C:\BuildTools

RUN rmdir /S /Q c:\Persist

# Use developer command prompt and start PowerShell if no other command specified.
# CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass", "-file", "c:\Wait-Service.ps1", "-ServiceName", "EventLog", "-AllowServiceRestart"]
CMD powershell.exe -file c:\Wait-Service.ps1 -ServiceName EventLog -AllowServiceRestart