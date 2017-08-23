# 認証

## 概要

Eagle Eye APIにアクセスするには2ステージのプロセスが必要です： クライアントは初めに使い捨ての認証トークンを取得するために証明書とレルムを示します。この使い捨てトークンは発行されて30秒間または使用されるまで有効です。一度認証トークンを取得した場合は、リソースへのアクセスを行うためのセッションID ("auth-key"クッキーを通じて)を認可サービスを呼び出して利用しなければなりません。この2つのフェーズの手法は、複数のドメインで認証と操作を行うことを提供します。この最初のステップは認証することで完了します。次のステップは認可することで完了します。認証コールはHTTPS接続を使用する必要があることに注意してください。

上記の単純な認証方法に加えて、**2要素認証**（**Two-Factor Authentication = TFA**）として知られているより安全な認証方法も使用できます。TFAは、2つの異なるコンポーネントの組み合わせを利用してユーザーの身元を確認する方法です。第1のコンポーネントはユーザのパスワードであり、第2のコンポーネントは別の通信チャネルを介してユーザに配信される1回限りのTFAコードであり、電子メールまたはユーザの携帯電話に送信されるテキストメッセージを介して利用されます。

特定のユーザのログインに対してシンプルまたは2要素認証方式が使用されるかどうかは、システム内でのそのユーザに対しての設定によって決まります。ただし、アカウント管理者は、特定のアカウントのすべてのユーザーにTFAスキームを使用させることも可能です

TFA方式が使用されている場合、認可コールは、認証コールから取得されたトークンに加えてTFAコードが渡されることを想定します

一度認可コールによって `'auth_key'` クッキーを取得すると、引き続きAPIをコールするために2つの方法でセッションIDを使用することができます。最初は全てのAPI要求に対して `'auth_key'` クッキーを単純に渡す方法です。2つ目は `'auth_key'` クッキーの値を `'A'` パラメータとして渡す方法です。`'A'` パラメータはあらゆるメソッド(GET, PUT, POST, DELETE)で使用することが可能です。セッションIDを検索する優先順位は以下のとおりです：

1. 全てのメソッド(GET, PUT, POST, DELETE) のクエリ文字列に含まれる "A" パラメータ
2. POSTデータ内の "A" パラメータ
3. 要求ボディ(PUTなど)に含まれる "A" パラメータ
4. "auth_key" クッキー

ステータス・コードはすべて優先順位でリストされます。最初にリストされたものは、それぞれの条件が満たされる場合に返されたものを意味します。また最後にリストされたものは、それ以前のコードの条件のどれにも合致しなかったことを意味します。

<!--===================================================================-->
## ステップ 1: 認証

ログインは、単純な認証では2段階の、TFAを使用した場合には3段階のプロセスで行われます

***単純方式:***

認証し、認証によって返されたトークンで認可します

***TFA 方式:***

認証し、システムにTFAコードをユーザーに送信するよう指示し、ステップ1から受け取ったトークンとステップ2から受け取ったTFAコードを使用して認可します

> 要求

```shell
curl -v --request POST https://login.eagleeyenetworks.com/g/aaa/authenticate --data-urlencode "username=[USERNAME]" --data-urlencode "password=[PASSWORD]"
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/aaa/authenticate`

パラメータ     | データ形式   | 必須？
---------    | --------- | -----------
**username** | 文字列     | true
**password** | 文字列     | true

> JSON 応答 (単純認証)

```json
{
    "token": "O3k0hNH3jQgjaxC0bLG9/5cM+Z7eWdPe0c+UpEZNXOs7PTFH45Dr9M3wxLkP6GjcPuCw8lXVTkHGA1zgx/q44HBv3Xmcj4/XzN2f6Hv+mZVIy8LorX8N5a6fNVRknWWW86nCHfbLvOP6TPcmBP1dD10ynnGeAdlQHTqMN5mvKH24WwZgVFbM4DyhyWu+eTN+t1XNROegJdZRjhaYCZ1FVKkdnrlsrMD6JSr/tE7byCLVjPcwzVabA+x0tDbGipystTNYPZyDVr3DQM70SV6kfqg2irlC8/zDu7a2EhI1IQWuZZ2GQIQm5jBtj9UR/p7ainHVhEc/bSFYUCvziepcAa=="
}
```

> Json 応答 (2要素認証)

