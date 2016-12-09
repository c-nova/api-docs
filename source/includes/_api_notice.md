# 利用規約

<!--===================================================================-->
## 概要

以下のAPIエンドポイントは、**利用規約**の表示と受諾処理を簡易化します。Eagle Eye Networksは自身の利用規約の確認を [ユーザー用の利用規約の取得](#get-terms-of-service-for-user) を通じて行っております。加えて、リセラーは独自の**利用規約**を [アカウント用の利用規約の取得](#create-terms-of-service-for-account) を通じて行うことによって、Eagle Eye Networkの規約と同様に表示することが可能です。リセラーは自身の規約をマスターアカウントレベルに割り当てることも、サブアカウントレベルでそれぞれのサブアカウントの独自の規約として割り当てることも可能です。

基本的な動作プロセスは以下のようになります:

1. Resellers create their own terms with the [Get Terms of Service for Account](#create-terms-of-service-for-account)
2. Client UI will display terms if not accepted from a [Get Terms of Service for User](#get-terms-of-service-for-user)
3. Client UI will accept the terms from a [Accept Terms of Service for User](#accept-terms-of-service-for-user)

<!--===================================================================-->
## ユーザー用の利用規約の取得

> 要求

```shell
curl -X GET https://28888.eagleeyenetworks.com/g/account/terms?id=00009436 --cookie "auth_key=[AUTH_KEY]"
```

> Response List

```list
[['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service2', '2', 1, 0, '20150626191625', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service2~2~20150626191625.txt', 'active'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service', '1', 1, 1, '20150626191617', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~1~20150626191617.txt', 'retired'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service', '2', 0, 1, '20150626191622', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~2~20150626191622.txt', 'active'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'EEN_Terms_of_Service', '1.2', 1, 1, '20150626191610', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00000001/EEN_Terms_of_Service~1.2~20150626191610.txt', 'active']]
```

This is to push important terms of service such as "Terms and Conditions (2015)".
The client software must call **GET** to see if the user needs to agree to any new terms of service.
If the user has a **is_compliant** of False then the client software should popup a message box containing the terms of service.
It is preferred to have this as a single combined message box.

If the user agrees to the terms then a **PUT** call should be placed containing array all of the notices.
A past due user is subject to suspension of services, and may not be allowed to login.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/user/terms`

パラメータ  		| データ型式   | 詳細          	| 必須？
---------  		| ----------- | -----------   	| -----------
**id**   		| 文字列      | User Id 		| false

### HTTP List Attributes

パラメータ 	| データ型式     | 詳細       
---------  	| -----------   | -----------
user_id 	| 文字列 		| Unique identifier for validated user
title       | 文字列 		| Title of the terms of service
url         | 文字列        | Url of a file with the text of the terms of service
version     | 文字列  		| Version string for the title of the terms of service
is_compliant| bool          | If False then the user needs to accept the terms of service

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
  This is called to record acceptance of the notice.
  Account Super Users will not be able to accept for other people.

> 要求

```shell
curl -X PUT https://28888.eagleeyenetworks.com/g/user/terms -d '{"id": "cafe81f5", "urls": ["https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service2~2~20150626191625.txt", "https://login.eagleeyenetworks.com/static_assets/terms_of_service/00000001/EEN_Terms_of_Service~1.2~20150626191610.txt"]}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

> Response Json

``` json
{'id': 'cafe81f5'}
```

### HTTP要求

`PUT https://login.eagleeyenetworks.com/g/user/terms`

パラメータ  		| データ型式     | 詳細                            | 必須？
---------  		| -----------   | -----------   	              | -----------
**urls**        | 配列[文字列] | Array of urls that are accepted | true

### HTTP Json
パラメータ  		| データ型式   | 詳細       
---------  		| ----------- | -----------
**id**          | 文字列      | user id

### エラー状態コード
 Code    | データ型式
-------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404 | Notice Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## アカウント用利用規約の作成

Master Accounts (Resellers) may require their own terms of service.
For that case, this api endpoint is to submit the text of the terms of service.

New terms can be submitted with a PUT command, then a GET command can be done to see the state of the terms.
**PUT** will retire **terms of service** of the same title and account.
Notices can be stored in the sub account or the parent account of the user.
Resellers are limited to 5 terms of service titles and each title will only have one active version.

* Only master accounts can **PUT** an account's terms of service


> 要求

```shell
curl -X PUT https://28888.eagleeyenetworks.com/g/account/terms -d '{"is_admin_required": 1, "is_user_required": 1, "title": "Test Terms of Service", "text": "This is a test terms and service from resellers", "version": "1", "id": "00009436"}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

> Response Json

``` json
{'status': 'active', 'is_admin_required': 1, 'is_user_required': 1, 'title': 'Test_Terms_of_Service', 'url': 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~1~20150626191617.txt', 'timestamp': '20150626191617', 'version': '1', 'user': 'cafebead', 'account_id': '00009074'}
```

### HTTP要求

`PUT https://login.eagleeyenetworks.com/g/account/terms`

パラメータ  		   | データ型式       | 詳細          	                            | 必須？   | Default                  | Limitation
---------  		   | -----------     | -----------                  	            | -----------   | -------                  | ----------
text               | 文字列          | Text of the terms to accept                  | true          |                          |  use single LF character for line break
id                 | 文字列          | Unique id of the Account                     | false         | requester's account      |
title              | 文字列          | Title of the terms to accept                 | false         | "Terms and Conditions"   | 32 bytes of alpha numeric characters
version            | 文字列          | Version of the title, which should be unique | false         | auto incrementing number | 32 bytes of alpha numeric characters
is_admin_required  | bool            | If admins have to accept                     | false         | not updating             |
is_user_required   | bool            | If users have to accept                      | false         | not updating             |
timestamp          | 文字列          | Date the terms goes into affect              | false         | now                      |

### HTTP JSON Attributes
パラメータ 	           | データ型式     | 詳細       
---------  	           | -----------   | -----------
title                  | 文字列        | Title of the notice
version                | 整数           | Version number for the notice title, a larger version number will retire other versions
is_admin_required      | bool          | If admins have to accept
is_user_required       | bool          | If users have to accept
timestamp              | 文字列        | date of the  term of service
url                    | 文字列        | URL of the file containing the text for the notice
status                 | 文字列        | Status of the term of service (active, retired)

### エラー状態コード
 Code    | データ型式
-------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404 | Terms Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## アカウント用利用規約の更新

Updates an account terms of service as specified by Put Terms of Service for Account.
Users are not required to accept terms of the same version again, so if users should be forced to accept again then PUT should be done

* Only master account can **Post** an account's terms of service

> 要求

```shell
curl -X POST https://28888.eagleeyenetworks.com/g/account/terms -d '{"is_admin_required": 0, "is_user_required": 1, "title": "Test Terms of Service", "text": "This is a test terms and service from resellers", "version": "2", "id": "00009436"}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

> Response Json

``` json
{'status': 'active', 'is_admin_required': 0, 'is_user_required': 1, 'title': 'Test_Terms_of_Service', 'url': 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~2~20150626191622.txt', 'timestamp': '20150626191622', 'version': '1', 'user': 'cafebead', 'account_id': '00009074'}
```

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/account/terms`

パラメータ  		   | データ型式       | 詳細          	                            | 必須？   | Default                  | Limitation
---------  		   | -----------     | -----------                  	            | -----------   | -------                  | ----------
text               | 文字列          | Text of the terms to accept                  | false         |                          |  use single LF character for line break
id                 | 文字列          | Unique id of the Account                     | false         | requester's account      |
title              | 文字列          | Title of the terms to accept                 | false         | "Terms and Conditions"   | 32 bytes of alpha numeric characters
version            | 文字列          | Version of the title, which should be unique | false         | auto incrementing number | 32 bytes of alpha numeric characters
is_admin_required  | bool            | If admins have to accept                     | false         | not updating             |
is_user_required   | bool            | If users have to accept                      | false         | not updating             |
timestamp          | 文字列          | Date the term of service goes into affect    | false         | now                      |


### HTTP JSON Attributes
パラメータ 	           | データ型式     | 詳細       
---------  	           | -----------   | -----------
title                  | 文字列        | Title of the notice
version                | 整数           | Version number for the notice title, a larger version number will retire other versions
is_admin_required      | bool          | If admins have to accept
is_user_required       | bool          | If users have to accept
timestamp              | 文字列        | date of the  term of service
url                    | 文字列        | URL of the file containing the text for the notice
status                 | 文字列        | Status of the term of service (active, retired)

### エラー状態コード
 Code    | データ型式
-------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404 | Notice Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm


<!--===================================================================-->
## アカウント用利用規約の削除

This will **retire** a term of service.
* Only master accounts can **DELETE** an account's terms of service

```shell
curl -X DELETE https://28888.eagleeyenetworks.com/g/user/terms?id=cafe81f5 --cookie "auth_key=[AUTH_KEY]"
```

> Response Json

``` json
{ 'cafe81f5': { 'EEN_Terms_of_Service': { '1.2': '20150626193818.274'},
                 'Test_Terms_of_Service': { '2': '20150626193626.502'}}}
```



`DELETE https://login.eagleeyenetworks.com/g/account/terms`

パラメータ  		| データ型式   | 詳細             	| 必須？
---------  		| ----------- | -----------      	| -----------
id   		    | 文字列      | Account Id 		    | false
title           | 文字列      | Title of the terms  | false

### HTTP List Attributes
パラメータ 	       | データ型式     | 詳細       
---------  	       | -----------   | -----------
account_id         | 文字列        | Unique Id of the account that is requesting this term of service
account_name       | 文字列        | Name of the account that is requesting this term of service
title              | 文字列        | Title of the term of service
version            | 整数           | Version number for the term title
is_admin_required  | bool          | If admins have to accept
is_user_required   | bool          | If users have to accept
timestamp          | 文字列        | date of the term of service
url                | 文字列        | URL of the file containing the text for the term of service
status             | 文字列        | This will be **retired**

### エラー状態コード
 Code    | データ型式
-------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404 | Notice Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## アカウント用の利用規約の取得

> 要求

```shell
curl -X GET https://28888.eagleeyenetworks.com/g/account/terms?id=00009436 --cookie "auth_key=[AUTH_KEY]"
```

> Response List

```list
[['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service2', '2', 1, 0, '20150626191625', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service2~2~20150626191625.txt', 'active'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service', '1', 1, 1, '20150626191617', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~1~20150626191617.txt', 'retired'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service', '2', 0, 1, '20150626191622', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~2~20150626191622.txt', 'active'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'EEN_Terms_of_Service', '1.2', 1, 1, '20150626191610', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00000001/EEN_Terms_of_Service~1.2~20150626191610.txt', 'active']]
```

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/account/terms`

パラメータ  		| データ型式   | 詳細          	| 必須？
---------  		| ----------- | -----------   	| -----------
**id**   		| 文字列      | Account Id 		| false

### HTTP List Attributes
パラメータ 	           | データ型式     | 詳細       
---------  	           | -----------   | -----------
account_id             | 文字列        | Unique Id of the account that is requesting this notice
account_name           | 文字列        | Name of the account that is requesting this notice
title                  | 文字列        | Title of the notice
version                | 整数           | Version number for the notice title, a larger version number will retire other versions
is_admin_required      | bool          | If admins have to accept
is_user_required       | bool          | If users have to accept
timestamp              | 文字列        | date of the term of service
url                    | 文字列        | URL of the file containing the text for the notice
status                 | 文字列        | Status of the term of service (active, retired)

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

