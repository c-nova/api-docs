# 認証

## 概要

Eagle Eye APIにアクセスするには2ステージのプロセスが必要です： クライアントは初めに使い捨ての認証トークンを取得するために証明書とレルムを示します。この使い捨てトークンは発行されて30秒間または使用されるまで有効です。一度認証トークンを取得した場合は、リソースへのアクセスを行うためのセッションID ("auth-key"クッキーを通じて)を認可サービスを呼び出して利用しなければなりません。この2つのフェーズの手法は、複数のドメインで認証と操作を行うことを提供します。この最初のステップは認証することで完了します。次のステップは認可することで完了します。認証コールはHTTPS接続を使用する必要があることに注意してください。

一度認可コールによって "auth_key" クッキーを取得すると、引き続きAPIをコールするために2つの方法でセッションIDを使用することができます。最初は全てのAPI要求に対して "auth_key" クッキーを単純に渡す方法です。2つ目は"auth_key" クッキーの値を "A" パラメータとして渡す方法です。"A" パラメータはあらゆるメソッド(GET, PUT, POST, DELETE)で使用することが可能です。セッションIDを検索する優先順位は以下のとおりです：

1. 全てのメソッド(GET, PUT, POST, DELETE) のクエリ文字列に含まれる "A" パラメータ
2. POSTデータ内の "A" パラメータ
3. 要求ボディ(PUTなど)に含まれる "A" パラメータ
4. "auth_key" クッキー

ステータス・コードはすべて優先順位でリストされます。最初にリストされたものは、それぞれの条件が満たされる場合に返されたものを意味します。また最後にリストされたものは、それ以前のコードの条件のどれにも合致しなかったことを意味します。

<!--===================================================================-->
## ステップ 1: 認証
> 要求

```shell
curl -v --request POST https://login.eagleeyenetworks.com/g/aaa/authenticate --data-urlencode "username=[USERNAME]" --data-urlencode "password=[PASSWORD]"
```

> Json応答

```json
{
  "token": "O3k0hNH3jQgjaxC0bLG9/5cM+Z7eWdPe0c+UpEZNXOs7PTFH45Dr9M3wxLkP6GjcPuCw8lXVTkHGA1zgx/q44HBv3Xmcj4/XzN2f6Hv+mZVIy8LorX8N5a6fNVRknWWW86nCHfbLvOP6TPcmBP1dD10ynnGeAdlQHTqMN5mvKH24WwZgVFbM4DyhyWu+eTN+t1XNROegJdZRjhaYCZ1FVKkdnrlsrMD6JSr/tE7byCLVjPcwzVabA+x0tDbGipystTNYPZyDVr3DQM70SV6kfqg2irlC8/zDu7a2EhI1IQWuZZ2GQIQm5jBtj9UR/p7ainHVhEc/bSFYUCvziepcAa=="
}
```

ログインは2ステップのプロセスがあります：認証と認証時に返されたトークンを使用した認可です。

### HTTPリクエスト

`POST https://login.eagleeyenetworks.com/g/aaa/authenticate`

パラメータ   	| データ形式
---------   	| ----------- 
**username** 	| 文字列     
**password** 	| 文字列    

### エラー ステータス コード

HTTP ステータス コード    | データ形式
---------           | ----------- 
400 | いくつかの引数が不足しているか不正です
401 | 与えられた認証情報が不正です
402 | アカウントは休止中です
460 | アカウントは非アクティブです
461 | アカウントは保留中です
412 | アカウントは無効です
462 | ユーザーは保留中です。これはユーザー名が正しく、アカウントがアクティブな際に 401 の前に投げられます。
200 | ユーザーが認証されました。ボディにはJSON形式の結果が含まれます

<!--===================================================================-->
## Step 2: 認可

> 要求

```shell
curl -D - --request POST https://login.eagleeyenetworks.com/g/aaa/authorize --data-urlencode token=[TOKEN]
```

> Json応答

```json
{
    "is_sms_include_picture": 0,
    "last_name": "",
    "uid": " ",
    "is_export_video": 1,
    "layouts": [
        "217f0fd4-450f-11e4-a983-ca8312ea370c"
    ],
    "account_map_lines": null,
    "postal_code": null,
    "is_account_superuser": 1,
    "timezone": "US/Pacific",
    "active_brand_subdomain": "c001",
    "sms_phone": null,
    "city": null,
    "first_name": null,
    "user_id": "ca0e1cf2",
    "is_notify_enable": 1,
    "owner_account_id": "00004206",
    "json": "{}",
    "id": "ca0e1cf2",
    "is_superuser": 0,
    "state": null,
    "last_login": "20141006173752.672",
    "is_recorded_video": 1,
    "camera_access": [
        [
            "1005f2ed",
            "r"
        ],
        [
            "100bd708",
            "r"
        ]
    ],
    "notify_period": [
        "0-0000-2359",
        "1-0000-2359",
        "2-0000-2359",
        "3-0000-2359",
        "4-0000-2359",
        "5-0000-2359",
        "6-0000-2359"
    ],
    "email": "john.doe@fakeemail.com",
    "utc_offset": -25200,
    "mobile_phone": null,
    "street": [],
    "notify_rule": [
        "one-email-0"
    ],
    "is_active": 1,
    "is_user_admin": 1,
    "phone": null,
    "is_layout_admin": 1,
    "is_live_video": 1,
    "is_device_admin": 1,
    "is_branded": 1,
    "alternate_email": null,
    "active_account_id": "00004206",
    "access_period": [],
    "is_staff": 0,
    "country": "US",
    "is_master": 0,
    "is_pending": 0


}
```

認可はログイン プロセスの2ステップ目で、最初のステップ(認証)で作成されたトークンを使用します。この応答はユーザーオブジェクトの認可を行い、'auth_key'クッキーに設定します。この後に実行するAPIコールでは、可能であればクッキー、またはクッキー内の値を 'A' パラメータとしての、いずれかの方法で送信します。

APIコールを行うホストURLはオリジナルの  "https://login.eagleeyenetworks.com" に対して行いますが、APIは認可後に返される **ブランド サブドメイン** に対して実行しなければなりません。ブランドホストURLは "https://[アクティブなブランド サブドメイン].eagleeyenetworks.com" となり、**アクティブなブランド サブドメイン** フィールドは認可の応答で返されます。

認可後の例が右側に表示されていますが、ホストURLは "https://c001.eagleyenetworks.com" に変更されています。

それぞれのアカウントは常に同じ **ブランド サブドメイン** が使用され、同様に同一セッション中も変更されません。
サブドメインのキャッシュは、認可後の active_brand_subdomain に対してクライアント ソフトウェアの確認をより長期間にすることで安全に保ちます。
**ブランド サブドメイン**を使用することは、速度と頑健性上重要です。


### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/authorize`

パラメータ   | データ形式
---------	| -----------   
**token**   | 文字列

### エラー ステータス コード

HTTP ステータス コード    | データ形式
----------           | ----------- 
400 | いくつかの引数が不足しているか不正です
401 | 不正なトークンが渡されました
200 | ユーザーはレルムに対してのアクセスを認可されました
