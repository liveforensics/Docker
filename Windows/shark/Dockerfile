# escape=`

FROM mcr.microsoft.com/windows/servercore:2004-amd64
LABEL maintainer=liveforensics description="Windows Jenkins Wireshark Builder"

# Restore the default Windows shell for correct batch processing.
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN mkdir c:\temp
ADD build.ps1 c:\temp\build.ps1
# ADD http://download.qt.io/official_releases/qt/5.12/5.12.9/qt-opensource-windows-x86-5.12.9.exe c:\temp\qt.exe

RUN c:\temp\build.ps1

WORKDIR c:\development
RUN git clone 'https://gitlab.com/wireshark/wireshark.git'

# # Copy our Install script.
# COPY install.cmd C:\TEMP\

# # Download collect.exe in case of an install failure.
# ADD https://aka.ms/vscollect.exe C:\TEMP\collect.exe

# # Use the latest release channel. For more control, specify the location of an internal layout.
# ARG CHANNEL_URL=https://aka.ms/vs/16/release/channel
# ADD ${CHANNEL_URL} C:\TEMP\VisualStudio.chman


# # Download the Build Tools bootstrapper.
# ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# # Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# # Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
# RUN C:\TEMP\Install.cmd C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
#     --channelUri C:\TEMP\VisualStudio.chman `
#     --installChannelUri C:\TEMP\VisualStudio.chman `
#     --installPath C:\BuildTools `
#     --add Microsoft.VisualStudio.Workload.VCTools `
#     --add Microsoft.VisualStudio.Workload.MSBuildTools `    
#     --add Microsoft.VisualStudio.Component.Windows10SDK.19041 `
#     --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
#     --add Microsoft.VisualStudio.Component.VC.v141.x86.x64 `
#  || IF "%ERRORLEVEL%"=="3010" EXIT 0

# ADD https://dist.nuget.org/win-x86-commandline/latest/nuget.exe C:\BuildTools\Common7\Tools
# # ADD http://download.qt.io/official_releases/qt/5.12/5.12.9/qt-opensource-windows-x86-5.12.9.exe c:\temp\qt.exe

RUN SETX /M Path "%Path%;C:\\program files\\cmake\\bin;"
ENV QT5_BASE_DIR="c:\Qt\Qt5.12.9\5.12.9\msvc2017_64"
ENV WIRESHARK_BASE_DIR="C:\Development"
ENV WIRESHARK_LIB_DIR="c:\wireshark-win64-libs"


# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
# C:\BuildTools\vc\Auxiliary\Build
# ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\vc\\Auxiliary\\Build\\vcvars64.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]