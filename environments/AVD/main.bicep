targetScope = 'subscription'

param AVDResourceGroup string = 'rg-infra-avd-management-plane'


param location string = 'westeurope'

@description('Expiration time for the HostPool registration token. This must be up to 30 days from todays date.')
param baseTime string = utcNow('u')
param tokenExpirationTime string = dateTimeAdd(baseTime, 'P9D')

@description('If true Host Pool, App Group and Workspace will be created. Default is to join Session Hosts to existing AVD environment')
param newBuild bool = true

@allowed([
  'Personal'
  'Pooled'
])
param hostPoolType string = 'Pooled'
param hostPoolName string = 'Light-HostPool'

@allowed([
  'Automatic'
  'Direct'
])
param personalDesktopAssignmentType string = 'Automatic'
param maxSessionLimit int = 12


@allowed([
  'BreadthFirst'
  'DepthFirst'
  'Persistent'
])
param loadBalancerType string = 'BreadthFirst'

@description('Custom RDP properties to be applied to the AVD Host Pool.')
param customRdpProperty string = 'audiocapturemode:i:1;camerastoredirect:s:*;audiomode:i:0;drivestoredirect:s:;redirectclipboard:i:1;redirectcomports:i:0;redirectprinters:i:1;redirectsmartcards:i:1;screen mode id:i:2;devicestoredirect:s:*'

@description('Friendly Name of the Host Pool, this is visible via the AVD client')
param hostPoolFriendlyName string = 'Light-HostPool'

@description('Name of the AVD Workspace to used for this deployment')
param workspaceName string = 'Light-Workspace'
param appGroupFriendlyName string = 'Light-AppGroup'

module backPlaneLight '../../Infrastructure/Bicep/AVDManagementPlane.bicep' = {
  name: 'backPlaneLight'
  scope: resourceGroup(AVDResourceGroup)
  params: {
    location: location
    workspaceLocation: location
    hostPoolName: hostPoolName
    hostPoolFriendlyName: hostPoolFriendlyName
    hostPoolType: hostPoolType
    appGroupFriendlyName: appGroupFriendlyName
    loadBalancerType: loadBalancerType
    workspaceName: workspaceName
    personalDesktopAssignmentType: personalDesktopAssignmentType
    customRdpProperty: customRdpProperty
    tokenExpirationTime: tokenExpirationTime
    maxSessionLimit: maxSessionLimit
    newBuild: newBuild
  }
}

param hostPoolNameMedium string = 'Medium-HostPool'
param hostPoolFriendlyNameMedium string = 'Medium-HostPool'
param appGroupFriendlyNameMedium string = 'Medium-AppGroup'


module backPlaneMedium '../../Infrastructure/Bicep/AVDManagementPlane.bicep' = {
  name: 'backPlaneMedium'
  scope: resourceGroup(AVDResourceGroup)
  params: {
    location: location
    workspaceLocation: location
    hostPoolName: hostPoolNameMedium
    hostPoolFriendlyName: hostPoolFriendlyNameMedium
    hostPoolType: hostPoolType
    appGroupFriendlyName: appGroupFriendlyNameMedium
    loadBalancerType: loadBalancerType
    workspaceName: workspaceName
    personalDesktopAssignmentType: personalDesktopAssignmentType
    customRdpProperty: customRdpProperty
    tokenExpirationTime: tokenExpirationTime
    maxSessionLimit: maxSessionLimit
    newBuild: newBuild
  }
}


param hostPoolNameHeavy string = 'Heavy-HostPool'
param hostPoolFriendlyNameHeavy string = 'Heavy-HostPool'
param appGroupFriendlyNameHeavy string = 'Heavy-AppGroup'
param loadbalancerTypeHeavy string = 'Persistent'
param hostPoolTypeHeavy string = 'Personal'

module backPlaneHeavy '../../Infrastructure/Bicep/AVDManagementPlane.bicep' = {
  name: 'backPlaneHeavy'
  scope: resourceGroup(AVDResourceGroup)
  params: {
    location: location
    workspaceLocation: location
    hostPoolName: hostPoolNameHeavy
    hostPoolFriendlyName: hostPoolFriendlyNameHeavy
    hostPoolType: hostPoolTypeHeavy
    appGroupFriendlyName: appGroupFriendlyNameHeavy
    loadBalancerType: loadbalancerTypeHeavy
    workspaceName: workspaceName
    personalDesktopAssignmentType: personalDesktopAssignmentType
    customRdpProperty: customRdpProperty
    tokenExpirationTime: tokenExpirationTime
    maxSessionLimit: maxSessionLimit
    newBuild: newBuild
  }
}
