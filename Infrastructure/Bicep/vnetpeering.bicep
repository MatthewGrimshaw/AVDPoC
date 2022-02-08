
param vnetResourceGroupName string
param vnetName string
param remoteVnetSubscriptionId string
param remoteVnetResourceGroupName string
param remoteVnetName string

resource remoteVirtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: remoteVnetName
  scope: resourceGroup(remoteVnetSubscriptionId, remoteVnetResourceGroupName)
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: vnetName
  scope: resourceGroup(vnetResourceGroupName)
}

resource virtualNetworkPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-02-01' = {
  name: '${remoteVnetName}/${remoteVnetName}_to_${virtualNetwork.name}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: virtualNetwork.id
    }
  }

  dependsOn: [
    remoteVirtualNetwork
  ]
}
