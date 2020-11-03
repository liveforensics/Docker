# escape=`

FROM mcr.microsoft.com/windows/servercore:2004-amd64
LABEL maintainer=liveforensics description="Windows Jenkins Wireshark Builder"

# Restore the default Windows shell for correct batch processing.
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN mkdir c:\temp
ADD build.ps1 c:\temp\build.ps1
# ADD http://download.qt.io/official_releases/qt/5.12/5.12.9/qt-opensource-windows-x86-5.12.9.exe c:\temp\qt.exe

RUN c:\temp\build.ps1