```json
{
    "token": "MiDUwMQqwP1JsfKqbqT1DQ8hJFHEOZfROEUtBvnuqv0ICxvcOybkS1n9/awjrJ9YKijb60GqdUDPP8TW4o8Ei8iI8OXC/dj74KC2cLMxJ2vs/hmYPfbW8OpCwf0k683a2LfIbjcC3Uy/SmDpOsxVdPMTXQEGJHXD3ItmAvoQ5MOoRKfHBNOu7OJBWQjPUjeP0fkHSrx8JgAHSqT5SwRM0mLysFmiFHF0h7/5Apt81dDhZwLBDwwSrl+kTqgn+wnw6rJ432liESdK+yp3Qefk1wAtytoTJkkBE2srqsHJdW4ryVYKk9SKA62Cz7pO3VUaD8Yxx9Ff2Os9ez6TdfBmqg==",
    "two_factor_authentication_code":
    {
        "sms": "*** *** 779",
        "email": "***********@gmail.com"
    }
}
```

### HTTP 応答 (JSON 属性)

応答パラメータ                    | データ形式   |  詳細
-------------------            | --------- | ------------
token                          | 文字列     | 認可で使用されるトークン
two_factor_authentication_code | Json dictionary with two keys:<br/>**sms** - scrubbed user's SMS number,<br/>**email** - scrubbed user's e-mail address (present in response only if TFA scheme is being used). | Code required to complete the Two-Factor Authentication

***注記 1:***

トークンは以下の時間で期限が切れます:

  - 単純認証の場合は *30 秒*
  - 2要素認証の場合は *15 分*

***注記 2:***

TFA方式の場合、システムは[ユーザー モデル](＃user-model) のパラメータ `'sms_phone'` を使用します。
SMSベースの認証を使用する場合、そのパラメータはユーザの作成時に指定する必要があります（[ユーザーの作成](＃create-user) を参照））
ユーザーのパラメータ `'sms_phone'` が設定されていない場合、 **sms** キーの値は `'No sms phone found'` になります

***注記 3:***

TFA関連のユーザ データ（すなわちSMS電話またはEメール）は、ユーザのアカウント作成時に一度設定されると、そのユーザだけが変更することが可能です。この部分の変更は、TFAで認証で使用されます。アカウントのスーパーユーザーは、セキュリティ上の理由からこの部分のデータを変更することはできません

### エラー ステータス コード

HTTP ステータス コード | 詳細
---------------- | -----------
400 | いくつかの引数が不足しているか不正です
401 | 与えられた認証情報が不正です
402 | アカウントは休止中です
460 | アカウントは非アクティブです
461 | アカウントは保留中です
412\*	| アカウントは無効です
462 | ユーザーは保留中です。これはユーザー名が正しく、アカウントがアクティブな際に 401 の前に投げられます。
200 | ユーザーが認証されました。ボディにはJSON形式の結果が含まれます

\* TFAを使用し、TFAコードを使用して3回以上失敗したためにユーザーのアカウントがロックされている場合は、コード412も返されます



<!-- TODO: verify whether the list above is complete==-->

<!--===================================================================-->
## ステップ 2: TFA コードの送信 (TFA方式使用時のみ)
<!--===================================================================-->

このステップは、ユーザログインにTFA方式が使用されている場合にのみ実行されます（つまり認証コールが応答で `'two_factor_authentication_code'` キーを返した場合）
それ以外の場合は、ステップ3：認可 に進んで下さい

> リクエスト（単純認証）

```shell
curl -D - --request POST https://login.eagleeyenetworks.com/g/aaa/two_factor_authenticate --data-urlencode "token=[TOKEN]" "two_factor_authentication_type=sms"
```

```shell
curl -D - --request POST https://login.eagleeyenetworks.com/g/aaa/two_factor_authenticate --data-urlencode "token=[TOKEN]" "two_factor_authentication_type=email"
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/aaa/two_factor_authenticate`

パラメータ  | データ形式   | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**token** | 文字列     | ステップ 1 で受け取ったトークンは | true
**two_factor_authentication_type** | 文字列    | TFA 形式 (`'sms'`  または `'email'` のいずれか) | true

### HTTP 応答

この API コールは応答時にデータを返しません

***注記 1:***

TFA コードは *15 分* で期限が切れます

### 応答状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400 | いくつかの引数が不足しているか不正です
412	| 選択したTFAタイプのTFAコードを送信できません
415	| 指定されたTFAタイプはサポートされていません
200	| 要求は成功しました（TFAコードがユーザーに送信されました）

