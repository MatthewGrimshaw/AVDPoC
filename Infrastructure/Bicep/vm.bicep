
param nameprefix string
param location string
param subnetid string
param vmname string
param vmSize string
@secure()
param windowsAdminUsername string
param windowsAdminPassword string



resource nic 'Microsoft.Network/networkInterfaces@2021-03-01' = {
  name : '${nameprefix}${vmname}nic'
  location: location
  properties: {
      ipConfigurations: [
          {
              name: '${nameprefix}${vmname}nicconfig'
              properties: {
                  subnet: {
                      id: subnetid
                  }
              }
          }
      ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name : '${nameprefix}-${vmname}'
  location: location
  properties: {
      hardwareProfile: {
          vmSize: vmSize
      }
      storageProfile: {
        osDisk: {
          name: '${nameprefix}-${vmname}OsDisk'
          caching: 'ReadWrite'
          createOption: 'FromImage'
          diskSizeGB: 1024
        }
        imageReference: {
          publisher: 'MicrosoftWindowsServer'
          offer: 'WindowsServer'
          sku: '2019-Datacenter'
          version: 'latest'
        }
      }
      networkProfile: {
        networkInterfaces: [
          {
            id: nic.id
          }
        ]
      }
      osProfile: {
        computerName: '${nameprefix}-${vmname}'
        adminUsername: windowsAdminUsername
        adminPassword: windowsAdminPassword
        windowsConfiguration: {
          provisionVMAgent: true
          enableAutomaticUpdates: false
        }
      }
    }
}
