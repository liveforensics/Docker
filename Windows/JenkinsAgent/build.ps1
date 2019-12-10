# versions

Write-Host "#################################################### Creating Slave Base #############################################################################"
Write-Host "Creating new folders.."
New-Item -ItemType Directory -Path c:\Jenkins
New-Item -ItemType Directory -Path c:\JenkinsRoot
New-Item -ItemType Directory -Path c:\Temp

Write-Host "Installing chocolatey"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


# Now we'll install Java
Write-Host "Installing java"
choco.exe install jdk8 /exclude:32 -y

# Now we'll install Git
Write-Host "Installing Git"
choco.exe install -y git

Write-Host "Creating a Jenkins User Account "

# Enable-LocalUser administrator
$secpasswd = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force
New-LocalUser 'Jenkins' -Password $secpasswd -FullName 'Jenkins Slave' -UserMayNotChangePassword -PasswordNeverExpires
Add-LocalGroupMember -Group 'Administrators' -Member 'Jenkins'

net user 'Jenkins' /passwordreq:yes

Get-LocalUser | Where-Object {$_.Name -eq 'Jenkins'} | Select-Object *

# now install docker
Write-Host "Installing docker cli"
choco install docker -y

Write-Host "######################################################### Finished! ##################################################################################"
