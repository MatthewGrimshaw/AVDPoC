param nameprefix string
param nsgname string
param location string
param disableBGPProp bool = false
param routes array = []  //empty


resource routeTable 'Microsoft.Network/routeTables@2021-05-01' = {
  name: '${nameprefix}-${nsgname}'
  location: location
  properties: {
    disableBgpRoutePropagation: disableBGPProp
    routes: routes
  }
}
