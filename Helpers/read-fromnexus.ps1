$URL = "http://dockerhost01:8081/repository/jenkins/Forensic-Explorer/Log-Service/latest/Log-Service-latest.dll"
$HASHURL = "http://dockerhost01:8081/repository/jenkins/Forensic-Explorer/Log-Service/latest/Log-Service-latest.dll.sha1"

$apiKey = "3e10f7f1-8102-381a-ba46-ced9f7d24c86"

$apiKeyBytes = [System.Text.Encoding]::UTF8.GetBytes($apiKey)
$apiKeyEncoded = [System.Convert]::ToBase64String($apiKeyBytes)

Invoke-WebRequest $url -Headers @{Authorization = "apikey $apiKeyEncoded"} -MaximumRedirection 0 -OutFile "Log-Service-latest.dll"
Invoke-WebRequest $HASHURL -Headers @{Authorization = "apikey $apiKeyEncoded"} -MaximumRedirection 0 -OutFile "Log-Service-latest.dll.sha1"

$calHash = Get-FileHash -Algorithm SHA1 "Log-Service-latest.dll"
$readHash = Get-Content "Log-Service-latest.dll.sha1"

if($calHash.Hash -eq $readHash)
{
    Write-Host "Hash matched"
}
else 
{
   Write-Error "Hash failed"
}
