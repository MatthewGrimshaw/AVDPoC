param nameprefix string
param kvname string
param location string
param objectID string
param tenantID string

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name:'${nameprefix}-${kvname}'
  location: location
  properties: {
    accessPolicies: [
      {
        objectId: objectID
        permissions: {
          certificates: [
            'all'
          ]
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
        }
        tenantId: tenantID
      }
    ]
    createMode: 'default'
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enablePurgeProtection: true
    enableRbacAuthorization: true
    enableSoftDelete: true
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: tenantID
  }
}
