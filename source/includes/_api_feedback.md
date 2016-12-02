# フィードバック

<!--===================================================================-->
## 概要

This service allows users to send feedback to support.

<!--===================================================================-->
## Send Feedback

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/feedback --data "subject=[SUBJECT]&message=[MESSAGE]"
```

Sends feedback to support

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/feedback`

パラメータ       | データ型式   	| 詳細         
---------       | ----------- 	| -----------  
**subject**   	| 文字列      	| Subject of the feedback
**message**   	| 文字列      	| Feedback message

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
202 | Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
