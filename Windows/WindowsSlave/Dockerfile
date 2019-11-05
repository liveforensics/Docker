# escape=`

# FROM mcr.microsoft.com/windows/servercore:ltsc2019
FROM liveforensics/slavebase:1.0.0
LABEL maintainer=liveforensics description="Windows Jenkins Windows Build Slave"

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\\Downloads\\vs_buildtools.exe
ADD https://dist.nuget.org/win-x86-commandline/latest/nuget.exe C:\\Nuget\\nuget.exe

RUN C:\\Downloads\\vs_buildtools.exe `
    --add Microsoft.VisualStudio.Workload.MSBuildTools `
    --add Microsoft.VisualStudio.Workload.NativeDesktop `
    --add Microsoft.VisualStudio.Workload.ManagedDesktop `
    --add Microsoft.VisualStudio.Workload.Universal `
    --add Microsoft.Net.Component.4.5.TargetingPack `
    --add Microsoft.Net.Component.4.5.1.TargetingPack `
    --add Microsoft.Net.Component.4.5.2.TargetingPack `
    --add Microsoft.Net.Component.3.5.DeveloperTools `
    --add Microsoft.Net.Component.4.6.TargetingPack `
    --add Microsoft.Net.Component.4.6.1.TargetingPack `
    --add Microsoft.Net.ComponentGroup.4.6.1.DeveloperTools `
    --add Microsoft.Net.Component.4.6.2.TargetingPack `
    --add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools `
    --add Microsoft.Net.Component.4.7.TargetingPack `
    --add Microsoft.Net.ComponentGroup.4.7.DeveloperTools `
    --add Microsoft.Net.Component.4.7.1.TargetingPack `
    --add Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools `
    --add Microsoft.Net.Component.4.7.2.TargetingPack `
    --add Microsoft.Net.Component.4.8.TargetingPack `
    --add Microsoft.Net.ComponentGroup.4.8.DeveloperTools `
    --add Microsoft.Net.Component.4.8.SDK `
    --add Microsoft.Net.Component.4.TargetingPack `
    --add Microsoft.Net.ComponentGroup.TargetingPacks.Common `
    --add Microsoft.VisualStudio.Component.VC.140 `
    --add Microsoft.VisualStudio.Component.VC.v141.x86.x64 `
    --add Microsoft.Net.Component.4.6.1.SDK `
    --add Microsoft.Net.Component.4.6.2.SDK `
    --add Microsoft.Net.Component.4.7.1.SDK `
    --add Microsoft.Net.Component.4.7.2.SDK `
    --add Microsoft.Net.Component.4.7.SDK `
    --add Microsoft.Net.Component.4.8.SDK `
    --add Microsoft.VisualStudio.Component.Windows81SDK `
    --add Microsoft.VisualStudio.Component.Windows10SDK `
    --add Microsoft.VisualStudio.Component.Windows10SDK.16299 `
    --add Microsoft.VisualStudio.Component.Windows10SDK.17134 `
    --add Microsoft.VisualStudio.Component.Windows10SDK.17763 `
    --add Microsoft.VisualStudio.Component.Windows10SDK.18362 `
    --add Microsoft.VisualStudio.Workload.NetCoreBuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Workload.WebBuildTools `
    --add Microsoft.Component.PythonTools `
    --add Microsoft.VisualStudio.Workload.Python `
    --add Component.CPython3.x64 `
    --add Component.Dotfuscator `
    --quiet --wait
RUN SETX /M Path "%Path%;C:\\Nuget;C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\BuildTools\\MSBuild\\15.0\\Bin"

