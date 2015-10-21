# はじめに

Eagle Eye ビデオAPIは録画やインデックス化、カメラ動画の保管を包括的にサポートするRESTベースのAPIです。
Eagle Eye ビデオAPIはカメラに関連する動画の録画やクラウドへのセキュアなビデオ転送、動画保管、自分のアプリケーションで利用するための動画作成など、負荷の高い作業を取り扱います。
Eagle Eye セキュリティ カメラ VMSのユーザーインターフェース（Web、iOS、Android）は、全てこのAPIを使用して作られています。

私たちはcURLを言語バインディングとしているので、右側のダークグレーのエリアにcURLコードのサンプルが表示されます。また将来的な拡張としては右上のタブでプログラム言語を切り替えることが可能です。

## はじめよう

Eagle Eye ビデオAPIはセキュアな録画、管理、様々なカメラからの動画再生をどこからでも、いつでも実行できます。
強力なアノテーション インターフェイスと高機能な帯域幅管理は、テラバイトの生動画を役に立つデータに変えることができます。

このAPIはREST原理に基づいているため、非常に簡単にアプリケーションの記述とテストが可能です。ブラウザでURLにアクセスすることもでき、また他のプログラム言語のように多くの異なるHTTPクライアントを使うことが可能です。

## APIキーを手に入れる
[開発者アカウントを作成](https://login.eagleeyenetworks.com/api_signup.html)

Eagle Eye ビデオAPIを使いはじめるにはAPIキーが必要になります。これはあなた自身とあなたのアプリケーションを識別するために使われます。APIキーを使うことで全てをセキュアにすることもできます。APIキーを入手するにはアカウント（どこかでテストを行うために）が必要になります。アカウントは既存のアカウントでも、作成した開発者アカウントでも利用可能です。既存のアカウントを使う場合には、アカウント設定からAPIキーを作成できます。

開発者アカウントを作成するにはeメールアドレスの認証が必要です。APIキーの作成を依頼するとeメールでショートカットが送られます。ショートカットのリンクをクリックすることでAPIキーが作成され、コードの作成が可能になります。

場合によっては私達から開発用ハードウェアキット（カメラを接続するために必要です）を購入したいと思うかもしれません。開発者には大幅な値引きが可能です。これにより開発とテスト用にEagle Eyeブリッジとカメラを私たちから入手することができますので、eメールでより詳しい情報と価格をお尋ねください。

APIキーはヘッダの"認証"キーの下部にコロン付きで記述される必要があります。

**注意：ユーザー パスワードによる認証は引き続き必要です**。パスワードによる認証の代替手段については[シングル・サインオン](#single-sign-on)セクションを御覧ください。

> リクエスト

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X PUT -v -H "Authentication: [API_KEY]:" -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/user -d '{"first_name": "[FIRST_NAME]", "last_name": "[LAST_NAME]", "email": "[EMAIL]"}'
```

> Jsonレスポンス

```json
{
    "id": "ca0ffa8c"
}
```


### 画像によるステップ説明

![alt text](introduction/apikey_1.png "Step 1")
![alt text](introduction/apikey_2.png "Step 2")
![alt text](introduction/apikey_3.png "Step 3")
![alt text](introduction/apikey_4.png "Step 4")
![alt text](introduction/apikey_5.png "Step 5")
