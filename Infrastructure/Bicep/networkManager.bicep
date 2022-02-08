param networkManagerName string
param location string
param managementGroup string
param subscription string
param groupMembers array


resource networkManager 'Microsoft.Network/networkManagers@2021-02-01-preview' = {
  name: networkManagerName
  location: location
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  properties: {
    description: 'Matt-NetworkManager'
    displayName: networkManagerName
    networkManagerScopeAccesses: [ 
      'Connectivity' 
      'SecurityAdmin'
    ]
    networkManagerScopes: {
      managementGroups: [ 
        managementGroup 
      ]
      subscriptions: [
        subscription 
        ]
    }
  }
}



resource networkManagerNetworkGroup 'Microsoft.Network/networkManagers/networkGroups@2021-02-01-preview' = {
  name: networkManagerName
  parent: networkManager
  properties: {
    description: 'Network Manager'
    displayName: networkManagerName
    groupMembers: groupMembers
  }
}