<!--===================================================================-->
## Step 3: 認可
<!--===================================================================-->

認可はログイン プロセスの最終ステップで、最初のステップ(認証)で作成されたトークンを使用します。もし TFA方式を使用している場合には、TFAコードがEメールまたはSMSによってユーザーに送信されています
この応答はユーザーオブジェクトの認可を行い、`'auth_key'` クッキーに設定します。この後に実行するAPIコールでは、可能であればクッキー、またはクッキー内の値を `'A'` パラメータとしての、いずれかの方法で送信します。
TFA方式を使用している場合には、このコールはクッキーに `'tfa_key'` も設定します。このクッキーの詳細については、**認証済みデバイス** の項目を参照して下さい。

APIコールはオリジナルの "https://login.eagleeyenetworks.com"（ホストURL） に対して行いますが、APIは認可後に返される **ブランド サブドメイン** に対して実行しなければなりません。ブランドホストURLは "https://[アクティブなブランド サブドメイン].eagleeyenetworks.com" となり、**アクティブなブランド サブドメイン** フィールドは認可の応答で返されます。

たとえば右側の応答例では、承認後のホストのURLを `'https://c001.eagleyenetworks.com'` に変更する必要があります

それぞれのアカウントは常に同じ **ブランド サブドメイン** が使用され、同様に同一セッション中も変更されません。
サブドメインのキャッシュは、認可後の active_brand_subdomain に対してクライアント ソフトウェアの確認をより長期間にすることで安全に保ちます。**ブランド サブドメイン** を使用することは、速度と頑健性上重要です。

> 要求 (単純認証方式)

```shell
curl -D - --request POST https://login.eagleeyenetworks.com/g/aaa/authorize --data-urlencode "token=[TOKEN]"
```

> 要求 (TFA方式)

```shell
curl -D - --request POST https://login.eagleeyenetworks.com/g/aaa/authorize --data-urlencode "token=[TOKEN]" "two_factor_authentication_code=[TFA_CODE]"
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/aaa/authorize`

パラメータ  | データ形式   | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**token** | 文字列     | ステップ 1 で受け取ったトークン | true
two_factor_authentication_code | 文字列    | 4桁の数字 <br/>TFA方式時のみに使用されます（単純認証で許可する場合は使用されません）

***注記 1:***

TFAコードによる認証に3回以上失敗すると、ユーザーのアカウントがロックされます。 Eagle Eyeのテクニカルサポート担当者のみがロックを解除することが可能です
ユーザーのアカウントがロックされると、ユーザーはこの事象をEメールで通知されます

> JSON 応答

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

### HTTP 応答 (JSON 属性)

