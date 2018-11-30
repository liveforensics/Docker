Write-Host "Creating a Jenkins User Account "

# Enable-LocalUser administrator
$secpasswd = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force
New-LocalUser 'Jenkins' -Password $secpasswd -FullName 'Jenkins Slave' -UserMayNotChangePassword -PasswordNeverExpires
Add-LocalGroupMember -Group 'Administrators' -Member 'Jenkins'

net user 'Jenkins' /passwordreq:yes

Get-LocalUser | Where-Object {$_.Name -eq 'Jenkins'} | Select-Object *

Write-Host "Finished"
