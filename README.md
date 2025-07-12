# takuizum.github.io

## 概要

このリポジトリは、Jekyll静的サイトジェネレータを使用した研究・個人事業のWebサイトです。統計学、データサイエンス、プログラミングに関する情報を発信しています。

## 🚀 主要な機能

- **Jekyll静的サイトジェネレータ**: GitHub Pages完全対応
- **レスポンシブデザイン**: モバイル・デスクトップ対応
- **ライブリロード**: リアルタイム編集・プレビュー
- **SCSS**: モジュール化されたスタイル管理
- **自動デプロイ**: GitHub Actions による CI/CD
- **SEO最適化**: Jekyll SEO Tag プラグイン
- **RSS フィード**: 自動生成
- **VS Code統合**: 最適化された開発環境

## 🏗️ 技術スタック

### フロントエンド
- **Jekyll 3.10.0**: GitHub Pages互換バージョン
- **github-pages gem**: GitHub Pages完全対応
- **Liquid**: テンプレートエンジン
- **SCSS**: CSS プリプロセッサ
- **ES6+ JavaScript**: モジュール化されたスクリプト

### 開発ツール
- **Ruby 3.4+**: Jekyll実行環境
- **Bundler**: Ruby 依存関係管理
- **Node.js**: JavaScript ツール実行環境
- **npm**: Node.js パッケージ管理
- **ESLint**: JavaScript リンター
- **Stylelint**: CSS/SCSS リンター
- **wdm**: Windows用ファイル監視最適化

## 🛠️ Windows開発環境のセットアップ

### 前提条件

#### 1. Ruby のインストール
```powershell
# RubyInstaller for Windows を使用（推奨）
# https://rubyinstaller.org/ から Ruby+Devkit 3.1.x 以上をダウンロード
# または winget を使用
winget install RubyInstallerTeam.Ruby
```

#### 2. Node.js のインストール
```powershell
# 公式サイト: https://nodejs.org/ から LTS版をダウンロード
# または winget を使用
winget install OpenJS.NodeJS
```

#### 3. Git のインストール（必要に応じて）
```powershell
winget install Git.Git
```

### 開発環境の構築

#### 1. リポジトリのクローン
```powershell
git clone https://github.com/takuizum/takuizum.github.io.git
cd takuizum.github.io
```

#### 2. 依存関係のインストール
```powershell
# Ruby Gems のインストール
bundle install

# Node.js パッケージのインストール
npm install
```

#### 3. PowerShell Profile の設定（推奨）
```powershell
# 自動設定スクリプトを実行
.\setup-profile.ps1

# または手動で $PROFILE に以下を追加：
# Jekyll開発用エイリアス
function jserve { bundle exec jekyll serve --livereload --incremental }
function jbuild { bundle exec jekyll build }
function jopen { Start-Process "http://localhost:4000" }
```

#### 4. VS Code 拡張機能のインストール
推奨拡張機能（自動で推奨されます）：
- **Jekyll Snippets**: Jekyll/Liquidスニペット
- **Liquid**: Liquid言語サポート
- **Markdown All in One**: Markdown編集支援
- **ESLint**: JavaScript リンティング
- **GitLens**: Git履歴表示
- **Live Server**: ライブプレビュー
- **Prettier**: コードフォーマッター

### 📝 開発ワークフロー

#### サーバーの起動
```powershell
# PowerShell Profile設定済みの場合
jserve

# または従来のコマンド
bundle exec jekyll serve --livereload --incremental
```

#### リアルタイム編集
1. **Jekyll サーバー起動**: `jserve` でライブリロード付きサーバーを起動
2. **VS Code内ブラウザ**: 
   - Ctrl+Shift+P → "Simple Browser: Show"
   - URL: `http://localhost:4000`
3. **ライブ編集**: 
   - ファイル編集・保存で自動的にブラウザが更新
   - VS Code内で編集とプレビューを同時表示

#### 新しいコンテンツの作成

##### 投稿記事
```powershell
# _posts/ フォルダに YYYY-MM-DD-title.md ファイルを作成
# VS Code で jekyll-post + Tab でテンプレート挿入
```

##### 論文・出版物
```powershell
# _publications/ フォルダに .md ファイルを作成  
# VS Code で jekyll-publication + Tab でテンプレート挿入
```

### 🎯 便利なコマンド

