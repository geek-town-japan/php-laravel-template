# php-laravel-template

## 概要

Laravel + Nix + Vercel のスターターテンプレート  
PHP 8.5 / Laravel 12.x / Neon(PostgreSQL) / Docker(DBコンテナのみ) / GitHub Actions CI/CD / PHPUnit(単体・結合テスト) / Playwright(E2Eテスト) / Mago(Linter・Formatter)

## フォルダ構成

```sh
.
├── docs
│    └── ... # ドキュメント
├── README.md
└── .gitignore
```

## プロジェクト管理

- タスク管理: GitHub Projects / Issues
- 開発フロー: [GitHub Flow](https://docs.github.com/ja/get-started/using-github/github-flow/)
- PRテンプレート・Issueテンプレートの整備

## ブランチ戦略

| ブランチ | 用途 |
|---|---|
| `develop` | 開発環境 |
| `staging` | ステージング環境(検証環境) |
| `main` | 本番環境 |


- ブランチ保護: `develop` / `staging` / `main` へのマージはPR必須

---

### ブランチの規則

ブランチの一貫性と明確さを保つために、以下の規則を採用

※xxxはIssueの番号を指す
| ブランチ | 説明 |
|---|---|
| feat/issue-xxx | 機能追加等 |
| fix/issue-xxx | バグ修正や機能改善等 |
| refactor/issue-xxx | リファクタリング等 |
| ci/issue-xxx | 環境構築に関わる追加や修正等 |
| chore/issue-xxx | その他 |


---

### コミットメッセージの規則

コミットメッセージの一貫性と明確さを保つために、[Semantic Commit Message](https://sparkbox.com/foundry/semantic_commit_messages/) の規則を採用

:wrench: chore: (タスクファイルなどプロダクションに影響のない修正、実稼働のコードの変更は含めない)

    🔧 chore: デバッグ用のログを削除

:memo: docs: (ドキュメントの更新)

    📝 docs: API の使用方法を README に追記

:sparkles: feat: (ユーザー向けの機能の追加や変更)

    ✨ feat: ユーザープロフィール画面の追加

:bug: fix: (ユーザー向けの不具合の修正)

    🐛 fix: ログイン時のエラーハンドリングを修正

:recycle: refactor: (リファクタリングを目的とした修正)

    ♻️ refactor: 変数名を明確にするためのリファクタリング

:art: style: (スタイルやセミコロンの欠落などの修正、実稼働のコードの変更は含めない)

    🎨 style: コードのインデントを修正

:microscope: test: (テストコードの追加や修正、実稼働のコードの変更は含めない)

    🔬 test: 新規登録機能のユニットテストを追加

:construction_worker: ci: (環境構築に関わる追加や修正)

    👷 ci: バージョン変更に伴う Dockerfile の修正

## アーキテクチャ・技術スタック

- 言語: [PHP 8.5](https://www.php.net/)
- フレームワーク: [Laravel 12](https://github.com/laravel/framework/releases/)
- フロントエンド: [Blade テンプレート](https://laravel.com/docs/12.x/blade/) (React等のライブラリは使用しない)
- データベース: [Neon(PostgreSQL)](https://neon.com/)
- 認証: [Laravel Socialite(Google / Discord)](https://laravel.com/docs/12.x/socialite/)
  - Discord は [Socialite Providers](https://socialiteproviders.com/Discord/) を使用
- Linter / Formatter: [Mago](https://mago.carthage.software/)

## 開発環境

- ツールチェーン管理: [Nix](https://nix.dev/manual/nix/2.28/)
- コンテナ: DBコンテナ(PostgreSQL) のみ Docker で構築
  - アプリコンテナは作成しないかも? (Nix で環境を管理するため)
    - 悩み中
      - コンテナ内で完結するからいいけど、デプロイ先が Vercel だから、Vercel CLI でコマンド叩く必要がありそうだから、デプロイのためのコンテナを作る必要がありそう
      - そうしたときに、問題起きないか
      - Linter, Formatter もちゃんとマウント周りを設定しないと遅いかも
      - Nix で管理するんだったら、結局汚さず環境用意できるからわざわざアプリコンテナ作らなくてもいいんじゃないか？っていう気がしてる

---

### Nix で管理するツール

| ツール | 用途 |
|---|---|
| `php` | Laravel アプリの実行ランタイム |
| `composer` | PHP パッケージ管理 |
| `mago` | Linter / Formatter |
| `phpunit` | 単体・結合テストの実行 |
| `nodejs` | Playwright の実行ランタイム |
| `npm` | Node パッケージ管理 |
| `playwright` | E2E テストのブラウザ自動操作 |
| `docker` | DB コンテナの実行 |
| `docker-compose` | DB コンテナの構成管理 |
| `git` | バージョン管理 |
| `direnv` | `.env` 自動読み込み |


---

### 環境変数・シークレット管理

- `.env.example` をリポジトリに含める
- シークレットは GitHub Actions Secrets / Vercel Environment Variables で管理
- AI エージェントによる `.env` 読み込みリスクに対して、`sops` 等による暗号化を検討(秘密鍵は別管理)

## インフラ・デプロイ

- ホスティング: Vercel Hobby プラン([vercel-php](https://www.npmjs.com/package/vercel-php/) を使用)
  - [Laravel Example](https://github.com/contributte/vercel-examples/tree/master/php-lumen/)
- データベース: Neon (自動バックアップあり、要確認)
- 環境: ローカル / 開発 / ステージング / 本番(無料枠の制約によっては本番のみ)

---

### CI/CD (GitHub Actions)

1. テスト実行 (PHPUnit / Playwright)
2. Neon へのマイグレーション・シーダー実行
3. Vercel へデプロイ

> Vercel の実行時間制限(60秒)を超えていないか、テストで確認することを推奨

## Migration / Seeder 運用方針

### Migration

- 1 テーブル 1 ファイルで作成
- カラムの追加・変更は既存ファイルを編集せず、新規ファイルを作成
- ファイル名は変更内容がわかる命名にする(例: `create_users_table` / `add_provider_to_users_table`)
- `down()` メソッドを必ず実装し、ロールバックできる状態を保つ

---

### Seeder

- 環境別に `DevelopSeeder` / `StagingSeeder` / `ProductionSeeder` を用意
- Seeder は必ず Factory 経由で実装し、Seeder 自体はシンプルに保つ
  - Factory 経由にすることで、テストでの再利用・状態バリデーションが容易になる

## テスト

| 種別 | ツール |
|---|---|
| 単体テスト (Unit Test) | PHPUnit |
| 結合テスト (Feature Test) | PHPUnit |
| 総合テスト > E2E テスト | Playwright |


- Google / Discord 等の外部サービスはモック化(必要に応じてモックサーバーを用意)
- テストカバレッジの目標値を事前に設定する

## セキュリティ

- CSRF 保護: Laravel デフォルト機能を使用
- XSS 対策: Blade の `{{ }}` エスケープを徹底
- 認証・認可: ルートレベルで Middleware を適用し、適用漏れを防止
- 脆弱性検知: Dependabot によるライブラリの自動検知

## 監視・運用

- エラーモニタリング / ログ管理: Sentry (無料枠: エラー 5,000 件 / 月)
- データベースバックアップ: Neon の自動バックアップを利用(詳細要確認)
- ※ Vercel はファイル書き込み不可のため、ログはすべて外部サービスへ送信

## ドキュメント

- README
- 環境構築マニュアル
- 開発マニュアル
- ER 図
- アーキテクチャ構成図(作成検討中)

## Mago
PHPの静的解析・フォーマッターツール。

### 設定方針

| 項目 | 設定値 | 理由 |
|------|--------|------|
| Source code paths | `src` | Laravelのソースコード |
| Dependency paths | `vendor` | Composerの依存パッケージ |
| Paths to exclude | `storage,bootstrap/cache` | キャッシュ・ログ等の自動生成ファイル。`bootstrap/app.php` はエントリポイントなので解析対象に含める |
| Formatter preset | Pint preset | LaravelプロジェクトのコーディングスタイルはLaravel Pintが標準 |
| Analyzer plugins | なし | PSL・Flow-PHP・PSR-11はいずれも本プロジェクトで使用しないパッケージ |
| Strictness | Strict | 新規プロジェクトのため最初から厳しい設定にし、技術的負債を防ぐ |
