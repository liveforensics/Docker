# so i can copy openssh server later
Get-Acl C:\Windows\System32\OpenSSH
Get-Acl C:\persist | Set-Acl C:\Windows\System32\OpenSSH
Get-Acl C:\Windows\System32\OpenSSH
