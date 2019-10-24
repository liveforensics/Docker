# escape=`

# Copyright (C) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license. See LICENSE.txt in the project root for license information.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-1903

# Reset the shell.
SHELL ["cmd", "/S", "/C"]

RUN mkdir c:\Persist
ADD build.ps1 c:\persist\build.ps1
ADD Wait-Service.ps1 Wait-Service.ps1
ADD inputs.conf c:\persist
ADD outputs.conf c:\persist

RUN powershell.exe -file c:\persist\build.ps1

ADD ./jenkins-agent c:\Jenkins 
# Download channel for fixed install.
ARG CHANNEL_URL=https://aka.ms/vs/16/release/channel
ADD ${CHANNEL_URL} C:\Temp\VisualStudio.chman

ENV JENKINS_SECRET '0011111111111111111111111111111111111111111111111111111111111111c632'
ENV JENKINS_URL 'http://doh.com/computer/DockerOne/slave-agent.jnlp'
ENV SPLUNK_HOST 'where.here.cloudapp.azure.com'
ENV SPLUNK_PORT '10009'

RUN SETX /M Path "%Path%;C:\Program Files\SplunkUniversalForwarder\bin\;C:\Nuget;c:\python27amd64;C:\BuildTools\MSBuild\Current\Bin;C:\BuildTools\Common7\IDE\Extensions\TestPlatform;C:\BuildTools\Team Tools\Dynamic Code Coverage Tools"

RUN rmdir /S /Q c:\Persist
CMD powershell.exe -file c:\Wait-Service.ps1 -ServiceName EventLog -AllowServiceRestart
