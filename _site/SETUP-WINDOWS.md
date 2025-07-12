# Windows Jekyll開発環境 セットアップガイド

## 🚀 ステップ1: 必要なソフトウェアのインストール

### 1. Ruby のインストール（必須）

**RubyInstaller for Windows を使用（推奨）:**

1. [RubyInstaller for Windows](https://rubyinstaller.org/) にアクセス
2. **Ruby+Devkit 3.1.x (x64)** をダウンロード（推奨）
3. インストーラーを実行
4. インストール完了後、コマンドプロンプトで MSYS2 開発ツールチェーンをインストール
5. `ridk install` が自動で実行される場合は `1`, `2`, `3` を順番に実行

**または winget を使用:**
```powershell
# PowerShellを管理者権限で実行
winget install RubyInstallerTeam.Ruby.3.1
```

### 2. Node.js のインストール（必須）

**公式サイトから:**
1. [Node.js公式サイト](https://nodejs.org/) にアクセス
2. **LTS版**をダウンロード
3. インストーラーを実行

**または winget を使用:**
```powershell
# PowerShellを管理者権限で実行
winget install OpenJS.NodeJS
```

### 3. Git のインストール（既にインストール済みの場合はスキップ）

```powershell
winget install Git.Git
```

## 🔧 ステップ2: インストールの確認

PowerShellを**新しく開き直して**以下を実行:

```powershell
# Ruby確認
ruby --version
gem --version

# Node.js確認  
node --version
npm --version

# Git確認
git --version
```

すべてバージョンが表示されればOKです。

## 🎯 ステップ3: Jekyllプロジェクトの初期化

```powershell
# プロジェクトディレクトリに移動
cd "C:\Users\sep10\Documents\GitHub\takuizum.github.io"

# Ruby Gems のインストール
bundle install

# Node.js パッケージのインストール  
npm install

# Jekyll の動作確認
bundle exec jekyll --version
```

## ⚡ ステップ4: PowerShell Profile の設定

### 自動設定スクリプトを実行（推奨）:
```powershell
# プロジェクトディレクトリで実行
.\setup-profile.ps1
```

このスクリプトがPowerShell Profileを自動設定します。

### 手動設定の場合:

#### PowerShell Profile の場所を確認:
```powershell
$PROFILE
```

#### Profile ファイルを作成/編集:
```powershell
# Profile ディレクトリを作成（存在しない場合）
New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force

# VS Code でProfile を開く
code $PROFILE
```

#### Profile に追加する内容:
```powershell
# Jekyll 開発用エイリアス
function jserve { bundle exec jekyll serve --livereload --incremental }
function jbuild { bundle exec jekyll build }
function jdraft { bundle exec jekyll serve --drafts --livereload }
function jclean { bundle exec jekyll clean }
function jopen { Start-Process "http://localhost:4000" }

# Git エイリアス
function gst { git status }
function gaa { git add . }
function gcm { param($msg) git commit -m $msg }
function gps { git push }
function gpl { git pull }

Write-Host "Jekyll Development Environment Loaded!" -ForegroundColor Green
```

### Profile を再読み込み:
```powershell
. $PROFILE
```

## 🔌 ステップ5: VS Code 拡張機能のインストール

VS Code で以下の拡張機能をインストール（自動で推奨されます）:

### 必須拡張機能:
- **Jekyll Snippets** (jekyll-snippets)
- **Liquid** (liquid-language-support)  
- **Ruby** (ruby-language-colorization)
- **Markdown All in One** (markdown-all-in-one)

### 推奨拡張機能:
- **Live Server** (live-server)
- **Prettier** (prettier-vscode)
- **ESLint** (eslint)
- **GitLens** (gitlens)
- **Auto Rename Tag** (auto-rename-tag)

## 🧪 ステップ6: 動作テスト

```powershell
# Jekyll 開発サーバーを起動
jserve

# または従来のコマンド
bundle exec jekyll serve --livereload
```

ブラウザで `http://localhost:4000` にアクセスしてサイトが表示されれば成功！

## 🚨 トラブルシューティング

### よくある問題と解決策:

#### 1. PowerShell実行ポリシーエラー
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### 2. Ruby/Jekyll のパスが通らない
- PCを再起動
- または手動で環境変数PATHに追加:
  ```powershell
  # 環境変数PATHを確認
  $env:PATH -split ';' | Where-Object { $_ -like '*ruby*' -or $_ -like '*node*' }
  
  # パスを手動追加（例）
  [Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";C:\Ruby34-x64\bin;C:\Program Files\nodejs", [EnvironmentVariableTarget]::User)
  ```
- 新しいPowerShellウィンドウを開いてテスト

#### 3. PowerShell実行ポリシーエラー（npm使用時）
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
```powershell
# gem を最新に更新
gem update --system

# bundler を再インストール
gem uninstall bundler
gem install bundler

# 再試行
bundle install
```

#### 4. エンコーディングエラー
```powershell
# PowerShell で UTF-8 設定
$env:LANG = "en_US.UTF-8"
$env:LC_ALL = "en_US.UTF-8"
```

#### 5. ポート4000が使用中
```powershell
# 別のポートを使用
bundle exec jekyll serve --port 4001

# または使用中のプロセスを終了
netstat -ano | findstr :4000
# 表示されたPIDを使って
taskkill /PID [PID番号] /F
```

## 📚 便利なコマンド一覧

設定完了後に使える便利コマンド:

```powershell
jserve    # 開発サーバー起動
jbuild    # 本番ビルド  
jdraft    # 下書き込みでサーバー起動
jclean    # キャッシュクリア
jopen     # ブラウザでサイトを開く

gst       # git status
gaa       # git add .
gcm "メッセージ"  # git commit -m "メッセージ"
gps       # git push
gpl       # git pull
```

この手順に従って環境を構築すれば、Windowsで快適なJekyll開発ができるようになります！
