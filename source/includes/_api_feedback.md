# フィードバック

<!--===================================================================-->
## 概要
<!--===================================================================-->

このサービスはユーザーによるサポートへのフィードバックを許可します

<!--===================================================================-->
## フィードバックの送信
<!--===================================================================-->

サポートにフィードバックを送信します

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/feedback --data "subject=[SUBJECT]&message=[MESSAGE]"
```

### HTTP Request

`POST https://login.eagleeyenetworks.com/g/feedback`

パラメータ     | データ型式  | 詳細         | 必須？
---------   | --------- | ----------- | -----------
**subject** | string    | Subject of the feedback | true
**message** | string    | Feedback message | true

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
202	| Request succeeded
