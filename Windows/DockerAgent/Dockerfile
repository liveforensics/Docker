# escape=`

FROM mcr.microsoft.com/windows/nanoserver:2004-amd64
LABEL maintainer=liveforensics description="Windows Docker Agent"

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]



ENTRYPOINT ["cmd.exe"]