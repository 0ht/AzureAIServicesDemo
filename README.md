# Azure AI Services デモ

このリポジトリは、Azure AI Servicesの各種機能をデモンストレーションするための手順、マテリアル、およびインフラストラクチャテンプレートを提供します。

## 📁 ディレクトリ構成

```
├── infra/                          # Bicepテンプレート（インフラ構築）
│   ├── main.bicep                  # メインテンプレート
│   ├── modules/                    # 再利用可能なモジュール
│   └── parameters/                 # パラメータファイル
├── demos/                          # 各サービスのデモ用Notebook
│   ├── cognitive-services/         # Cognitive Servicesデモ
│   ├── openai/                     # Azure OpenAIデモ
│   ├── speech/                     # Speech Servicesデモ
│   ├── vision/                     # Computer Visionデモ
│   └── language/                   # Language Servicesデモ
├── docs/                           # ドキュメント
├── scripts/                        # ヘルパースクリプト（将来使用）
└── README.md                       # このファイル
```

## 🚀 はじめ方

### 1. 前提条件

- Azure サブスクリプション
- Azure CLI (最新版)
- Python 3.8以上
- Jupyter Notebook または VS Code with Jupyter extension

### 2. インフラストラクチャのデプロイ

**📓 Notebookを使用した段階的デプロイ（推奨）:**

1. VS CodeまたはJupyter環境で `infra/Deploy-Infrastructure.ipynb` を開く
2. Notebookの各セルを順番に実行
3. 各ステップで確認しながら安全にデプロイ

**⚡ 手動デプロイ（上級者向け）:**

```bash
# Azure CLIにログイン
az login

# リソースグループの作成
az group create --name rg-ai-services-demo --location japaneast

# Bicepテンプレートのデプロイ
az deployment group create \
  --resource-group rg-ai-services-demo \
  --template-file infra/main.bicep \
  --parameters infra/parameters/dev.bicepparam
```

### 3. 環境設定

```bash
# 必要なPythonパッケージのインストール
pip install -r requirements.txt

# 環境変数の設定（.envファイルを作成）
cp .env.template .env
# .envファイルを編集してAzureリソースの接続情報を設定
```

## 📊 デモ内容

### Azure OpenAI Services
- **場所**: `demos/openai/`
- **内容**: GPT-4、GPT-3.5-turbo、DALL-E、Embeddingsのデモ
- **ノートブック**: 
  - `01_chat_completion.ipynb` - チャット補完API（Chat Completions API）
  - `02_embeddings.ipynb` - テキスト埋め込み
  - `03_image_generation.ipynb` - 画像生成

### Computer Vision
- **場所**: `demos/vision/`
- **内容**: 画像解析、OCR、物体検出のデモ
- **ノートブック**:
  - `01_image_analysis.ipynb` - 画像分析
  - `02_ocr.ipynb` - 光学文字認識
  - `03_custom_vision.ipynb` - カスタムビジョン

### Speech Services
- **場所**: `demos/speech/`
- **内容**: 音声認識、音声合成のデモ
- **ノートブック**:
  - `01_speech_to_text.ipynb` - 音声テキスト変換
  - `02_text_to_speech.ipynb` - テキスト音声変換

### Language Services
- **場所**: `demos/language/`
- **内容**: テキスト分析、言語理解のデモ
- **ノートブック**:
  - `01_sentiment_analysis.ipynb` - 感情分析
  - `02_key_phrase_extraction.ipynb` - キーフレーズ抽出
  - `03_language_detection.ipynb` - 言語検出

### Cognitive Services
- **場所**: `demos/cognitive-services/`
- **内容**: 複数のサービスを組み合わせたデモ
- **ノートブック**:
  - `01_multimodal_analysis.ipynb` - マルチモーダル分析
  - `02_intelligent_document_processing.ipynb` - インテリジェント文書処理

## 🔧 設定とカスタマイズ

### 環境変数

以下の環境変数を設定してください：

```bash
# Azure OpenAI
AZURE_OPENAI_ENDPOINT=https://your-openai-resource.openai.azure.com/
AZURE_OPENAI_API_KEY=your-api-key

# Computer Vision
COMPUTER_VISION_ENDPOINT=https://your-vision-resource.cognitiveservices.azure.com/
COMPUTER_VISION_KEY=your-api-key

# Speech Services
SPEECH_REGION=japaneast
SPEECH_KEY=your-api-key

# Language Services
LANGUAGE_ENDPOINT=https://your-language-resource.cognitiveservices.azure.com/
LANGUAGE_KEY=your-api-key
```

## 📚 参考資料

- [Azure AI Services ドキュメント](https://docs.microsoft.com/azure/cognitive-services/)
- [Azure OpenAI Service](https://docs.microsoft.com/azure/cognitive-services/openai/)
- [Computer Vision API](https://docs.microsoft.com/azure/cognitive-services/computer-vision/)
- [Speech Services](https://docs.microsoft.com/azure/cognitive-services/speech-service/)

## 🤝 貢献

プルリクエストやイシューの報告を歓迎します。詳細は [CONTRIBUTING.md](docs/CONTRIBUTING.md) をご覧ください。

## 📄 ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。詳細は [LICENSE](LICENSE) ファイルをご覧ください。