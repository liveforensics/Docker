Write-Host "Creating a Jenkins User Account "

# Enable-LocalUser administrator
$secpasswd = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force
New-LocalUser 'Jenkins' -Password $secpasswd -FullName 'Jenkins Slave' -AccountNeverExpires -PasswordNeverExpires
Add-LocalGroupMember -Group 'Administrators' -Member 'Jenkins'
# Set-LocalUser 'Jenkins' -Password $secpasswd -AccountNeverExpires -PasswordNeverExpires $true

Write-Host "Finished"
