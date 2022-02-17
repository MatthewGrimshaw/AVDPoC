# KMS activate Windows
cscript C:\Windows\System32\slmgr.vbs /skms kms.core.windows.net:1688
cscript C:\Windows\System32\slmgr.vbs /ato

# Set Locale, language etc.
Invoke-WebRequest -Uri https://staiacscript.blob.core.windows.net/regional-settings/DKRegion.xml -OutFile C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\DKregion.xml -Verbose
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\DKregion.xml`""
 
#Set time zone and culture
Set-TimeZone -Id "Romance Standard Time" -Verbose
Set-Culture da-DK

# Install sccm client
$ccmshare = "\\sccm01.ccta.dk\ccmclient"
$ccmfoldername = "C:\Temp\ccmclient"
$ccmfilename = "ccmsetup.exe"
$ccminstallpath = "$ccmfoldername" + "\" + "$ccmfilename"

Copy-Item -Path $ccmshare -Recurse -Destination $ccmfoldername
Invoke-Command -ScriptBlock {Start-Process -FilePath $ccminstallpath -ArgumentList "SMSSITECODE=PRI", "SMSMP=sccm01.ccta.dk", "FSP=sccm01.ccta.dk", "/mp:sccm01.ccta.dk", "/NOCRLCheck" -Wait}

Do {
$loopcount +=30
Write-Host "Waiting for install to complete $loopcount seconds"
Start-Sleep -Seconds $loopcount
$test = Get-Process -Name ccmsetup -ErrorAction SilentlyContinue
} Until ($test.Name -notcontains "ccmsetup")

Get-ChildItem -Path $ccmfoldername -Recurse | Remove-Item -Force -Recurse
Remove-Item $ccmfoldername -Force -Recurse

#Script to setup install software on Azure VM

#Create temp folder
New-Item -Path 'C:\temp' -ItemType Directory -Force | Out-Null

#Install VSCode - use choclately instead
#Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?Linkid=852157' -OutFile 'c:\temp\VScode.exe'
#Invoke-Expression -Command 'c:\temp\VScode.exe /verysilent'

#InstallFSLogix
Invoke-WebRequest -Uri 'https://aka.ms/fslogix_download' -OutFile 'c:\temp\fslogix.zip'
Start-Sleep -Seconds 10
Expand-Archive -Path 'C:\temp\fslogix.zip' -DestinationPath 'C:\temp\fslogix\'  -Force
Invoke-Expression -Command 'C:\temp\fslogix\x64\Release\FSLogixAppsSetup.exe /install /quiet /norestart'

#Start sleep
Start-Sleep -Seconds 10

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

### add git location to env path    
if (($env:Path.Split(';') -contains "C:\Program Files\Git\bin") -eq $false) {
    $env:Path += ";C:\Program Files\Git\bin";
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine );
}

# Fiddler
choco install fiddler -y
# Postman
choco install postman -y
#Putty
choco install putty.install -y
#Notepad++
choco install notepadplusplus -y
#VS Code
choco install visualstudiocode -y
#Node Js
choco install nodejs.install --global -y
#SQL Server
choco install sql-server-management-studio -y
#VisualStudio
choco install visualstudio2019community -y
#resharper
choco install resharper -y
