targetScope = 'subscription'

param AVDResourceGroup string
param AVDSubscriptionID string
param remoteSubscriptionID string

@description('Specifies the Azure location where the resource should be created.')
param nameprefix string = 'we'
param location string = 'westeurope'
param vnetname string = 'avdhosts'
param vnetprefix string = '10.80.0.0/24'
param nsgname string = 'defaultNSG'
param hubVnetName string = 'Matt-VPNGatewayVnet'
param hubVnetResourceGroupName string = 'VPNGateway'


module nsg '../../Infrastructure/Bicep/NSG.bicep' = {
  name: 'Matt-NSG.deployment'
  scope: resourceGroup(AVDResourceGroup)
  params:{
    nameprefix: nameprefix
    location: location
    nsgname: nsgname
  }
}

var subnets = [
  {
    name: '${nameprefix}-${vnetname}-subnet1'
    properties:{
      addressPrefix: '10.80.0.0/26'      
      networkSecurityGroup: {
      id: nsg.outputs.nsgResourceID
      }
    }  
  }
  {
    name: '${nameprefix}-${vnetname}-subnet2'
    properties:{
      addressPrefix: '10.80.0.64/26'
      networkSecurityGroup: {
        id: nsg.outputs.nsgResourceID
        }
    }
  }
  
]

module vnet '../../Infrastructure/Bicep/vnet.bicep' = {
  name: 'Matt-iavdhosts-deployment'
  scope: resourceGroup(AVDResourceGroup)
  params:{
    nameprefix: nameprefix
    location: location
    vnetprefix: vnetprefix
    subnets: subnets
    vnetname: vnetname
  }
}

module vnetPeerings1 '../../Infrastructure/Bicep/vnetpeering.bicep' = {
  name: 'Matt-VnetPeerings1-deployment'
  scope: resourceGroup(hubVnetResourceGroupName)
  params: {
    vnetResourceGroupName: AVDResourceGroup
    vnetName: vnet.outputs.vnetname
    remoteVnetSubscriptionId: remoteSubscriptionID 
    remoteVnetResourceGroupName: hubVnetResourceGroupName
    remoteVnetName: hubVnetName
  }
}

module vnetPeerings2 '../../Infrastructure/Bicep/vnetpeering.bicep' = {
  name: 'Matt-VnetPeerings2-deployment'
  scope: resourceGroup(AVDResourceGroup)
  params: {
    vnetResourceGroupName: hubVnetResourceGroupName 
    vnetName:  hubVnetName
    remoteVnetSubscriptionId: AVDSubscriptionID 
    remoteVnetResourceGroupName: AVDResourceGroup
    remoteVnetName: vnet.outputs.vnetname
  }
}
