param nameprefix string
param location string
param vnetprefix string
param subnets array
param vnetname string

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: '${nameprefix}-${vnetname}'
  location: location
  properties: {
      addressSpace: {
          addressPrefixes: [
              vnetprefix
          ]
      }
      subnets: subnets
  }    
}

output subnetid string =  vnet.properties.subnets[0].id
output vnetname string = vnet.name
