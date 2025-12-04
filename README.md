# 予定調整くん (Schedule Arranger)

複数人の予定を調整して、最適な会議時間を見つけるアプリケーション

## 概要

予定調整くんは、複数の候補日時の中から参加者の空き状況を入力し、全員が参加できる最適な時間帯を調整できるNode.js Webアプリケーションです。GitHub認証に対応しており、セキュアな予定管理が可能です。

## 主な機能

- **予定の作成・管理**: 会議の候補日時を設定して予定を作成
- **空き状況の登録**: 各参加者が候補日時での空き状況を入力
- **GitHub認証**: GitHubアカウントでセキュアにログイン
- **コメント機能**: 予定に対してコメントを追加可能

## 技術スタック

### バックエンド
- **Express.js** 4.16.0 - Webフレームワーク
- **Node.js** 16.14.2+
- **PostgreSQL** 14.2 - データベース
- **Sequelize** 6.5.0 - ORM

### フロントエンド
- **Pug** 3.0.2 - テンプレートエンジン
- **Bootstrap** 5.1.3 - UIフレームワーク
- **jQuery** 3.4.1 - JavaScriptライブラリ
- **Webpack** 5.69.1 - バンドラ
- **Babel** 7.17.5 - トランスパイラ

### 認証・セキュリティ
- **Passport.js** 0.3.2 - 認証ミドルウェア
- **passport-github2** 0.1.9 - GitHub戦略
- **helmet** 4.6.0 - セキュリティヘッダー
- **express-session** 1.13.0 - セッション管理
- **csurf** 1.8.3 - CSRF対策

### その他
- **morgan** - HTTPロギング
- **dayjs** 1.10.4 - 日付操作
- **uuid** 8.3.2 - UUID生成

## プロジェクト構成

```
.
├── app.js                 # Express アプリケーション主要設定
├── bin/
│   └── www               # サーバー起動ファイル
├── models/               # Sequelizeモデル定義
│   ├── user.js          # ユーザーモデル
│   ├── schedule.js      # 予定モデル
│   ├── candidate.js     # 候補日時モデル
│   ├── availability.js  # 空き状況モデル
│   ├── comment.js       # コメントモデル
│   └── sequelize-loader.js # Sequelize設定
├── routes/              # ルーター定義
│   ├── index.js
│   ├── login.js
│   ├── logout.js
│   ├── schedules.js
│   ├── availabilities.js
│   ├── comments.js
│   └── authentication-ensurer.js
├── views/               # Pugテンプレート
│   ├── layout.pug
│   ├── index.pug
│   ├── login.pug
│   ├── new.pug
│   ├── edit.pug
│   ├── schedule.pug
│   └── error.pug
├── public/              # 静的ファイル
│   └── javascripts/
│       └── bundle.js    # Webpack出力
├── app/
│   └── entry.js         # Webpackエントリーポイント
├── docker-compose.yml   # Docker設定
├── Dockerfile           # Node.jsコンテナ定義
└── db.Dockerfile        # PostgreSQLコンテナ定義
```

## セットアップ

### 必要なもの

- Docker & Docker Compose
- Node.js 14以上（ローカル開発の場合）
- PostgreSQL（ローカル開発の場合）

### Docker Composeでの実行

```bash
docker-compose up --build
```

- アプリケーション: http://localhost:3000
- PostgreSQL: localhost:5432

### ローカル開発での実行

```bash
# 開発環境の場合、PostgreSQLが必要です
# Dockerで別途起動するか、ローカルにインストール

npm install
npm start
```

## 使用方法

### アプリケーションの起動

```bash
npm start
```

サーバーはデフォルトでポート3000で起動します。

### テストの実行

```bash
npm test
```

## GitHub認証の設定

1. GitHubで新しいOAuthアプリケーションを作成
2. 以下の情報を環境変数として設定:
   - `GITHUB_CLIENT_ID`: クライアントID
   - `GITHUB_CLIENT_SECRET`: クライアントシークレット
   - `HEROKU_URL`: Herokuデプロイ時のアプリケーションURL

## 主要機能の説明

### ユーザー認証
- GitHub OAuthで認証
- ユーザー情報をデータベースに保存
- セッション管理でログイン状態を維持

### 予定の作成
- 会議のタイトルと開催候補日時を設定
- 参加者を招待

### 空き状況の入力
- 候補日時ごとに「○（参加可）/ △（可能性あり）/ ×（参加不可）」を入力
- リアルタイムで集計

### コメント機能
- 予定に対するコメント投稿
- 参加者間での議論が可能

## セキュリティ機能

- **CSRF対策**: csurf で CSRF トークン保護
- **セッションセキュリティ**: express-session で安全なセッション管理
- **セキュリティヘッダー**: helmet でセキュリティヘッダーを追加
- **オープンリダイレクト対策**: ログイン後のリダイレクト先検証

## デプロイ

### Herokuへのデプロイ

> **注意**: Herokuは2022年11月に無料プランを廃止しました。このプロジェクトは現在Herokuでのデプロイはできません。

### 参考: 従来のHerokuデプロイ手順（アーカイブ）

```bash
# 以下は参考までのアーカイブです。Herokuは有料プランのみになりました
heroku create your-app-name
heroku config:set GITHUB_CLIENT_ID=your_client_id
heroku config:set GITHUB_CLIENT_SECRET=your_client_secret
git push heroku main
```

## トラブルシューティング

### ポートが既に使用されている場合
```bash
PORT=3001 npm start
```

### データベース接続エラー
- PostgreSQL が起動しているか確認
- 環境変数 `DATABASE_URL` の設定を確認

### 認証が失敗する場合
- GitHub OAuth設定を確認
- `GITHUB_CLIENT_ID` と `GITHUB_CLIENT_SECRET` が正しく設定されているか確認

## 開発環境の注意事項

このアプリケーションはローカル開発環境で実行可能なように構成されています。

- ローカル開発時: `postgres://postgres:postgres@db/schedule_arranger`
- 本番環境（Heroku）: `DATABASE_URL` 環境変数から接続情報を取得