When successful, this API call returns Json data structure following the [User Model](#user-model)
成功すると、このAPI呼び出しは [ユーザー モデル](＃user-model) に準じたJSONデータ構造を返します。

### エラー状態コード

**単純認証方式使用時**

HTTP 状態コード    | 詳細
---------------- | -----------
400	| いくつかの引数が不足しているか不正です
401	| 無効なトークンが提供されました
200	| ユーザーはそのレルムへのアクセスを許可されました

**TFA方式使用時**

HTTP 状態コード    | 詳細
---------------- | -----------
400	| いくつかの引数が不足しているか不正です
401	| トークンが無効か、TFAコードが見つからないか、有効期限が切れたTFAコードで認証しようとしました
406	| 無効なTFAが提供されたか、無効なTFAと無効なトークンが提供されました
429	| このユーザーのアカウントは、認証を3回以上失敗したためにロックされました
200	| ユーザーはそのレルムへのアクセスを許可されました

<!--===================================================================-->
## TFA方式の強制化とオプション時の違い
<!--===================================================================-->

ユーザーが所属するアカウントに対してTFAを実施するかどうかに応じて、ユーザーは将来、ログイン用にTFAではなく単純認証を選択できる場合があります
アカウントがTFAを強制するかどうかを調べるには、[アカウントの取得](＃get-account) API呼び出しによって返されたアカウントレコードの `'is_two_factor_authentication_forced'` フラグを調べます

このフラグは、アカウントのスーパーユーザーが[アカウントの更新](＃update-account) API呼び出しを使用して設定またはクリアすることができます
`'is_two_factor_authentication_forced'` が0に設定されている場合、ユーザーは単純認証方式に切り替えることができます
これはユーザーレコードの `'is_two_factor_authentication_enabled'` フラグをクリアすることで実現されます
これはアカウントのスーパーユーザーではなく、ユーザー自身によってのみ実施可能です
ユーザレコード内のTFA関連フィールドの更新は、専用のTFAアップデートエンドポイント `'/g/aaa/two_factor_authenticate/update'` によって実行されます。次のセクションを参照してください

<!--===================================================================-->
## TFAの更新
<!--===================================================================-->

ユーザーレコードに存在するTFA方式に影響を及ぼすデータは、セキュリティ上重要であるため、操作自体がTFAで保護されている専用のエンドポイントを使用してのみ変更することができます
このデータは、以下の3つのフィールドを持つユーザー モデルで構成されます：

フィード | 詳細         | 備考     | 必須？
------ | ----------- | ------- | -----------
**sms_phone** | TFAコードを含むテキストメッセージ（SMS）が配信される電話番号 | TFAコードの配信にSMSを使用する場合にのみ変更可能<br/>コードは新しい電話番号に配信されます | true
**email** | TFAコードを含むメッセージが配信される電子メールアドレス| TFAコードの配信に電子メールを使用する場合にのみ変更可能<br/>コードは新しい電子メールアドレスに配信されます | true
**is_two_factor_authentication_enabled** | 1 - ユーザーはTFAで認証される必要があります <br/> 0 - ユーザーは単純な方式で認証されます | TFAコードはSMSまたは電子メール配信で更新可能 | true

上記のフィールドは一度に1つずつしか変更できません

TFAの更新は2段階のプロセスです：

### 1. 更新の要求

この手順は、TFAデータ更新プロセスを開始します

#### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/aaa/two_factor_authenticate/update`

パラメータ  | データ形式   | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**two_factor_authentication_type** | `'sms'` または `'email'` | この更新要求を確認するためにTFAコード配信に使用するメソッドを定義します | true
**password** | 文字列 | ユーザーのパスワード | true
**update_json** | 更新されたフィールドの名前とその新しい値を含むJson構造体。 <br/>一度に更新できるフィールドは1つだけです | 例: <br/>`{` <br/>&nbsp;&nbsp;&nbsp;&nbsp;`'sms_phone':'+123456789'`<br/>`}` | true

#### HTTP 応答

このAPIはデータを返しません

HTTP 状態コード    | 詳細
---------------- | -----------
400	| いくつかの引数が不足しているか不正です (例 `'sms_phone'`の更新時は、 `'two_factor_authentication_type'` が `'email'` に設定されているか、またはその逆の状態)
401	| 資格情報が無効です
415	| `'two_factor_authentication_type'` で指定されたTFAコードの配信方法が無効です
200	| 要求は成功しました（検証に進みます）

### 2. TFA更新の検証

#### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/aaa/two_factor_authenticate/verify`

パラメータ   | データ形式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**two_factor_authentication_code** | 文字列    | SMSまたは電子メールで受信した4桁のコード | true

#### HTTP 応答

このAPIはデータを返しません

HTTP Status Code | Description
---------------- | -----------
400	| いくつかの引数が不足しているか不正です
406	| TFAコードが無効です
200	| 要求が成功しました

<!--===================================================================-->
## 認証済みデバイス
<!--===================================================================-->

ログインプロセスをユーザにとって可能な限り便利にするために、システムは、そのユーザによって以前にTFAベースのログイン成功時に使用されたデバイス上で、単純認証方式の使用を可能にします。Upon a successful TFA-based log in, **認可** API呼び出しは、ブラウザ内のクッキー `'tfa_key'` を設定します
その後の **認可** API コールの正しいユーザー名とパスワードでの実行は、
 **認可** の応答に `'two_factor_authentication_code’`フィールドがないことを伝える、単純認証方式から始まります。このような場合、 **TFAコードの送信** APIコールをスキップして、即座に **認可** APIコールを実行することができます。これは、TFA非対応のユーザーログインのプロセスと同様です

***注記 1:***

同じ `'tfa_key'` 値は、特定のデバイスから過去に正常に認証された複数のユーザーで使用できます
***注記 2:***

任意のユーザの許可されたデバイスのリストはユーザーレコードの `'user_authenticated_clients'` フィールドに保存されます。詳細は [ユーザー モデル](#user-model) を参照してください
