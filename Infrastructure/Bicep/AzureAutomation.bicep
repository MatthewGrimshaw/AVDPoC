param nameprefix string
param aaname string
param location string
param laname string

//create automation account
resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: '${nameprefix}-${aaname}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    
    sku: {
      name: 'Basic'
    }
  }
}

//get reference to existing LA Workspace
resource LogAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' existing = {
  name: '${nameprefix}-${laname}'
}

//create linked service to Log Analytics
resource linkedService 'Microsoft.OperationalInsights/workspaces/linkedServices@2020-08-01' = {
  name: '${nameprefix}-${laname}/Automation'
  properties: {
    resourceId: automationAccount.id
  }
}