#### PowerShell エイリアス（Profile設定後）
```powershell
jserve    # Jekyll開発サーバー起動
jbuild    # 本番ビルド
jdraft    # 下書き込みでサーバー起動
jclean    # キャッシュクリア
jopen     # ブラウザでサイトを開く

# Git操作
gst       # git status
gaa       # git add .
gcm "msg" # git commit -m "msg"
gps       # git push
gpl       # git pull
```

#### VS Code スニペット
- `jekyll-post` + Tab: 新しい投稿テンプレート
- `jekyll-publication` + Tab: 論文テンプレート
- `jekyll-page` + Tab: 新しいページテンプレート
- `liquid-include` + Tab: Liquid includeタグ

### 🚨 トラブルシューティング

#### PowerShell実行ポリシーエラー
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Ruby/Node.js コマンドが認識されない
```powershell
# 環境変数PATHの確認
$env:PATH -split ';' | Where-Object { $_ -like '*ruby*' -or $_ -like '*node*' }

# 手動でパス追加（例）
[Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";C:\Ruby34-x64\bin;C:\Program Files\nodejs", [EnvironmentVariableTarget]::User)

# PowerShell再起動後にテスト
ruby --version
node --version
```

#### Bundle install エラー
```powershell
# Gemキャッシュクリア
bundle clean --force

# Gemfile.lock削除
Remove-Item Gemfile.lock -Force

# 再インストール
bundle install
```

#### ポート4000使用中エラー
```powershell
# 使用中プロセス確認
netstat -ano | Select-String "4000"

# プロセス終了
Get-Process ruby* | Stop-Process -Force

# または別ポート使用
bundle exec jekyll serve --port 4001
```

## 🔄 ライブ編集ワークフロー

### VS Code内でのリアルタイム編集
1. **Jekyll サーバー起動**:
   ```powershell
   jserve
   ```

2. **VS Code内ブラウザでプレビュー**:
   - **Ctrl+Shift+P** → "Simple Browser: Show"
   - URL: `http://localhost:4000`

3. **リアルタイム編集**:
   - ファイル編集・保存
   - 自動的にサイト再生成
   - ブラウザが自動更新

### 推奨レイアウト
- **左側**: ファイルエクスプローラー + エディタ
- **右側**: VS Code内蔵ブラウザ
- **下部**: ターミナル（サーバーログ表示）

## 📊 アナリティクス・SEO

### Google Analytics の設定
`_config.yml` で設定：
```yaml
google_analytics: UA-XXXXXXXX-X
```

### SEO の最適化
- Jekyll SEO Tag プラグインが自動的にメタタグを生成
- `_config.yml` でサイト情報を設定
- 各ページで個別にSEO設定が可能

## 🚀 デプロイメント

GitHub Actions により自動デプロイされます：

1. `master` ブランチへのプッシュ
2. 自動的にビルド・テスト・デプロイ実行
3. GitHub Pages で公開

### 手動デプロイ
```bash
npm run deploy
```

## 🎯 開発のベストプラクティス

### ファイル構成
- **投稿**: `_posts/YYYY-MM-DD-title.md`
- **論文**: `_publications/title.md`
- **ページ**: ルートディレクトリまたは適切なフォルダに配置

### Markdown記法
- Jekyll Liquid タグの活用
- Front Matter での設定
- VS Code スニペットの利用

### スタイル管理
- SCSS の変数活用（`_sass/_variables.scss`）
- コンポーネントベースの設計
- レスポンシブデザインの考慮

## 💡 追加情報

### 詳細なセットアップガイド
- [SETUP-WINDOWS.md](SETUP-WINDOWS.md): Windows特化の詳細手順
- [.vscode/windows-setup.md](.vscode/windows-setup.md): VS Code最適化

### 便利なリソース
- **Jekyll公式ドキュメント**: https://jekyllrb.com/
- **GitHub Pages ヘルプ**: https://docs.github.com/en/pages
- **Liquid テンプレート**: https://shopify.github.io/liquid/

## 🤝 コントリビューション

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 ライセンス

このプロジェクトは [MIT ライセンス](LICENSE) の下で公開されています。

## 📧 お問い合わせ

- **GitHub Issues**: [Issues ページ](https://github.com/takuizum/takuizum.github.io/issues)
- **Email**: your.email@example.com
