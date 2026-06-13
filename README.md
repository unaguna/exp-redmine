
## 手順

### Redmine OAuth plugin 設定例

[Redmine OAuth plugin](https://github.com/kontron/redmine_oauth) を使用する際の設定内容。ここでは、Google Workspace のアカウントでログインする例で設定を記載します。

#### Google Workspace

1. Google Cloud でプロジェクトを作成 or 選択
2. API とサービス -> OAuth 同意画面 で必要項目を登録
    - User Type: Internal
3. API とサービス -> 認証情報 -> 認証情報を作成 -> OAuth クライアント ID で必要項目を入力しクライアントIDとクライアント秘匿情報を発行
    - アプリケーションの種類: Web application
    - Authorized redirect URI: http(s)://redmineのドメイン名/oauth2callback

#### redmine プラグイン設定

- ユーザーによるアカウント登録: Automatic activation for listed email domains only
- Allowed domains (comma-separated): GWSのドメイン名
- Hide login form: OFF (GWSアカウントに管理者権限を付与した後は、adminでのログインが不要になるのでONにする)
- 更新: ログインID、名、姓
- OAuth logout: OFF
- OAuth login: ON
- OAuth-only login: OFF

#### OAuth providers 設定

- Provider: Google
- 名称: Google (なんでもいい)
- Site: デフォルト (https://accounts.google.com)
- Client ID: Google Cloud で発行したもの
- Client secret: Google Cloud で発行したもの
- Identify user by: email


## 参考

- [Redmine.JP Blog](https://blog.redmine.jp/articles/6_1/redmine-6_1-docker/)
- [打ち捨てられていたRedmineが復活するまでの軌跡 - Qiita](https://qiita.com/y_hokkey/items/44cae35f4a3f359f5c25)