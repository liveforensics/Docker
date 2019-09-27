# Dockerfile to build a Jenkins Windows Slave

# Indicates that the windowsservercore image will be used as the base image
# FROM microsoft/windowsservercore
# FROM liveforensics/jenkinswindowsslave:ent-1.0.0
FROM liveforensics/jenkinswindowsslave:1903-c

# Metadata indicating an image maintainer
MAINTAINER @liveforensics


RUN mkdir c:\\Persist
RUN mkdir c:\\SplunkForward
ADD https://download.splunk.com/products/universalforwarder/releases/7.2.1/windows/splunkforwarder-7.2.1-be11b2c46e23-x64-release.msi  c:\\persist\\splunk_installer.msi
ADD SplunkInstall.ps1 c:\\persist\\SplunkInstall.ps1
ADD Wait-Service.ps1 /Wait-Service.ps1
# 
RUN SETX /M Path "%Path%C:\Program Files\SplunkUniversalForwarder\bin\" 

ENV SPLUNK_HOST 'dockerdude.ukwest.cloudapp.azure.com'
ENV SPLUNK_PORT '10009'

RUN ["msiexec.exe", "/i", "c:\\persist\\splunk_installer.msi", "AGREETOLICENSE=yes", "SPLUNKPASSWORD=P@ssw0rd", "PERFMON=diskspace,memory", "LAUNCHSPLUNK=0", "/quiet"]

# RUN PowerShell.exe -Command '$file = "C:\Program Files\SplunkUniversalForwarder\etc\system\local\inputs.conf"; Add-Content $file "`n[batch:c:\SplunkForward]`n"'

RUN powershell.exe -file c:\\persist\\SplunkInstall.ps1

RUN rmdir /S /Q c:\\Persist




 




