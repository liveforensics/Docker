# escape=`

# Copyright (C) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license. See LICENSE.txt in the project root for license information.
# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-1903
FROM mcr.microsoft.com/windows/servercore:2004-amd64
LABEL maintainer=liveforensics description="Windows Jenkins Slave Base Image"

ADD Wait-Service.ps1 Wait-Service.ps1

ENTRYPOINT ["powershell.exe", "-file", "c:\\Wait-Service.ps1", "-ServiceName", "EventLog", "-AllowServiceRestart"]