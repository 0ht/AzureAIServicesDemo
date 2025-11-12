using '../main.bicep'

// 開発環境用のパラメータ
param location = 'eastus'
param environmentName = 'dev'
param projectPrefix = 'aiservicesdemo'
// uniqueIdは自動生成されるため設定不要
// 既存のアカウントが Active 状態のため restore は false に設定
param restore = false

// 画像生成モデル: Japan East では現在未サポートのため無効化
// 利用したい場合は East US / Sweden Central 等のリージョンへ切替検討
param deployDalle3 = true
param deployGptImage = false
