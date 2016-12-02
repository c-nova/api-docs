# 録画

<!--===================================================================-->
## 概要

This service is used to retrieve and update recording info for recordings that were started/stopped using the "action/recordnow" and "action/recordoff" services.

<!--===================================================================-->
## Get Recording Object

> 要求 記述予定

```shell
```

> JSON応答 記述予定

```json
```

Returns recording object by recording_key.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/recording`

パラメータ       	| データ型式   	| 詳細       
---------       	| ----------- 	| -----------
**recording_key**   | 文字列      	| Recording Key

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges

<!--===================================================================-->
## Update Recording Object

> 要求 記述予定

```shell
```

> JSON応答 記述予定

```json
```

Update a Recording

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/recording`

パラメータ       	| データ型式   	| 詳細       
---------       	| ----------- 	| -----------
**recording_key**   | 文字列      	| Unique identifier (within an account) of a recording
meta 				| オブジェクト 		| Meta data. This is meant to be a generic object that can store any data that is needed, so the properties are not predefined.

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges