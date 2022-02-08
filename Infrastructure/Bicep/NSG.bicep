param nameprefix string
param nsgname string
param location string

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-03-01' = {
  name: '${nameprefix}-${nsgname}'
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}

output nsgResourceID string = nsg.id
