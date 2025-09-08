param sqlName string
param sqlAdministratorLogin string
@secure()
param sqladministratorLoginPassword string

param location string = resourceGroup().location


// Virtual Network Parameters
param virtualNetworkName string

// Private DNS Zone ID for SQL privatelink zone (e.g., Microsoft.Network/privateDnsZones/privatelink.database.windows.net)
param sqlPrivateDnsZoneId string

// (No local DNS suffix needed here; using provided sqlPrivateDnsZoneId.)
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: virtualNetworkName
}


resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlName
  location: location
  properties: {
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqladministratorLoginPassword
    publicNetworkAccess: 'Disabled'
  }
}

resource privateendpoint 'Microsoft.Network/privateEndpoints@2021-02-01' = {
  name: '${sqlName}-privateendpoint'
  location: resourceGroup().location
  properties: {
    privateLinkServiceConnections: [
      {
        name: '${sqlName}-peconnection'
        properties: {
          privateLinkServiceId: sqlServer.id
          groupIds: [
            'sqlServer'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
          }
        }
      }
    ]
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name, virtualNetwork.properties.subnets[1].name)
    }
  }
}

resource privatednszonegroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-02-01' = {
  parent: privateendpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-database-windows-net'
        properties: {
          privateDnsZoneId: sqlPrivateDnsZoneId
        }
      }
    ]
  }
}

// Outputs
output sqlServerId string = sqlServer.id
@description('Fully qualified domain name for the SQL Server as reported by the resource')
output sqlFqdn string = sqlServer.properties.fullyQualifiedDomainName
