# 認証, 認可, アカウント

<!--===================================================================-->
## アカウントの作成 

## 概要
このセクションは新規カウントの作成と、アカウントの回復のステップを説明します。もし現在のアカウントに紐付いたサブアカウントの作成を行う場合には、 [Account](#account) を参照してください。

> 要求

```shell
curl --request POST https://login.eagleeyenetworks.com/g/aaa/create_account --data "email=[EMAIL]&password=[PASSWORD]"
```

これはアカウントに新規のユーザー及びスーパーユーザーを作成する際に使用します。作成プロセスの一部として、サービスはリンクを含んだ確認用のEメールを送信し、ユーザーはそれをクリックしてユーザーアカウントのアクティベーションを行う必要があります。ユーザーアカウントはアクティブ化するまで使用することはできません。

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/create_account`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
**email**   	| 文字列      | Eメールアドレス 	| POST
**password**   	| 文字列      | パスワード 		| POST
name   			| 文字列      | アカウント名
realm  			| 文字列      | レルム (デフォルトは現在のユーザーレルム)
first_name 		| 文字列      | ユーザーの名前
last_name  		| 文字列      | ユーザーの姓
timezone   		| 文字列      | タイムゾーン名
is_api_acces_needed | ブール | この新規アカウントにAPIアクセス権を与える

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
400	| Unexpected or non-identifiable arguments are supplied
406	| Realm is invalid due to not being a root realm
409	| Email address has already been registered for the specified realm
202	| Account has been created and a confirmation email has been sent to the provided email address

<!--===================================================================-->
## アカウントの確認

> 要求

```shell
curl --request POST https://login.eagleeyenetworks.com/g/aaa/validate_account --data "id=[ID]&token=[TOKEN]"
```

> Response Json

```json
{
	"user_id": "ca103fea"
}
```

This is used to verify the email address supplied when the account is created. When successful, the account is set to active and a user session is created. User will not be required to login again.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/validate_account`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
id   		| 文字列      | Account Id 		| POST
token   	| 文字列      | Account validation token | POST

### HTTP Json Attributes

パラメータ 	| データ型式     | 詳細       
---------  	| -----------   | -----------
user_id 	| 文字列 		| Unique identifier for validated user

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
## パスワードの紛失

> 要求

```shell
curl --request POST https://login.eagleeyenetworks.com/g/aaa/forgot_password --data "email=[EMAIL]"
```

Password recovery is a multi-step process. Step one requests a reset email be sent to the email address of a registered user. Step two validates that the reset token is valid (This step is optional but is provided to allow for a friendlier user experience). Step three uses allows the user to change the password. The results of step three is that a user session is created for the user.

### HTTP要求


`POST https://login.eagleeyenetworks.com/g/aaa/forgot_password`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
email   	| 文字列      | Email Address 	| POST

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
400 | Unexpected or non-identifiable arguments are supplied
406	| Information supplied could not be verified
402	| Account is suspended
460	| Account is inactive
461	| Account is pending
412	| User is disabled
462	| User is pending
202	| An reset email has been sent to the supplied email address. This status will be provided even if the email address was not found. This prevents attacks to discover user accounts.

<!--===================================================================-->
## パスワードのリセット トークンの確認

> 要求

```shell
curl --request POST https://login.eagleeyenetworks.com/g/aaa/check_pw_reset_token --data "token=[TOKEN]"
```

This is step two of the password recover/reset process. It verifies that the supplied token is a valid reset token.

### HTTP要求


`POST https://login.eagleeyenetworks.com/g/aaa/check_pw_reset_token`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
token   	| 文字列      | Password reset token provided in email | POST

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
400 | Unexpected or non-identifiable arguments are supplied
406	| Token not valid or not found
402	| Account is suspended
460	| Account is inactive
461	| Account is pending
412	| User is disabled
202	| Token is valid

<!--===================================================================-->
## パスワードのリセット

> 要求

```shell
curl --request POST https://login.eagleeyenetworks.com/g/aaa/reset_password --data "token=[TOKEN]&password=[PASSWORD]"
```

> Response Json

```json
{
	"user_id": "ca0e1cf2"
}
```

This is step three of the password recover/reset process. It both verifies that the supplied token is a valid reset token and then, if valid resets the password associated with the token to the newly supplied password. Upon completion, a user login session is created.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/reset_password`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
token   	| 文字列      | Password reset token provided in email | POST
password   		| 文字列      | New password | POST
accepted_terms_of_service_urls   		| 文字列      | New terms of service acceptance url

### HTTP Json Attributes

パラメータ 	| データ型式     | 詳細       
---------  	| -----------   | -----------
user_id 	| 文字列 		| Unique identifier for validated user

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
400 | Unexpected or non-identifiable arguments are supplied
406	| Token not valid or not found
402	| Account is suspended
460	| Account is inactive
461	| Account is pending
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## 登録用Eメールの再送

> 要求

```shell
curl --request POST https://login.eagleeyenetworks.com/g/aaa/resend_registration_email --data "email=[EMAIL]"
```

This is used by users who have registered for an account, but never confirmed the registration. This will allow the registration confirmation email to be re-sent to the user.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/resend_registration_email`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
email   	| 文字列      | Email address of the account contact for a pending account | POST
realm  			| string      | realm (defaults to current user's realm)


### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
400 | Unexpected or non-identifiable arguments are supplied
404	| Account with this email address and realm could not be found
402	| Account is suspended
460	| Account is inactive
409	| Account is already active (not pending)
412	| User is disabled
202	| Account was located and verified to be in the pending state. A registration email has been recreated and sent to the provided email address.

<!--===================================================================-->
## ユーザー確認用Eメールの再送

> 要求

```shell
curl --request POST https://login.eagleeyenetworks.com/g/aaa/resend_user_verification_email --data "email=[EMAIL]"
```

This is used by users who have had a user account created for them, but they never confirmed their user account. This will re-send the user confirmation email so that they can then confirm their user account.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/resend_user_verification_email`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
email   	| 文字列      | Email address of the new user | POST
realm  			| 文字列      | realm (defaults to current user's realm)

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
400 | Unexpected or non-identifiable arguments are supplied
404	| User with this email address and realm could not be found
402	| Account is suspended
460	| Account is inactive
461	| Account is pending
412	| User is disabled
409	| User is already active (not pending)
202	| User was located and verified to be in the pending state. A verification email has been recreated and sent to the provided email address.

<!--===================================================================-->
## パスワードの変更

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]&api_key=[API_KEY]" --request POST https://login.eagleeyenetworks.com/g/aaa/resend_user_verification_email --data "password=[EMAIL]&current_password=[CURRENT_PASSWORD]"
```

> Response Json

```json
{
	"id": "ca02c000"
}
```


This allows a user to change their password directly while authenticated, and also allows super users to change the password of the users they manage. If someone is changing their own password, they must send their current password as well. If someone is changing one of the users they manage, they only need to send the new password.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/change_password`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
id   			| 文字列      | ID of the user having their password changed. Optional. Defaults to the ID of the authenticated user. If empty or equal to authenticated user, then "current_password" becomes required. | 
password   	| 文字列      | New password | POST
current_password| 文字列      | Current password of the user. Optional. If "id" argument is empty, or is equal to the authenticated user's id, then this is required. | 

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
401 | Unauthorized due to invalid session cookie
400	| Unexpected or non-identifiable arguments are supplied
404	| User with the "id" provided cannot be found
406	| The "current_password" provided does not match the password of the authenticated user
200	| User password was changed successfully

<!--===================================================================-->
## アカウントの切り替え

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/aaa/switch_account
```

This allows a user to "log in" to another account that the user has access to (see "list/accounts"). Most commonly this be would be needed for a master account user accessing their sub accounts.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/switch_account`

パラメータ  		| データ型式   | 詳細          	| 以下で必須
---------  		| ----------- | -----------   	| -----------
account_id   	| 文字列      | ID of the account to login to. Optional. Defaults to the account ID that the user belongs to. | POST

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
401 | Unauthorized due to invalid session cookie
400	| Unexpected or non-identifiable arguments are supplied
404	| Account with the "account_id" provided cannot be found
200	| Account context switch successful

<!--===================================================================-->
## シングル・サインオン

> 要求

```shell
curl --request POST https://login.eagleeyenetworks.com/g/sso
```

SSO allows a reseller to maintain account management and act as an identity provider to have their system proxy the authorization requests to Eagle Eye Network servers after users have logged into the identity providers system.

This is done through the standard SAML (Security Assertion Markup Language) and as such the identity provider will setup their account with a **brand_saml_publickey_ret** and **brand_saml_namedid_path**.

  - The **brand_saml_publickey_cert** is a x509 certificate that contains a public key with which Eagle Eye Networks can validate that an SSO message is valid and verify that it has not been altered.  The format of this certificate is PEM (ascii encoded base 64 surrounded by lines containing **'-----BEGIN CERTIFICATE——‘** and **'——END CERTIFICATE——'**

  - The **brand_saml_namedid_path** is the xml xpath to the node that contains the email address of the user being logged in.

Once the identity provider's account has been registered for SSO, then the identity provider can validate their users and then make a single sign on request with the users email address and the return link.
This 64 bit encrypted message will be extracted from teh header to be decoded and verified using the saml public key.
Then using the saml named id path, the user's email will be extracted and an auth_key will be provide for that user.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/sso`


### エラー状態コード

HTTP 状態コード    | データ型式
------------------- | -----------
401 | Unauthorized due to invalid session cookie
400	| Unexpected or non-identifiable arguments are supplied
404	| Account with the "account_id" provided cannot be found
200	| Account context switch successful

<!--===================================================================-->
## ログアウト

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/aaa/logout
```

Log out user and invalidate HTTP session cookie

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/aaa/logout`

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
204 | User has been logged out
