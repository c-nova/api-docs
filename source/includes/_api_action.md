# アクション

<!--===================================================================-->
## 概要
<!--===================================================================-->

このサービスは割り当てられたデバイスで実行可能ないくつかのマクロ アクションを定義します。これらは便利な機能です。ここで提供されている同様の機能は、個々の設定呼び出しでも実現可能です。多くのアクションは現在または未来の時点をスケジュールすることが可能です。

与えられたマクロの特性とデバイスの数、実現可能な操作によって、引数が正しければ、サービスは成功のステータスコードを返します。アプリケーションはデバイスの基礎によるデバイスのアクションが成功または失敗するかをモニターして、対応をする必要があります。

<!--===================================================================-->
## 全てのカメラをオンにする
<!--===================================================================-->

実行者のアカウント内のすべてのカメラをオンにするために使用します。実行者はアカウントのスーパーユーザーでなければなりません

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/action/allon
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/action/allon`

### エラー状態コード

HTTP 状態コード | 詳細
---------------- | -----------
400	| 予期しない、または特定できない引数が指定されました
401	| 無効なセッションCookieにより認証されませんでした
403	| ユーザーに必要な権限が無いため拒否されました
202	| 要求は成功しました

<!--===================================================================-->
## 全てのカメラをオフにする
<!--===================================================================-->

実行ユーザのアカウント内のすべてのカメラのオフにするために使用されます。実行者はアカウントのスーパーユーザーでなければなりません

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/action/alloff
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/action/alloff`

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| 予期しない、または特定できない引数が指定されました
401	| 無効なセッションCookieにより認証されませんでした
403	| ユーザーに必要な権限が無いため拒否されました
202	| 要求は成功しました

<!--===================================================================-->
## 録画を開始
<!--===================================================================-->

すべてのカメラ、特定のレイアウトのカメラ、または1台のカメラの録画をオンにするときに使用します。この結果、影響を受けるカメラでは、すべての「稼働時間」のスケジュールが削除され、「camera_on」は1（オン）に設定され、「video_capture_mode」は「Always」に設定されます

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/action/recordnow
```

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/action/recordnow`

パラメータ      | データ形式   | 詳細
---------     | --------- | -----------
device_id     | string    | ID of the camera to record. If this parameter and the `'layout_id'` parameter are omitted, all cameras with write access available to the requesting user will be used
layout_id     | string    | ID of the layout for which cameras will be set to record. All cameras in the layout will be affected. If this parameter and the `'device_id'` parameter are omitted, all cameras with write access available to the requesting user will be used
recording_key | string    | A key used to tag this recording. Can be used to retrieve this recording info later using the GET `'recording'` service

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| 予期しない、または特定できない引数が指定されました
401	| 無効なセッションCookieにより認証されませんでした
403	| ユーザーに必要な権限が無いため拒否されました
202	| 要求は成功しました

<!--===================================================================-->
## 録画を停止
<!--===================================================================-->

すべてのカメラ、特定のレイアウトのカメラ、または1台のカメラの録画をオフにするときに使用します。この結果、影響を受けるカメラでは、すべての「operating_hours」スケジュールが削除され、「camera_on」は0（オフ）に設定され、「video_capture_mode」は「event」（デフォルト）に設定されます

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request POST https://login.eagleeyenetworks.com/g/action/recordoff
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/action/recordoff`

パラメータ | データ形式 | 詳細
--------- | --------- | -----------
device_id | 文字列    | ID of the camera to turn off recording for. If this parameter and the `'layout_id'` parameter are omitted, all cameras with write access available to the requesting user will be used
layout_id | 文字列    | ID of the layout for which cameras will have recording turned off. All cameras in the layout will be affected. If this parameter and the `'device_id'` parameter are omitted, all cameras with write access available to the requesting user will be used

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| 予期しない、または特定できない引数が指定されました
401	| 無効なセッションCookieにより認証されませんでした
403	| ユーザーに必要な権限が無いため拒否されました
202	| 要求は成功しました
