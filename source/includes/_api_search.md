# 検索

<!--===================================================================-->
## 概要

このサービスは様々なデータ形式に渡る検索を許可します。現在は録画とアノテーションのみサポートしていますが、近日その他のデータ形式もサポートする予定です。

<!--===================================================================-->
## 録画の検索

> 要求 記述予定

```shell
```

> JSON応答 記述予定

```json
```

Returns array of recording objects that match a search value.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/search/recordings`

パラメータ  	| データ型式   | 詳細          
---------  	| ----------- | -----------   
**value**   | 文字列      | Value to search for

### 応答JSON属性

パラメータ               	| データ型式     | 詳細       
---------               	| -----------   | -----------
_key 						| 文字列 		| Unique identifier (within the user's account) of the recording
current_recording_timestamp | 文字列 		| Timestamp of when the current recording (if any) was started
recording_%s_start 			| RecordingInfo | Object of info about the recording start event, where '%s' is the timestamp it started. Could be N number of these.
recording_%s_stop 			| RecordingInfo | Object of info about the recording stop event, where '%s' is the timestamp it started. Must have a matching 'recording_%s_start' event. Could be N number of these.
recording_%s_meta 			| オブジェクト 		| Object of info about the recording, where '%s' is the timestamp it started. Must have a matching 'recording_%s_start' event.

### RecordingInfo Json Attributes

パラメータ   | データ型式     | 詳細       
---------   | -----------   | -----------
timestamp 	| 文字列 		| Timestamp the recording was started, in EEN format.
layout_id 	| boolean 		| Id of a layout the recording was started for
camera_ids 	| 配列[文字列] | Array of camera ids who had recording started for
layout_name | 文字列 		| Name of layout at the time the recording started
user_id 	| 文字列 		| Id of the user who started/stopped the recording

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges

<!--===================================================================-->
## アノテーションの検索

> 要求 記述予定

```shell
```

> JSON応答 記述予定

```json
```

Returns array of annotation objects that match a search value.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/search/recordings`

パラメータ  			| データ型式   | 詳細          			| 必須？
---------  			| ----------- | -----------   			| -----------
**value**   		| 文字列      | Value to search for 	| true
**start_timestamp** | 文字列      | Start timestamp (in EEN format) to use to limit search results 	| true
end_timestamp 		| 文字列      | End timestamp (in EEN format) to use to limit search results. Defaults to now. 	| 

### Response

				    |
------------------- |
array[object] 		| 

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges