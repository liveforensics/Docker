# escape=`

FROM mcr.microsoft.com/dotnet/framework/runtime:3.5-windowsservercore-1909

RUN mkdir c:\persist
RUN whoami

ADD takeownership.ps1 c:\persist\takeownership.ps1
ADD andback.ps1 c:\persist\andback.ps1

# RUN rmdir /S /Q c:\Persist

# ENTRYPOINT ["C:\\Program Files\\Microsoft SDKs\\Windows\\v7.1\\Bin\\SetEnv.cmd", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
