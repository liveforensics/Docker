Write-Host 'Installing Build Tools from local layout'
Set-Location 'c:\tools'
.\vs_buildtools.exe --quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.MSBuildTools --installPath C:\BuildTools

