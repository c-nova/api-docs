# フィードバック

<!--===================================================================-->
## 概要

This service allows users to send feedback to support.

<!--===================================================================-->
## Send Feedback

> Request

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/feedback --data "subject=[SUBJECT]&message=[MESSAGE]"
```

Sends feedback to support

### HTTP Request

`POST https://login.eagleeyenetworks.com/g/feedback`

Parameter       | Data Type   	| Description  
---------       | ----------- 	| -----------  
**subject**   	| string      	| Subject of the feedback
**message**   	| string      	| Feedback message

### Error Status Codes

HTTP Status Code    | Data Type   
------------------- | ----------- 
202 | Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
