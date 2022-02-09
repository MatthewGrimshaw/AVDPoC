Param(
  [string]$rgName,
  [string]$vmName
)

$user = "ofe"
$token = "5kx6tvxfbd6xzlbij3gplrbh2yzvf3whiplzde4ywzhucq7xzeaq"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $token)))

$url = "https://dev.azure.com/skat-devops/0ef20fa4-8d91-4ec4-812c-650e36e2601b/_apis/build/builds?api-version=6.0&definitions=171&queryOrder=startTimeDescending&statusFilter=all"
$response = Invoke-RestMethod -Method Get -UseDefaultCredentials -ContentType application/json -Uri $url -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo) }

$buildId = $response.value[0].id

$body = @"
  {
    "buildNumber": "RG- $($rgName), VM- $($vmName), "
  }
"@

$bodyJson = $body | ConvertFrom-Json
$bodyString = $bodyJson | ConvertTo-Json -Depth 100

$url = "https://dev.azure.com/skat-devops/0ef20fa4-8d91-4ec4-812c-650e36e2601b/_apis/build/builds/$($buildId)?api-version=6.0"
$response = Invoke-RestMethod -Method Patch -UseDefaultCredentials -ContentType application/json -Uri $url -Body $bodyString -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo) }
$response
