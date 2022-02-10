$subscriptionID = 'bf378636-b0ba-4651-beab-a00a1bf2c984'
$artifactsStorageAccount = 'staisinfraavd'
$resourceGroupName = 'rg-infra-avd-management'


az login
az account set --subscription $subscriptionID


#Get SAS for Storage artificat

$artifactsStorageKey = az storage account keys list `
                       --account-name  $artifactsStorageAccount `
                       --query [0].value `
                       --output tsv

## Get SAS Key for the Storage Account 
$SasToken =                    az storage container generate-sas `
                            --account-name $artifactsStorageAccount `
                            --name 'avd-dsc' `
                            --account-key $artifactsStorageKey `
                            --permissions w `
                            --output tsv

    
$connectionString = az storage account show-connection-string `
                    --resource-group $resourceGroupName `
                     --name $artifactsStorageAccount `
                     --output tsv


#Change Location
Set-Location '.\Vm Deploy'

#Create zip archive for Deploy artifacts
Compress-Archive -Path .\Configuration\DeployAgent\* -DestinationPath .\Configuration\DeployAgent.zip -Force

#Remove Deploy Agent Folder
Remove-Item .\Configuration\DeployAgent\ -Force -Recurse

#Create zip archive for DSC artifacts
Compress-Archive -Path .\Configuration\* -DestinationPath .\Configuration.zip -Force


 ## upload artifacts to blob storage
 az storage blob upload `
    --name 'Configuration.zip' `
    --container-name 'avd-dsc' `
    --file 'Configuration.zip' `
    --account-name $artifactsStorageAccount `
    --connection-string $connectionString `
    --sas-token $SasToken

# Get SAS for dscArtifactsName
$date = (Get-Date).AddMinutes(90).ToString("yyyy-MM-dTH:mZ")
$date = $date.Replace(".",":")

$dscArtifactsLocation =     az storage blob generate-sas `
                            --account-name $artifactsStorageAccount `
                            --container-name 'avd-dsc' `
                            --name 'Configuration.zip' `
                            --account-key $artifactsStorageKey `
                            --permissions rw `
                            --expiry $date `
                            --full-uri `
                            --output tsv


write-host $dscArtifactsLocation