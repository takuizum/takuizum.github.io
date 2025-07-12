# takuizum.github.io

## 概要

このリポジトリは、Jekyll静的サイトジェネレータを使用した研究・個人事業のWebサイトです。統計学、データサイエンス、プログラミングに関する情報を発信しています。

## 🚀 主要な機能

- **Jekyll静的サイトジェネレータ**: コンテンツ管理の効率化
- **レスポンシブデザイン**: モバイル・デスクトップ対応
- **SCSS**: モジュール化されたスタイル管理
- **自動デプロイ**: GitHub Actions による CI/CD
- **SEO最適化**: Jekyll SEO Tag プラグイン
- **RSS フィード**: 自動生成
- **検索機能**: 静的サイト対応

## 🏗️ 技術スタック

### フロントエンド
- **Jekyll 4.3+**: 静的サイトジェネレータ
- **Liquid**: テンプレートエンジン
- **SCSS**: CSS プリプロセッサ
- **ES6+ JavaScript**: モジュール化されたスクリプト

### 開発ツール
- **Bundler**: Ruby 依存関係管理
- **npm**: Node.js パッケージ管理
- **ESLint**: JavaScript リンター
- **Stylelint**: CSS/SCSS リンター
- **HTMLProofer**: HTML 検証

### CI/CD
- **GitHub Actions**: 自動ビルド・デプロイ
- **GitHub Pages**: ホスティング

## 📁 プロジェクト構造

```
takuizum.github.io/
├── _config.yml           # Jekyll 設定
├── _layouts/             # レイアウトテンプレート
│   ├── default.html
│   ├── home.html
│   ├── page.html
│   ├── post.html
│   └── publication.html
├── _includes/            # 再利用可能コンポーネント
│   ├── head.html
│   ├── header.html
│   ├── footer.html
│   └── scripts.html
├── _posts/               # ブログ記事
├── _publications/        # 出版・論文データ
├── _data/                # YAML データファイル
│   ├── updates.yml
│   └── services.yml
├── _sass/                # SCSS パーシャル
│   ├── _variables.scss
│   ├── _base.scss
│   ├── _layout.scss
│   ├── _components.scss
│   ├── _pages.scss
│   └── _responsive.scss
├── assets/
│   ├── css/
│   │   └── style.scss    # メインスタイルシート
│   ├── js/               # JavaScript モジュール
│   └── images/           # 画像ファイル
├── .github/workflows/    # GitHub Actions
├── Gemfile               # Ruby 依存関係
├── package.json          # Node.js 依存関係
└── README.md
```

## 🛠️ 開発環境のセットアップ

### 前提条件
- Ruby 3.1+
- Node.js 18+
- Bundler
- Git

### セットアップ手順

```bash
# リポジトリのクローン
git clone https://github.com/takuizum/takuizum.github.io.git
cd takuizum.github.io

# Ruby 依存関係のインストール
bundle install

# Node.js 依存関係のインストール
npm install

# 開発サーバーの起動
npm start
# または
bundle exec jekyll serve --watch --incremental
```

サイトは `http://localhost:4000` でアクセスできます。

### 利用可能なコマンド

```bash
# 開発サーバー（ドラフト記事含む）
npm run dev

# 本番ビルド
npm run build

# リンターの実行
npm run lint

# サイトのテスト
npm test

# クリーンビルド
npm run clean
```

## ✏️ コンテンツの管理

### ブログ記事の追加

`_posts/` ディレクトリに以下の形式でファイルを作成：

```markdown
---
layout: post
title: "記事タイトル"
date: YYYY-MM-DD
categories: [statistics, programming]
tags: [R, Python, ベイズ統計]
author: takuizum
excerpt: "記事の概要文"
---

記事の内容をMarkdownで記述
```

### 出版物の追加

`_publications/` ディレクトリに新しいファイルを作成：

```markdown
---
title: "論文タイトル"
type: journal
year: 2025
authors: ["takuizum", "共著者"]
journal: "学術誌名"
abstract: "論文の概要"
links:
  - label: "PDF"
    url: "リンクURL"
    icon: "fas fa-file-pdf"
---

詳細な説明（オプション）
```

### データの更新

- 最新情報: `_data/updates.yml`
- サービス情報: `_data/services.yml`

## 🎨 カスタマイズ

### デザインの変更

1. **色・フォント**: `_sass/_variables.scss` を編集
2. **レイアウト**: `_sass/_layout.scss` を編集
3. **コンポーネント**: `_sass/_components.scss` を編集

### 機能の追加

1. **新しいレイアウト**: `_layouts/` にファイルを追加
2. **コンポーネント**: `_includes/` にファイルを追加
3. **JavaScript機能**: `assets/js/` にモジュールを追加

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
