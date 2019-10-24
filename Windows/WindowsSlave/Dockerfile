# escape=`


FROM liveforensics/slavebase:1.0.0

# Reset the shell.
SHELL ["cmd", "/S", "/C"]

RUN mkdir c:\Persist
COPY Install-VS.ps1 c:\persist\Install-VS.ps1
COPY Install.cmd c:\temp\install.cmd

RUN powershell.exe -file c:\persist\Install-VS.ps1

RUN rmdir /S /Q c:\Persist