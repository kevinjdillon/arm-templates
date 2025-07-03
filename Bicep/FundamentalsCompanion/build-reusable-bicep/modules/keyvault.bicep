@description('Name of the key vault')
@minLength(14)
@maxLength(24)
param keyVaultName string = 'kv-toyhr${uniqueString(resourceGroup().id)}'

@description('Location for the key vault')
param location string = resourceGroup().location

param sqlServerAdministratorLogin string

@secure()
param sqlServerAdministratorPassword string

var keyVaultAdminId = 'ea78ccd1-4b49-4305-9397-d8b8197ea48b'

// Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForTemplateDeployment: true
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: keyVaultAdminId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
        }
      }
    ]
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enablePurgeProtection: true
  }
}

// Initial Secrets
resource sqlServerAdministrator 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  parent: keyVault
  name: 'sqlServerAdministratorLogin'
  properties: {
    contentType: 'text/plain'
    value: sqlServerAdministratorLogin
    attributes: {
      enabled: true
    }
  }
}
resource sqlServerPassord 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  parent: keyVault
  name: 'sqlServerAdministratorPassword'
  properties: {
    contentType: 'text/plain'
    value: sqlServerAdministratorPassword
    attributes: {
      enabled: true
    }
  }
}

// Outputs
output keyVaultId string = keyVault.id
