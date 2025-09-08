targetScope = 'subscription'

@description('Location for the resource group')
param location string = deployment().location

@description('Name of the resource group to create')
param resourceGroupName string = 'rg-hardened-webapp'

// Create the resource group
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  // Removed invalid environment().deploymentName tag
}

// Re-expose parameters for group-scoped deployment
param suffix string = 'azinsider'
param usePreviewFeatures bool = true
param customBackendFqdn string
@secure()
param sqladministratorLoginPassword string

module rgDeployment './rg-main.bicep' = {
  name: 'rgDeployment'
  dependsOn: [
    rg
  ]
  scope: resourceGroup(resourceGroupName)
  params: {
    suffix: suffix
    usePreviewFeatures: usePreviewFeatures
    customBackendFqdn: customBackendFqdn
  sqladministratorLoginPassword: sqladministratorLoginPassword
  }
}

output firewallPublicIp string = rgDeployment.outputs.firewallPublicIp
output customDomainVerificationId string = rgDeployment.outputs.customDomainVerificationId
output sqlFqdn string = rgDeployment.outputs.sqlFqdn
