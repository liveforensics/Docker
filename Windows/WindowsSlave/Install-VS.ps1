Write-Host "Install Visual Studio Files"

Get-ChildItem -Recurse C:\Temp
Write-Host "Creating new folders.."
New-Item -ItemType Directory -Path c:\BuildTools

# choco install -y visualstudio2017-workload-vctools --params "--includeOptional"
# choco install -y visualstudio2017buildtools --package-parameters "--installPath C:\BuildTools --allWorkloads --includeRecommended --includeOptional --passive --locale en-US"

c:\temp\install.cmd c:\temp\vs_enterprise.exe --quiet --wait --norestart --nocache `
--channelUri C:\Temp\VisualStudio.chman `
--installChannelUri C:\Temp\VisualStudio.chman `
--installPath C:\BuildTools `
--add Microsoft.Component.MSBuild
# --add Microsoft.VisualStudio.Workload.NativeDesktop `
# --add Microsoft.VisualStudio.Workload.ManagedDesktop `
# --add Microsoft.VisualStudio.Workload.Universal `
# --add Microsoft.Net.Component.4.5.TargetingPack `
# --add Microsoft.Net.Component.4.5.1.TargetingPack `
# --add Microsoft.Net.Component.4.5.2.TargetingPack `
# --add Microsoft.Net.Component.3.5.DeveloperTools `
# --add Microsoft.Net.Component.4.6.TargetingPack `
# --add Microsoft.Net.Component.4.6.1.TargetingPack `
# --add Microsoft.Net.ComponentGroup.4.6.1.DeveloperTools `
# --add Microsoft.Net.Component.4.6.2.TargetingPack `
# --add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools `
# --add Microsoft.Net.Component.4.7.TargetingPack `
# --add Microsoft.Net.ComponentGroup.4.7.DeveloperTools `
# --add Microsoft.Net.Component.4.7.1.TargetingPack `
# --add Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools `
# --add Microsoft.Net.Component.4.7.2.TargetingPack `
# --add Microsoft.Net.Component.4.8.TargetingPack `
# --add Microsoft.Net.ComponentGroup.4.8.DeveloperTools `
# --add Microsoft.Net.Component.4.8.SDK `
# --add Microsoft.Net.Component.4.TargetingPack `
# --add Microsoft.Net.ComponentGroup.TargetingPacks.Common `
# --add Microsoft.Component.PythonTools `
# --add Microsoft.VisualStudio.Workload.Python `
# --add Component.CPython2.x64 `
# --add Microsoft.VisualStudio.Component.Windows81SDK `
# --add Microsoft.VisualStudio.Component.Windows10SDK `
# --add Microsoft.VisualStudio.Component.Windows10SDK.16299 `
# --add Microsoft.VisualStudio.Component.Windows10SDK.17134 `
# --add Microsoft.VisualStudio.Component.Windows10SDK.17763 `
# --add Microsoft.VisualStudio.Component.Windows10SDK.18362 `
# --add Microsoft.Net.Component.4.6.1.SDK `
# --add Microsoft.Net.Component.4.6.2.SDK `
# --add Microsoft.Net.Component.4.7.1.SDK `
# --add Microsoft.Net.Component.4.7.2.SDK `
# --add Microsoft.Net.Component.4.7.SDK `
# --add Microsoft.Net.Component.4.8.SDK `
# --add Microsoft.VisualStudio.Component.VC.140 `
# --add Microsoft.VisualStudio.Component.VC.v141.x86.x64 `
# --add Component.CPython3.x64 
