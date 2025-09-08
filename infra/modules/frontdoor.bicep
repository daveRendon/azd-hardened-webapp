param frontDoorName string
param customBackendFqdn string
@allowed([
  'Standard_AzureFrontDoor'
  'Premium_AzureFrontDoor'
])
param skuName string = 'Standard_AzureFrontDoor'

// Azure Front Door Standard/Premium (Microsoft.Cdn)
// Profile
resource profile 'Microsoft.Cdn/profiles@2023-05-01' = {
  name: frontDoorName
  location: 'Global'
  sku: {
    name: skuName
  }
}

// Origin group with health probe and load balancing
resource originGroup 'Microsoft.Cdn/profiles/originGroups@2023-05-01' = {
  name: 'default-origin-group'
  parent: profile
  properties: {
    sessionAffinityState: 'Disabled'
    healthProbeSettings: {
      probeRequestType: 'HEAD'
      probeProtocol: 'Https'
      probePath: '/'
      probeIntervalInSeconds: 30
    }
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 2
      additionalLatencyInMilliseconds: 0
    }
  }
}

// Origin pointing to the backend FQDN
resource origin 'Microsoft.Cdn/profiles/originGroups/origins@2023-05-01' = {
  name: 'default-origin'
  parent: originGroup
  properties: {
    hostName: customBackendFqdn
    httpPort: 80
    httpsPort: 443
    priority: 1
    weight: 50
    enabledState: 'Enabled'
    originHostHeader: customBackendFqdn
  }
}

// Endpoint
resource endpoint 'Microsoft.Cdn/profiles/afdEndpoints@2023-05-01' = {
  name: '${frontDoorName}-endpoint'
  parent: profile
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

// Route mapping endpoint to origin group
resource route 'Microsoft.Cdn/profiles/afdEndpoints/routes@2023-05-01' = {
  name: 'default-route'
  parent: endpoint
  dependsOn: [
    origin
  ]
  properties: {
    originGroup: {
      id: originGroup.id
    }
    httpsRedirect: 'Enabled'
    linkToDefaultDomain: 'Enabled'
    supportedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/*'
    ]
    forwardingProtocol: 'MatchRequest'
  }
}
