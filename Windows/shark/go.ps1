$startTime = Get-Date

Write-Host "Running CMake"
cmake -G "Visual Studio 16 2019" -A x64 ..\wireshark

Write-Host "Cleaning"
msbuild /m /p:Configuration=RelWithDebInfo Wireshark.sln /t:Clean

Write-Host "Building Wireshark"
msbuild /m /p:Configuration=RelWithDebInfo Wireshark.sln

if(Test-Path 'C:\Development\wsbuild64\run\RelWithDebInfo\Wireshark.exe')
{
    Write-Host "Success"
}
else 
{
    Write-Error "Failed to build Wireshark"
}

$endTime = Get-Date

$diff = New-TimeSpan -Start $startTime -End $endTime

Write-Host "Build took: " $diff.TotalMinutes " minutes"