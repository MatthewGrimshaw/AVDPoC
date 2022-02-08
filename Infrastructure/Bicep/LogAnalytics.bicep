param nameprefix string
param laname string
param location string
param retentionInDays int
param capacityReservation int
param workspaceCapping int


resource LogAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: '${nameprefix}-${laname}'
  location: location
  properties: {
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    forceCmkForQuery: false
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: retentionInDays
    sku: {
      capacityReservationLevel: capacityReservation
      name: 'CapacityReservation'
    }
    workspaceCapping: {
      dailyQuotaGb: workspaceCapping
    }
  }
}

resource logAnalyticsWorkspaceDiagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
  scope: LogAnalytics
  name: 'diagnosticSettings'
  properties: {
    workspaceId: LogAnalytics.id
    logs: [
      {
        category: 'Audit'
        enabled: true
        retentionPolicy: {
          days: 7
          enabled: true
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 7
          enabled: true
        }
      }
    ]
  }
}

resource workspaceName_perfcounter1 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter1'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'LogicalDisk'
    instanceName: 'C:'
    intervalSeconds: 60
    counterName: '% Free Space'
  }
}

resource workspaceName_perfcounter2 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter2'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'LogicalDisk'
    instanceName: 'C:'
    intervalSeconds: 30
    counterName: 'Avg. Disk Queue Length'
  }
}

resource workspaceName_perfcounter3 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter3'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'LogicalDisk'
    instanceName: 'C:'
    intervalSeconds: 60
    counterName: 'Avg. Disk sec/Transfer'
  }
}

resource workspaceName_perfcounter4 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter4'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'LogicalDisk'
    instanceName: 'C:'
    intervalSeconds: 30
    counterName: 'Current Disk Queue Length'
  }
}

resource workspaceName_perfcounter5 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter5'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'Memory'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Available Mbytes'
  }
}

resource workspaceName_perfcounter6 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter6'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'Memory'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Page Faults/sec'
  }
}

resource workspaceName_perfcounter7 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter7'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'Memory'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Pages/sec'
  }
}

resource workspaceName_perfcounter8 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter8'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'Memory'
    instanceName: '*'
    intervalSeconds: 30
    counterName: '% Committed Bytes In Use'
  }
}

resource workspaceName_perfcounter9 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter9'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'PhysicalDisk'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Avg. Disk Queue Length'
  }
}

resource workspaceName_perfcounter10 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter10'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'PhysicalDisk'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Avg. Disk sec/Read'
  }
}

resource workspaceName_perfcounter11 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter11'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'PhysicalDisk'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Avg. Disk sec/Transfer'
  }
}

resource workspaceName_perfcounter12 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter12'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'PhysicalDisk'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Avg. Disk sec/Write'
  }
}

resource workspaceName_perfcounter18 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter18'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'Processor Information'
    instanceName: '_Total'
    intervalSeconds: 30
    counterName: '% Processor Time'
  }
}

resource workspaceName_perfcounter19 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter19'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'Terminal Services'
    instanceName: '*'
    intervalSeconds: 60
    counterName: 'Active Sessions'
  }
}

resource workspaceName_perfcounter20 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter20'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'Terminal Services'
    instanceName: '*'
    intervalSeconds: 60
    counterName: 'Inactive Sessions'
  }
}

resource workspaceName_perfcounter21 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter21'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'Terminal Services'
    instanceName: '*'
    intervalSeconds: 60
    counterName: 'Total Sessions'
  }
}

resource workspaceName_perfcounter22 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter22'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'User Input Delay per Process'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Max Input Delay'
  }
}

resource workspaceName_perfcounter23 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter23'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'User Input Delay per Session'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Max Input Delay'
  }
}

resource workspaceName_perfcounter24 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter24'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'RemoteFX Network'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Current TCP RTT'
  }
}

resource workspaceName_perfcounter25 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/perfcounter25'
  kind: 'WindowsPerformanceCounter'
  properties: {
    objectName: 'RemoteFX Network'
    instanceName: '*'
    intervalSeconds: 30
    counterName: 'Current UDP Bandwidth'
  }
}

resource workspaceName_WindowsEventsSystem 'Microsoft.OperationalInsights/workspaces/datasources@2020-08-01' = {
  name: '${LogAnalytics.name}/WindowsEventsSystem'
  kind: 'WindowsEvent'
  properties: {
    eventLogName: 'System'
    eventTypes: [
      {
        eventType: 'Error'
      }
      {
        eventType: 'Warning'
      }
    ]
  }
}

resource workspaceName_WindowsEventsApplication 'Microsoft.OperationalInsights/workspaces/datasources@2020-08-01' = {
  name: '${LogAnalytics.name}/WindowsEventsApplication'
  kind: 'WindowsEvent'
  properties: {
    eventLogName: 'Application'
    eventTypes: [
      {
        eventType: 'Error'
      }
      {
        eventType: 'Warning'
      }
    ]
  }
}

resource workspaceName_WindowsEventsFSLogix 'Microsoft.OperationalInsights/workspaces/datasources@2020-08-01' = {
  name: '${LogAnalytics.name}/WindowsEventsFSLogix'
  kind: 'WindowsEvent'
  properties: {
    eventLogName: 'Microsoft-FSLogix-Apps/Operational'
    eventTypes: [
      {
        eventType: 'Error'
      }
      {
        eventType: 'Warning'
      }
      {
        eventType: 'Information'
      }
    ]
  }
}

resource workspaceName_WindowsEventTerminalServicesOperational 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/WindowsEventTerminalServicesOperational'
  kind: 'WindowsEvent'
  properties: {
    eventLogName: 'Microsoft-Windows-TerminalServices-LocalSessionManager/Operational'
    eventTypes: [
      {
        eventType: 'Error'
      }
      {
        eventType: 'Warning'
      }
      {
        eventType: 'Information'
      }
    ]
  }
}

resource workspaceName_WindowsEventTerminalServicesAdmin 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/WindowsEventTerminalServicesAdmin'
  kind: 'WindowsEvent'
  properties: {
    eventLogName: 'Microsoft-Windows-TerminalServices-RemoteConnectionManager/Admin'
    eventTypes: [
      {
        eventType: 'Error'
      }
      {
        eventType: 'Warning'
      }
      {
        eventType: 'Information'
      }
    ]
  }
}

resource workspaceName_WindowsEventFSLogixAdmin 'Microsoft.OperationalInsights/workspaces/datasources@2015-11-01-preview' = {
  name: '${LogAnalytics.name}/WindowsEventFSLogixAdmin'
  kind: 'WindowsEvent'
  properties: {
    eventLogName: 'Microsoft-FSLogix-Apps/Admin'
    eventTypes: [
      {
        eventType: 'Error'
      }
      {
        eventType: 'Warning'
      }
      {
        eventType: 'Information'
      }
    ]
  }
}
