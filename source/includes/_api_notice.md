# 利用規約

<!--===================================================================-->
## 概要

以下のAPIエンドポイントは、**利用規約** の表示と受諾処理を簡易化します。Eagle Eye Networksは自身の利用規約の確認を [ユーザー用の利用規約の取得](#get-terms-of-service-for-user) を通じて行っております。加えて、リセラーは独自の **利用規約** を [アカウント用の利用規約の取得](#create-terms-of-service-for-account) を通じて行うことによって、Eagle Eye Networkの規約と同様に表示することが可能です。リセラーは自身の規約をマスターアカウントレベルに割り当てることも、サブアカウントレベルでそれぞれのサブアカウントの独自の規約として割り当てることも可能です。

基本的な動作プロセスは以下のようになります:

  1. Resellers create their own terms with the [Create Terms of Service for Account](#create-terms-of-service-for-account)
  2. Client UI will display terms if not accepted from a [Get Terms of Service for User](#get-terms-of-service-for-user)
  3. Client UI will accept the terms from a [Accept Terms of Service for User](#accept-terms-of-service-for-user)

<!--===================================================================-->
## ユーザー用の利用規約の取得
<!--===================================================================-->

This service allows to push important Terms of Service. The client software must call GET to see whether the user needs to agree to any new Terms of Service

If the user has a `'is_compliant=0'`, the client software should popup a message box containing the Terms of Service
<br>(It is preferred to have this as a single combined message box)

If the user agrees to the terms, a PUT call should be placed containing an array of all the Terms of Service

<aside class="notice">A past due user is subject to suspension of services and may not be allowed to login</aside>

> 要求

```shell
curl -X GET https://login.eagleeyenetworks.com/g/user/terms?id=cafe81f5 --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/user/terms`

パラメータ  | データ型式   | 詳細
--------- | --------- | -----------
id        | 文字列    | User ID

> JSON 応答

```json
[
    [
        "cafe81f5",
        "Terms_and_Conditions",
        "/een-terms-of-service/00013377/Terms_and_Conditions~2~20180523094504.txt",
        "2",
        0
    ]
]
```

### HTTP 応答 (属性の配列)

配列インデックス| 属性          | データ型式  | 詳細
----------- | ---------    | --------- | -----------
0           | user_id      | 文字列     | Unique identifier of the user  
1           | title        | 文字列     | Title of the term of service
2           | url          | 文字列     | URL of a file with the text of the terms of service
3           | version      | 文字列     | Version string for the title of the terms of service
4           | is_compliant | 整数       | If `0`, the user needs to accept the terms of service

<aside class="success">モデル定義にはプロパティキーがありますが、これは単なる標準配列なので参照用です</aside>

### エラー状態コード

HTTP 状態コード    | データ型式
------------------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
406	| Information supplied could not be verified
402	| Account is suspended
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## ユーザー用利用規約の受諾
<!--===================================================================-->

このサービスは利用規約の承認を記録するために使用されます

<aside class="notice">アカウントのスーパーユーザーは他のユーザーから受け入れられることはできません</aside>

> 要求

```shell
curl -X PUT https://login.eagleeyenetworks.com/g/user/terms -d '{"urls": ["/een-terms-of-service/00013377/Test_Terms_of_Service~1~20180523100004.txt", "/een-terms-of-service/00000001/EEN_Terms_of_Service~1.2~20180626191610.txt"]}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`PUT https://login.eagleeyenetworks.com/g/user/terms`

パラメータ   | データ型式      | 詳細         | 必須？
--------- | ---------     | ----------- | -----------
**urls**  | 配列[文字列] | Array of urls to be accepted | true

> JSON 応答

```json
{
    "id": "cafe81f5"
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ型式  | 詳細
--------- | --------- | -----------
id        | 文字列    | User ID

### Error 状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404	| Notice title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## アカウント用利用規約の作成
<!--===================================================================-->

Master accounts (Resellers) may require their own Terms of Service. This service allows to submit the text of customized Terms of Service

New terms can be submitted with a PUT command. GET can be done to verify the state of the terms. PUT will retire Terms of Service of the same title and account

<aside class="notice">Only master accounts can create an account's Terms of Service</aside>

Notices can be stored in the sub-account or the parent account of the user

Resellers are limited to 5 Terms of Service titles and each title will only have one active version

> 要求

```shell
curl -X PUT https://login.eagleeyenetworks.com/g/account/terms -d '{"is_admin_required": 1, "is_user_required": 1, "title": "Test Terms of Service", "text": "This is a test terms and service from resellers", "version": "1", "id": "00013377"}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`PUT https://login.eagleeyenetworks.com/g/account/terms`

パラメータ           | データ型式  | 詳細                                                  | 必須？        | デフォルト                 | 制限
---------         | --------- | -----------                                          |:-----------:| -------                  | ----------
**text**          | 文字列     | Text of the term of service to accept                | **&check;** |                          | Use single LF character for line break
id                | 文字列     | Unique ID of the account                             | **&cross;** | requester's account
title             | 文字列     | Title of the term of service to accept               | **&cross;** | 'Terms and Conditions'   | 32 bytes of alpha numeric characters
version           | 文字列     | Version of the title, which should be unique         | **&cross;** | auto incrementing number | 32 bytes of alpha numeric characters
is_admin_required | 整数       | Whether administrators have to accept (1) or not (0) | **&cross;** | not updating
is_user_required  | 整数       | Whether users have to accept (1) or not (0)          | **&cross;** | not updating
timestamp         | 文字列     | Date the term of service goes into effect            | **&cross;** | *now*

> JSON 応答

```json
{
    "status": "active",
    "is_admin_required": 1,
    "is_user_required": 1,
    "title": "Test_Terms_of_Service",
    "url": "/een-terms-of-service/00013377/Test_Terms_of_Service~1~20180523100004.txt",
    "timestamp": "20180523100004",
    "version": "1",
    "user": "cafe81f5",
    "account_id": "00013377"
}
```

### HTTP 応答 (JSON 属性)

パラメータ           | データ型式  | 詳細
---------         | --------- | -----------
title             | 文字列     | Title of the notice
version           | 文字列     | Version number for the notice title, a larger version number will retire other versions
is_admin_required | 整数       | Whether administrators have to accept (1) or not (0)
is_user_required  | 整数       | Whether users have to accept (1) or not (0)
timestamp         | 文字列     | Date of the term of service
url               | 文字列     | URL of the file containing the text for the notice
status            | 文字列     | Status of the term of service (`'active'`, `'retired'`)

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404	| Terms Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## アカウント用利用規約の更新
<!--===================================================================-->

アカウントの利用規約を更新します

<aside class="notice">マスターアカウントのみがアカウントの利用規約を更新できます</aside>

ユーザーは同じバージョンの条件を再度受け入れる必要はありませんが、PUTリクエストを使用してもう一回受諾することを強制することができます

> 要求

```shell
curl -X POST https://login.eagleeyenetworks.com/g/account/terms -d '{"is_admin_required": 0, "is_user_required": 1, "title": "Test Terms of Service", "text": "This is a test terms and service from resellers", "version": "2", "id": "00013377"}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/account/terms`

パラメータ           | データ型式  | 詳細                                                  | 必須？        | デフォルト                 | 制限
---------         | --------- | -----------                                          |:-----------:| -------                  | ----------
text              | 文字列     | Text of the term of service to accept                | **&cross;** |                          |  use single LF character for line break
id                | 文字列     | Unique ID of the account                             | **&cross;** | requester's account
title             | 文字列     | Title of the term of service to accept               | **&cross;** | 'Terms and Conditions'   | 32 bytes of alpha numeric characters
version           | 文字列     | Version of the title, which should be unique         | **&cross;** | auto incrementing number | 32 bytes of alpha numeric characters
is_admin_required | 整数       | Whether administrators have to accept (1) or not (0) | **&cross;** | not updating
is_user_required  | 整数       | Whether users have to accept (1) or not (0)          | **&cross;** | not updating
timestamp         | 文字列     | Date the term of service goes into effect            | **&cross;** | *now*

> JSON 応答

```json
{
    "status": "active",
    "is_admin_required": 0,
    "is_user_required": 1,
    "title": "Test_Terms_of_Service",
    "url": "/een-terms-of-service/00013377/Test_Terms_of_Service~1~20180523100004.txt",
    "timestamp": "20180523100004",
    "version": "2",
    "user": "cafe81f5",
    "account_id": "00013377"
}
```

### HTTP 応答 (JSON 属性)

パラメータ          | データ形式   | 詳細
---------         | --------- | -----------
title             | 文字列     | Title of the notice
version           | 文字列     | Version number for the notice title, a larger version number will retire other versions
is_admin_required | 整数       | Whether administrators have to accept (1) or not (0)
is_user_required  | 整数       | Whether users have to accept (1) or not (0)
timestamp         | 文字列     | Date of the term of service
url               | 文字列     | URL of the file containing the text for the notice
status            | 文字列     | Status of the term of service (`'active'`, `'retired'`)



<!--TODO: Investigate whether the curl request and response are correct (why "version" is an unexpected argument)-->

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404	| Notice title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## アカウント用利用規約の削除
<!--===================================================================-->

アカウントの利用規約を削除します

<aside class="notice">マスターアカウントのみがアカウントの利用規約を削除できます</aside>

```shell
curl -X DELETE https://login.eagleeyenetworks.com/g/account/terms?id=00013377 --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`DELETE https://login.eagleeyenetworks.com/g/account/terms`

パラメータ   | データ型式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**id**    | 文字列     | Account ID  | true
title     | 文字列     | Title of the term of service

> JSON 応答

```json
{
    "00013377": {
        "EEN_Terms_of_Service": {
            "1.2": "20180626193818.274"
        },
        "Test_Terms_of_Service": {
            "2": "20180626193626.502"
        }
    }
}
```



<!--TODO: Investigate the curl request and response-->

### HTTP 応答 (JSON 属性)

パラメータ 	        | データ型式   | 詳細
---------          | --------- | -----------
account_id         | 文字列     | Unique ID of the account that is requesting this term of service
account_name       | 文字列     | Name of the account that is requesting this term of service
title              | 文字列     | Title of the term of service
version            | 文字列     | Version number for the term title
is_admin_required  | 整数       | Whether administrators have to accept (1) or not (0)
is_user_required   | 整数       | Whether users have to accept (1) or not (0)
timestamp          | 文字列     | Date of the term of service
url                | 文字列     | URL of the file containing the text for the term of service
status             | 文字列     | This field is no longer being used <small>**(DEPRECATED)**</small>

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404	| Notice title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## アカウント用の利用規約の取得
<!--===================================================================-->

アカウントの利用規約を返します

> 要求

```shell
curl -X GET https://login.eagleeyenetworks.com/g/account/terms?id=00013377 --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/account/terms`

パラメータ   | データ型式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**id**    | 文字列     | Account ID  | true

> JSON 応答

```json
[
    [
        "00013377",
        "UNIT_TEST_SUB_ACCOUNT",
        "Test_Terms_of_Service2",
        "2",
        1,
        0,
        "20180523094136",
        "/een-terms-of-service/00013377/Terms_and_Conditions~2~20170523094136.txt",
        "active"
    ],
    [
        "00013377",
        "UNIT_TEST_SUB_ACCOUNT",
        "Test_Terms_of_Service",
        "1",
        1,
        1,
        "20180222115243",
        "/een-terms-of-service/00013377/Terms_and_Conditions~1~20170222115243.txt",
        "retired"
    ],
    [
        "00013377",
        "UNIT_TEST_SUB_ACCOUNT",
        "Test_Terms_of_Service",
        "2",
        0,
        1,
        "20180523094504",
        "/een-terms-of-service/00013377/Terms_and_Conditions~2~20170523094504.txt",
        "active"
    ],
    [
        "00000001",
        "UNIT_TEST_SUB_ACCOUNT",
        "EEN_Terms_of_Service",
        "1.2",
        1,
        1,
        "20180426191610",
        "/een-terms-of-service/00000001/Terms_and_Conditions~1.2~20170523094504.txt",
        "active"
    ]
]
```

### HTTP 応答 (属性の配列)

配列インデックス| 属性               | データ型式  | 詳細
----------- | ---------         | --------- | -----------
0           | account_id        | string    | Unique ID of the account that is requesting this notice
1           | account_name      | string    | Name of the account that is requesting this notice
2           | title             | string    | Title of the notice
3           | version           | string    | Version number for the notice title, a larger version number will retire other versions
4           | is_admin_required | int       | Whether administrators have to accept (1) or not (0)
5           | is_user_required  | int       | Whether users have to accept (1) or not (0)
6           | timestamp         | string    | Date of the term of service
7           | url               | string    | URL of the file containing the text for the notice
8           | status            | string    | Status of the term of service (`'active'`, `'retired'`)

<aside class="success">モデル定義にはプロパティキーがありますが、これは単なる標準配列なので参照用です</aside>

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
406	| Information supplied could not be verified
402	| Account is suspended
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm
