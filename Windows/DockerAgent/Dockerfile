# escape=`

FROM mcr.microsoft.com/windows/servercore:2004-amd64
LABEL maintainer=liveforensics description="Windows Docker Agent"

# Restore the default Windows shell for correct batch processing.
# SHELL ["cmd", "/S", "/C"]
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force; `
    Install-Module -Name DockerMsftProvider -Repository PSGallery -Force; `
    Install-Package -Name docker -ProviderName DockerMsftProvider

ENTRYPOINT ["powershell.exe"]
