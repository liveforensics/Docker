# versions
$splunkVersion = "7.3.2"
$splunkGuid = "c60db69f8e32"

Write-Host "#################################################### Creating Slave Base #############################################################################"
Write-Host "Creating new folders.."
New-Item -ItemType Directory -Path c:\Jenkins
New-Item -ItemType Directory -Path c:\JenkinsRoot
New-Item -ItemType Directory -Path c:\SplunkForward
New-Item -ItemType Directory -Path c:\Temp

Write-Host "`nPulling Splunk Forwarder Version " $splunkVersion
Set-Location "c:\persist"
$downloadUrl = "https://download.splunk.com/products/universalforwarder/releases/$($splunkVersion)/windows/splunkforwarder-$($splunkVersion)-$($splunkGuid)-x64-release.msi"
Invoke-WebRequest -Uri $downloadUrl -OutFile c:\persist\splunk_installer.msi
if(Test-Path c:\persist\splunk_installer.msi)
{
    # $argumentList = "/i c:\persist\splunk_installer.msi AGREETOLICENSE=yes SPLUNKPASSWORD=P@ssw0rd PERFMON=diskspace,memory LAUNCHSPLUNK=0 /quiet"
    # Start-Process -FilePath 'c:\windows\system32\msiexec.exe' -ArgumentList $argumentList -PassThru -Wait
    c:\windows\system32\msiexec.exe /i c:\persist\splunk_installer.msi AGREETOLICENSE=yes SPLUNKPASSWORD=P@ssw0rd PERFMON=diskspace,memory LAUNCHSPLUNK=0 
    if(Test-Path 'C:\Program Files\SplunkUniversalForwarder\etc\system\local')
    {
        Copy-Item c:\persist\*.conf -Force -Destination 'C:\Program Files\SplunkUniversalForwarder\etc\system\local'
    }
}
else {
    Write-Error "Splunk Installer didn't download - $($downloadUrl)"
}

Write-Host "Installing chocolatey"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Now we'll install the git client using chocolatey
Write-Host "Installing git"
choco.exe install -y git

Write-Host "Installing Python 2"
choco.exe install -y python2
# Now we'll install Java
Write-Host "Installing Java"
choco.exe install jdk8 /exclude:32 -y

Write-Host "Creating a Jenkins User Account "

# Enable-LocalUser administrator
$secpasswd = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force
New-LocalUser 'Jenkins' -Password $secpasswd -FullName 'Jenkins Slave' -UserMayNotChangePassword -PasswordNeverExpires
Add-LocalGroupMember -Group 'Administrators' -Member 'Jenkins'

net user 'Jenkins' /passwordreq:yes

Get-LocalUser | Where-Object {$_.Name -eq 'Jenkins'} | Select-Object *

Write-Host "######################################################### Finished! ##################################################################################"
