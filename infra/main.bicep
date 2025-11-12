// メインのAzure AI Servicesデモ用インフラストラクチャテンプレート
metadata name = 'Azure AI Services Demo Infrastructure'
metadata description = 'Azure AI Services デモンストレーション用のインフラストラクチャを展開します'

@description('デプロイ対象のAzureリージョン')
param location string = resourceGroup().location

@description('環境名（dev, test, prod等）')
param environmentName string = 'dev'

@description('プロジェクト名のプレフィックス')
param projectPrefix string = 'aiservicesdemo'

@description('一意の識別子（リソース名の重複を避けるため）')
param uniqueId string = uniqueString(resourceGroup().id)

@description('既に同名で soft-deleted された Cognitive Services を復元する場合は true にします（デフォルト false）')
param restore bool = true

// Cognitive Services (AI Services) の作成
module aiServices 'br/public:avm/res/cognitive-services/account:0.13.2' = {
  name: 'aiServices-deployment'
  params: {
    name: '${projectPrefix}-ai-${environmentName}-${take(uniqueId, 6)}'
    kind: 'AIServices'
    location: location
    sku: 'S0'
    customSubDomainName: '${projectPrefix}-ai-${environmentName}-${take(uniqueId, 6)}'
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    // オプトインで復元フラグを渡す
    restore: restore
    deployments: [
      {
        name: 'gpt-4o'
        model: {
          format: 'OpenAI'
          name: 'gpt-4o'
          version: '2024-11-20'
        }
        sku: {
          name: 'Standard'
          capacity: 10
        }
      }
      {
        name: 'gpt-35-turbo'
        model: {
          format: 'OpenAI'
          name: 'gpt-35-turbo'
          version: '0125'
        }
        sku: {
          name: 'Standard'
          capacity: 10
        }
      }
      {
        name: 'text-embedding-ada-002'
        model: {
          format: 'OpenAI'
          name: 'text-embedding-ada-002'
          version: '2'
        }
        sku: {
          name: 'Standard'
          capacity: 10
        }
      }
    ]
    tags: {
      Environment: environmentName
      Project: 'Azure AI Services Demo'
      ManagedBy: 'Bicep'
    }
  }
}

// Computer Vision サービスの作成
module computerVision 'br/public:avm/res/cognitive-services/account:0.13.2' = {
  name: 'computerVision-deployment'
  params: {
    name: '${projectPrefix}-cv-${environmentName}-${take(uniqueId, 6)}'
    kind: 'ComputerVision'
    location: location
    sku: 'S1'
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    // オプトインで復元フラグを渡す
    restore: restore
    tags: {
      Environment: environmentName
      Project: 'Azure AI Services Demo'
      Service: 'Computer Vision'
      ManagedBy: 'Bicep'
    }
  }
}

// Speech Services の作成
module speechServices 'br/public:avm/res/cognitive-services/account:0.13.2' = {
  name: 'speechServices-deployment'
  params: {
    name: '${projectPrefix}-speech-${environmentName}-${take(uniqueId, 6)}'
    kind: 'SpeechServices'
    location: location
    sku: 'S0'
    customSubDomainName: '${projectPrefix}-speech-${environmentName}-${take(uniqueId, 6)}'
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    // オプトインで復元フラグを渡す
    restore: restore
    tags: {
      Environment: environmentName
      Project: 'Azure AI Services Demo'
      Service: 'Speech Services'
      ManagedBy: 'Bicep'
    }
  }
}

// Language Services の作成
module languageServices 'br/public:avm/res/cognitive-services/account:0.13.2' = {
  name: 'languageServices-deployment'
  params: {
    name: '${projectPrefix}-lang-${environmentName}-${take(uniqueId, 6)}'
    kind: 'TextAnalytics'
    location: location
    sku: 'S'
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    // オプトインで復元フラグを渡す
    restore: restore
    tags: {
      Environment: environmentName
      Project: 'Azure AI Services Demo'
      Service: 'Language Services'
      ManagedBy: 'Bicep'
    }
  }
}

// 出力値の定義
@description('Azure OpenAI/AI Services のエンドポイント')
output aiServicesEndpoint string = aiServices.outputs.endpoint

@description('Azure OpenAI/AI Services の情報')
output aiServicesEndpoints object = aiServices.outputs.endpoints

@description('Computer Vision のエンドポイント')
output computerVisionEndpoint string = computerVision.outputs.endpoint

@description('Computer Vision の情報')
output computerVisionEndpoints object = computerVision.outputs.endpoints

@description('Speech Services のエンドポイント')
output speechServicesEndpoint string = speechServices.outputs.endpoint

@description('Speech Services の情報')
output speechServicesEndpoints object = speechServices.outputs.endpoints

@description('Speech Services のリージョン')
output speechServicesRegion string = location

@description('Language Services のエンドポイント')
output languageServicesEndpoint string = languageServices.outputs.endpoint

@description('Language Services の情報')
output languageServicesEndpoints object = languageServices.outputs.endpoints

@description('デプロイされたリソースの詳細')
output deployedResources object = {
  aiServices: {
    name: aiServices.outputs.name
    resourceId: aiServices.outputs.resourceId
    endpoint: aiServices.outputs.endpoint
  }
  computerVision: {
    name: computerVision.outputs.name
    resourceId: computerVision.outputs.resourceId
    endpoint: computerVision.outputs.endpoint
  }
  speechServices: {
    name: speechServices.outputs.name
    resourceId: speechServices.outputs.resourceId
    endpoint: speechServices.outputs.endpoint
  }
  languageServices: {
    name: languageServices.outputs.name
    resourceId: languageServices.outputs.resourceId
    endpoint: languageServices.outputs.endpoint
  }
}
