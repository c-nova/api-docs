# アクション

<!--===================================================================-->
## 概要

This service defines several macro actions that can be attached to devices. These are convenience functions. The same functionality provided herein can also be accomplished via individual setting calls. Most actions can be scheduled to occur now or at some point in the future.

Given the macro nature and the number of devices and operations that may occur, so long as the arguments are correct, the services will return success status code. The application should monitor the vent stream to determine success of failure of the action on a device by device basis.

<!--===================================================================-->
## Recording On

> 要求 記述予定

```shell
```

Used to turn on recording for 1 camera, all cameras, or all cameras in a specific layout. The result of this to the affected cameras will be that all 'operating_hours' schedules are removed, 'camera_on' is set to 1 (on), and 'video_capture_mode' is set to 'always'.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/action/recordnow`

パラメータ       | データ型式   | 詳細         
---------       | ----------- | -----------  
device_id     	| 文字列      | ID of the camera to record. If this parameter and the 'layout_id' parameter are omitted, all cameras with write access available to the requesting user will be used.
layout_id    	| 文字列      | ID of the layout whose cameras will be set to record. All cameras in the layout will be affected. If this parameter and the 'device_id' parameter are omitted, all cameras with write access available to the requesting user will be used.
recording_key   | 文字列      | A key used to tag this recording. Can be used to retrieve this recording info later using the GET 'recording' service.

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
202 | Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges

<!--===================================================================-->
## Recording Off

> 要求 記述予定

```shell
```

Used to turn off recording for 1 camera, all cameras, or all cameras in a specific layout. The result of this to the affected cameras will be that all 'operating_hours' schedules are removed, 'camera_on' is set to 0 (off), and 'video_capture_mode' is set back to 'event' (the default).

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/action/recordoff`

パラメータ       | データ型式   | 詳細         
---------       | ----------- | -----------  
device_id     	| 文字列      | ID of the camera to turn off recording for. If this parameter and the 'layout_id' parameter are omitted, all cameras with write access available to the requesting user will be used.
layout_id    	| 文字列      | ID of the layout whose cameras will have recording turned off. All cameras in the layout will be affected. If this parameter and the 'device_id' parameter are omitted, all cameras with write access available to the requesting user will be used.

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
202	| Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges

<!--===================================================================-->
## Turn All Cameras On

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/action/allon
```

Used to turn on all cameras in the caller user’s account. Caller must be an account_superuser.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/action/allon`

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
202	| Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges

<!--===================================================================-->
## Turn All Cameras Off

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/action/alloff
```

Used to turn off all cameras in the caller user’s account. Caller must be an account_superuser.

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/action/alloff`

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
202	| Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
