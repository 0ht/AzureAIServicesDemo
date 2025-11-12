using '../main.bicep'

// 開発環境用のパラメータ
param location = 'japaneast'
param environmentName = 'dev'
param projectPrefix = 'aiservicesdemo'
// uniqueIdは自動生成されるため設定不要
param restore = true
