# escape=`

# Copyright (C) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license. See LICENSE.txt in the project root for license information.
# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-1903
FROM mcr.microsoft.com/windows/servercore:1903
LABEL maintainer=liveforensics description="Windows Jenkins Agent"

# Reset the shell.
SHELL ["cmd", "/S", "/C"]

RUN mkdir c:\Persist
ADD build.ps1 c:\persist\build.ps1
ADD Wait-Service.ps1 Wait-Service.ps1

RUN powershell.exe -file c:\persist\build.ps1

ADD ./jenkins-agent c:\Jenkins 

ENV JENKINS_SECRET '0011111111111111111111111111111111111111111111111111111111111111c632'
ENV JENKINS_URL 'http://doh.com/computer/DockerOne/slave-agent.jnlp'

RUN rmdir /S /Q c:\Persist
CMD powershell.exe -file c:\Wait-Service.ps1 -ServiceName EventLog -AllowServiceRestart