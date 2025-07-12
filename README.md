# takuizum.github.io

## 概要

このリポジトリは、研究・個人事業のWebサイトです。統計学、データサイエンス、プログラミングに関する情報を発信しています。

## サイトの特徴

- **レスポンシブデザイン**: スマートフォン、タブレット、デスクトップに対応
- **モダンなUI**: 美しく使いやすいインターフェース
- **最新情報の更新**: トップページに最新の更新情報を表示
- **検索・フィルター機能**: ブログ記事や出版物の検索が可能

## サイト構成

- **トップページ** (`index.html`): 最新の更新情報と提供サービスの紹介
- **自己紹介** (`profile.html`): 経歴、スキル、実績の詳細
- **出版・論文** (`publications.html`): 研究成果の一覧とフィルター機能
- **ブログ** (`blog.html`): 技術記事とチュートリアル

## 技術スタック

- **HTML5**: セマンティックなマークアップ
- **CSS3**: モダンなスタイリング（Grid、Flexbox、アニメーション）
- **JavaScript**: インタラクティブな機能
- **Font Awesome**: アイコン
- **Google Fonts**: Noto Sans JP フォント

## カスタマイズ方法

### 個人情報の更新

1. **プロフィール情報**: `profile.html` の内容を編集
2. **連絡先情報**: 全ページのフッターとコンタクトセクションを更新
3. **SNSリンク**: GitHubアカウント以外のリンクを追加

### コンテンツの追加

1. **更新情報**: `script.js` の `updates` 配列に新しい項目を追加
2. **ブログ記事**: `blog.js` の `blogPosts` 配列に新しい記事を追加
3. **出版物**: `publications.html` に新しい項目を追加

### スタイルのカスタマイズ

- `styles.css` でカラーテーマやフォントを変更
- CSS変数を使用して統一されたデザインを維持

## 開発・デプロイ

### ローカル開発

```bash
# リポジトリのクローン
git clone https://github.com/takuizum/takuizum.github.io.git

# ディレクトリに移動
cd takuizum.github.io

# ローカルサーバーで確認（例：VS Code Live Server）
```

### GitHub Pagesでの公開

1. GitHubリポジトリの設定でPages機能を有効化
2. Source: Deploy from a branch → main
3. 変更をpushすると自動的にサイトが更新されます

## ファイル構成

```
takuizum.github.io/
├── index.html          # トップページ
├── profile.html        # 自己紹介ページ
├── publications.html   # 出版・論文ページ
├── blog.html          # ブログページ
├── styles.css         # メインスタイルシート
├── script.js          # メインJavaScript
├── publications.js    # 出版・論文ページ用JS
├── blog.js           # ブログページ用JS
└── README.md         # このファイル
```

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## お問い合わせ

ご質問やご提案がございましたら、[GitHub Issues](https://github.com/takuizum/takuizum.github.io/issues)またはメールでお気軽にお問い合わせください。
