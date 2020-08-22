Get-Service | Where-Object Name -like '*ssh*'
New-Service -Name sshd -BinaryPathName C:\Windows\System32\OpenSSH\sshd.exe -Description "OpenSSH SSH Server"
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
Get-Service | Where-Object Name -like '*ssh*'


