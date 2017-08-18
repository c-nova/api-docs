# 検索

<!--===================================================================-->
## 概要
<!--===================================================================-->

このサービスは様々なデータ形式に渡る検索を許可します。

<aside class="success">現在は録画とアノテーションのみサポートしていますが、近日その他のデータ形式もサポートする予定です</aside>

<!--===================================================================-->
## 録画の検索
<!--===================================================================-->

> 検索モデル 記述予定

```json
```

### 検索 (属性)

<details hidden>
パラメータ   | データ型式  | 詳細
--------- | --------- | -----------
<p hidden>???</p> | <p hidden>???</p> | <p hidden>???</p>
</details>


<!--===================================================================-->
## 録画の検索
<!--===================================================================-->

検索値に一致する録画オブジェクトの配列を返します

> 要求 記述予定

```shell
```

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/search/recordings`

パラメータ   | データ型式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**value** | 文字列     | Value to search for | true

> JSON 応答 記述予定

```json
```

### HTTP 応答 (属性の配列)

パラメータ                     | データ型式      | 詳細
---------                   | ---------     | -----------
\_key                       | 文字列        | Unique identifier (within the user's account) of the recording
current_recording_timestamp | 文字列        | Timestamp of when the current recording (if any) was started
recording_%s_start          | RecordingInfo | Object of info about the recording start event, where `'%s'` is the timestamp it started. Could be N number of these
recording_%s_stop           | RecordingInfo | Object of info about the recording stop event, where `'%s'` is the timestamp it started. Must have a matching `'recording_%s_start'` event. Could be N number of these
recording_%s_meta           | オブジェクト     | Object of info about the recording, where `'%s'` is the timestamp it started. Must have a matching `'recording_%s_start'` event

### RecordingInfo JSON 属性

パラメータ     | データ型式      | 詳細
---------   | ---------     | -----------
timestamp   | 文字列         | Timestamp of when the recording was started
layout_id   | ブール         | ID of a layout the recording was started for
camera_ids  | 配列[文字列]    | Array of camera IDs which had recording started for
layout_name | 文字列         | Name of layout at the time the recording started
user_id     | 文字列         | ID of the user who started/stopped the recording

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
200 | Request succeeded

<!--===================================================================-->
## アノテーションの検索
<!--===================================================================-->

検索値と一致するアノテーション オブジェクトの配列を返します

> 要求 記述予定

```shell
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/search/recordings`

パラメータ             | データ型式  | 詳細         | 必須？
---------           | --------- | ----------- | -----------
**value**           | 文字列     | Value to search for | true
**start_timestamp** | 文字列     | Start timestamp used to limit search results | true
end_timestamp       | 文字列     | End timestamp used to limit search results (defaults to *now*)

> JSON 応答 記述予定

```json
```

<details hidden>
### HTTP 応答 (属性の配列)

パラメータ   | データ型式      | 詳細
--------- | ---------     | -----------
<p hidden>???</p> | array[object] | <p hidden>???</p>
</details>


### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
200 | Request succeeded
