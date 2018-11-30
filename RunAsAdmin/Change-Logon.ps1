Write-Host "Creating a Jenkins User Account and getting it to run the jenkins service"

# Enable-LocalUser administrator
$secpasswd = ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force
New-LocalUser 'Jenkins' -Password $secpasswd -FullName 'Jenkins Slave'
Add-LocalGroupMember -Group 'Administrators' -Member 'Jenkins'
# Set-LocalUser 'Jenkins' -Password $secpasswd -AccountNeverExpires -PasswordNeverExpires $true
Write-Host "Creating Account"
$tempPath = [System.IO.Path]::GetTempPath()
$import = Join-Path -Path $tempPath -ChildPath "import.inf"
if(Test-Path $import) { Remove-Item -Path $import -Force }
$export = Join-Path -Path $tempPath -ChildPath "export.inf"
if(Test-Path $export) { Remove-Item -Path $export -Force }
$secedt = Join-Path -Path $tempPath -ChildPath "secedt.sdb"
if(Test-Path $secedt) { Remove-Item -Path $secedt -Force }
try
{
    Write-Host "Granting SeServiceLogonRight to Jenkins account"
    $sid = ((New-Object System.Security.Principal.NTAccount('\Jenkins')).Translate([System.Security.Principal.SecurityIdentifier])).Value
    Write-Host "1-" $sid
    secedit /export /cfg $export
    Write-Host "2"
    $sids = (Select-String $export -Pattern "SeServiceLogonRight").Line
    Write-Host "3"
    foreach ($line in @("[Unicode]", "Unicode=yes", "[System Access]", "[Event Audit]", "[Registry Values]", "[Version]", "signature=`"`$CHICAGO$`"", "Revision=1", "[Profile Description]", "Description=GrantLogOnAsAService security template", "[Privilege Rights]", "SeServiceLogonRight = *$sids,*$sid"))
    {
        $line
        Add-Content $import $line
    }
    Write-Host "4"
    secedit /import /db $secedt /cfg $import
    Write-Host "5"
    secedit /configure /db $secedt
    Write-Host "6"
    # gpupdate /force
    Write-Host "7"
    # Remove-Item -Path $import -Force
    # Remove-Item -Path $export -Force
    # Remove-Item -Path $secedt -Force
}
catch 
{
    Write-Host "Failed to grant SeServiceLogonRight to Administrator"
}
Write-Host "Finished"
