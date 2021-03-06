Write-Host "#################################################### Creating Build Base #############################################################################"
Write-Host "Creating new folders.."
New-Item -ItemType Directory -Path c:\Jenkins
New-Item -ItemType Directory -Path c:\JenkinsRoot

Write-Host "Installing chocolatey"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Now we'll install the git client using chocolatey
Write-Host "Installing git"
choco.exe install -y git

Write-Host "Installing Python 2"
choco.exe install -y python2
# Now we'll install Java
Write-Host "Installing git"
choco.exe install jdk8 /exclude:32 -y

Write-Host "Creating a Jenkins User Account "

# Enable-LocalUser administrator
$secpasswd = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force
New-LocalUser 'Jenkins' -Password $secpasswd -FullName 'Jenkins Slave' -UserMayNotChangePassword -PasswordNeverExpires
Add-LocalGroupMember -Group 'Administrators' -Member 'Jenkins'

net user 'Jenkins' /passwordreq:yes

Get-LocalUser | Where-Object {$_.Name -eq 'Jenkins'} | Select-Object *

Write-Host "######################################################### Finished! ##################################################################################"