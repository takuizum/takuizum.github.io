# Windows Jekyll開発環境設定ガイド

## 前提条件

### 1. Ruby環境のセットアップ（Windows）
```powershell
# RubyInstaller for Windowsを使用（推奨）
# https://rubyinstaller.org/ からダウンロード

# インストール後の確認
ruby --version
gem --version
```

### 2. Node.js環境（Windows）
```powershell
# Node.jsを公式サイトからダウンロード
# https://nodejs.org/

# または winget を使用
winget install OpenJS.NodeJS

# 確認
node --version
npm --version
```

### 3. Git設定
```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 開発環境の初期化

### 1. 依存関係のインストール
```powershell
# Ruby Gems
bundle install

# Node.js パッケージ
npm install
```

### 2. 開発サーバーの起動
```powershell
# Jekyll開発サーバー
bundle exec jekyll serve --livereload

# または VS Code タスクランナーを使用（推奨）
# Ctrl+Shift+P -> "Tasks: Run Task" -> "Jekyll: Serve"
```

## VS Code 拡張機能

以下の拡張機能が自動的に推奨されます：

### Jekyll & Liquid
- **Jekyll Snippets**: Jekyll/Liquidのスニペット
- **Liquid**: Liquidテンプレート言語のサポート

### Web開発
- **Live Server**: 静的ファイルのライブプレビュー
- **Auto Rename Tag**: HTMLタグの自動リネーム
- **HTML CSS Support**: CSSクラス名の自動補完

### Markdown
- **Markdown All in One**: Markdown編集支援
- **Markdown Preview Enhanced**: 高機能プレビュー

### SCSS/CSS
- **Live Sass Compiler**: SCSS/SASSの自動コンパイル
- **CSS Peek**: CSSクラスの定義ジャンプ

### コード品質
- **ESLint**: JavaScript/TypeScriptリンティング
- **Stylelint**: CSS/SCSSリンティング
- **Prettier**: コードフォーマッター

### Git
- **GitLens**: Git履歴とブレーム情報
- **Git Graph**: Git履歴の視覚化

## 便利なスニペット

プロジェクトに含まれるスニペット：
- `jekyll-post`: 新しい投稿のテンプレート
- `jekyll-publication`: 論文のテンプレート
- `jekyll-page`: 新しいページのテンプレート
- `liquid-include`: Liquidインクルードタグ
- `scss-mixin`: SCSSミックスイン

使用方法：Markdownファイルで `jekyll-post` と入力してTabキー

## VS Code タスク

以下のタスクが利用可能：

### Jekyll関連
- **Jekyll: Serve**: 開発サーバー起動（Ctrl+Shift+P -> Tasks: Run Task）
- **Jekyll: Build**: 本番ビルド
- **Jekyll: Build Draft**: 下書きを含むビルド

### リンティング
- **Lint: All**: 全ファイルのリンティング
- **Lint: JavaScript**: JavaScriptファイルのリンティング
- **Lint: CSS**: CSS/SCSSファイルのリンティング

### デプロイ
- **Deploy: GitHub Pages**: GitHub Pagesへのデプロイ（CI/CD使用）

## 開発ワークフロー

### 1. 新しい投稿の作成
```powershell
# VS Code で新しいファイルを作成
# _posts/YYYY-MM-DD-post-title.md

# スニペット 'jekyll-post' を使用
```

### 2. 開発サーバーでプレビュー
```powershell
# VS Code タスクまたはターミナル
bundle exec jekyll serve --livereload
```

### 3. コードの検証
```powershell
# リンティング（VS Code タスク推奨）
npm run lint

# または個別実行
npx eslint assets/js/
npx stylelint assets/css/ _sass/
```

### 4. Git操作
```powershell
git add .
git commit -m "feat: add new post about XXX"
git push origin main
```

## トラブルシューティング

### Windows特有の問題

#### 1. Encoding エラー
```powershell
# PowerShellでUTF-8設定
$env:LANG = "en_US.UTF-8"
$env:LC_ALL = "en_US.UTF-8"
```

#### 2. Jekyll サーバーが起動しない
```powershell
# ポートの確認と変更
bundle exec jekyll serve --port 4001

# または別の方法でプロセス終了
netstat -ano | findstr :4000
taskkill /PID [PID番号] /F
```

#### 3. Bundle install エラー
```powershell
# キャッシュクリア
bundle clean
bundle install

# または gem の再インストール
gem cleanup
bundle install
```

#### 4. Permission エラー
```powershell
# PowerShell を管理者権限で実行
# または実行ポリシーの変更
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 推奨設定

### PowerShell Profile設定
PowerShellプロファイルに以下を追加：

```powershell
# Jekyll エイリアス
function jserve { bundle exec jekyll serve --livereload }
function jbuild { bundle exec jekyll build }
function jdraft { bundle exec jekyll serve --drafts --livereload }

# Git エイリアス
function gst { git status }
function gco { git checkout $args }
function gcm { git commit -m $args }
function gps { git push }
function gpl { git pull }
```

### WSL（Windows Subsystem for Linux）使用時
WSLでの開発も可能です：

```bash
# WSL Ubuntu での環境構築
sudo apt update
sudo apt install ruby-full build-essential zlib1g-dev

# gem パスの設定
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Jekyll インストール
gem install jekyll bundler
```

このガイドに従って開発環境を構築することで、Windows上でのJekyll開発が効率的に行えます。
