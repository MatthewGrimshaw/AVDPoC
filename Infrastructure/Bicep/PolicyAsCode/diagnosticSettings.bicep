targetScope = 'subscription'

param location string
param assignmentEnforcementMode string
param logAnalytics string

var policySetName = 'Matt-ConfigureDiagnosticsSettings'
var policySetDisplayName = 'Configure Diagnostic Settings'
var policySetDescription = 'Ensure Diagnostics settings are configured to send to Log Analytics'

var policyDefinitionForKeyVaultDiagnosticsID = '/providers/Microsoft.Authorization/policyDefinitions/951af2fa-529b-416e-ab6e-066fd85ac459'
var policyDefinitionForStorageAccountsDiagnosticsID = '/providers/Microsoft.Authorization/policyDefinitions/6f8f98a4-f108-47cb-8e98-91a0d85cd474'
var policyDefinitionForNetworkSecurityGroupsDiagnosticsID = '/providers/Microsoft.Authorization/policyDefinitions/98a2e215-5382-489e-bd29-32e7190a39ba'
var policyDefinitionForAzureKubernetesServiceDiagnosticsID = '/providers/Microsoft.Authorization/policyDefinitions/6c66c325-74c8-42fd-a286-a74b0e2939d8'
var policyDefinitionForAzureActivityLogsDiagnosticsID = '/providers/Microsoft.Authorization/policyDefinitions/2465583e-4e78-4c15-b6be-a36cbc7c8b0f'
var policyDefinitionForAzureRecoveryVaultDiagnosticsID = '/providers/Microsoft.Authorization/policyDefinitions/c717fb0c-d118-4c43-ab3d-ece30ac81fb3'

var policyAssignmentDisplayName = 'Matt-ConfigureDiagnosticSettings-Assignment'

// Defining the existing policies to reference in the policy set definition
resource policyDefinitionForKeyVaultDiagnostics 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'Deploy - Configure diagnostic settings for Azure Key Vault to Log Analytics workspace'
}

resource policyDefinitionForStorageAccountsDiagnostics 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'Configure diagnostic settings for storage accounts to Log Analytics workspace'
}

resource policyDefinitionForNetworkSecurityGroupsDiagnostics 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'Configure diagnostic settings for Azure Network Security Groups to Log Analytics workspace'
}

resource policyDefinitionForAzureKubenertesServiceDiagnostics 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'Deploy - Configure diagnostic settings for Azure Kubernetes Service to Log Analytics workspace'
}

resource policyDefinitionForAzureActivityLogsDiagnostics 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'Configure Azure Activity logs to stream to specified Log Analytics workspace'
}

resource policyDefinitionForAzureRecoveryVaultDiagnostics 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'Deploy Diagnostic Settings for Recovery Services Vault to Log Analytics workspace for resource specific categories'
}

// Policy set definition aka policy initiative
resource policyInitiative 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: policySetName
  properties: {
    displayName: policySetDisplayName
    description: policySetDescription
    policyType: 'Custom'
   
    parameters: {
      logAnalytics: {
        type: 'String'
        metadata: {
          displayName: 'Log Analytics workspace'
          description: 'Specify the Log Analytics workspace the Key Vault should be connected to.'
          strongType: 'omsWorkspace'
          assignPermissions: true
        }
      }
  }

    policyDefinitions: [
      {
        policyDefinitionId: policyDefinitionForKeyVaultDiagnosticsID
        policyDefinitionReferenceId: policyDefinitionForKeyVaultDiagnostics.name
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
      }
      {
        policyDefinitionId: policyDefinitionForStorageAccountsDiagnosticsID
        policyDefinitionReferenceId: policyDefinitionForStorageAccountsDiagnostics.name
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
      }
      {
        policyDefinitionId: policyDefinitionForNetworkSecurityGroupsDiagnosticsID
        policyDefinitionReferenceId: policyDefinitionForNetworkSecurityGroupsDiagnostics.name
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
      }
      {
        policyDefinitionId: policyDefinitionForAzureKubernetesServiceDiagnosticsID
        policyDefinitionReferenceId: policyDefinitionForAzureKubenertesServiceDiagnostics.name
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
      }
      {
        policyDefinitionId: policyDefinitionForAzureActivityLogsDiagnosticsID
        policyDefinitionReferenceId: policyDefinitionForAzureActivityLogsDiagnostics.name
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
      }
      {
        policyDefinitionId: policyDefinitionForAzureRecoveryVaultDiagnosticsID
        policyDefinitionReferenceId: policyDefinitionForAzureRecoveryVaultDiagnostics.name
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
      }
    ]
  }
}


resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: policyAssignmentDisplayName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties:{
    displayName: policySetDescription
    description: policySetDescription
    enforcementMode: assignmentEnforcementMode
    policyDefinitionId: policyInitiative.id
    parameters: {
      logAnalytics: {
        value: logAnalytics
      }
    }
  }
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(policyAssignment.name, policyAssignment.type, subscription().subscriptionId)
  properties: {
    principalId: policyAssignment.identity.principalId
    roleDefinitionId: '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // contributor RBAC role for deployIfNotExists effect
  }
}
