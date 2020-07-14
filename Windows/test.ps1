Clear-Host
Write-Host 'hello'



function Get-IsProcessRunning
{
    $result = Get-Process | Where-Object ProcessName -like '*sdksetup*'

    if($result)
    {
        return $true
    }
    else
    {
        return $false    
    }
}

$sdkList = @("sdksetup-8.1.exe", "winsdksetup-17134.exe", "winsdksetup-17763.exe", "winsdksetup-18362.exe", "winsdksetup-19041.exe")

Set-Location 'C:\Code'

foreach($sdk in $sdkList)
{
    Write-Host $sdk
    $arguments = '/Quiet /NoRestart /NoCache'
    & $sdk $arguments
    while(Get-IsProcessRunning )
    {
        Start-Sleep -Seconds 60
    }
}