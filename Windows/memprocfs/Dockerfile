# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2019
LABEL maintainer=liveforensics description="memProcFS Builder"

# Restore the default Windows shell for correct batch processing.
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN mkdir c:\temp
ADD build.ps1 c:\temp\build.ps1
ADD https://github.com/ufrisk/MemProcFS/releases/download/v5.0/MemProcFS_files_and_binaries_v5.0.2-win_x64-20220816.zip c:\temp\memproc.zip
ADD https://github.com/dokan-dev/dokany/releases/download/v2.0.5.1000/Dokan_x64.msi c:\temp\Dokan_x64.msi



RUN c:\temp\build.ps1

ENTRYPOINT ["powershell.exe"]