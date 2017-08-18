# 録画

<!--===================================================================-->
## 概要
<!--===================================================================-->

このサービスは、`'action/recordnow'` と `'action/recordoff'` エンドポイントを使用して開始/終了された録画に対して、録画情報の取得と更新を行います。

<aside class="success">このサービスは継続的に拡張されます</aside>

<!--===================================================================-->
## 録画モデル
<!--===================================================================-->

> 録画モデル 記述予定

```json
```

### 録画 (属性)

<details hidden>
Parameter | Data Type | Description
--------- | --------- | -----------
<p hidden>???</p> | <p hidden>???</p> | <p hidden>???</p>
</details>


<!--===================================================================-->
## 録画オブジェクトの取得
<!--===================================================================-->

recording_key によって録画オブジェクトを返します

> Request TODO

```shell
```

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/recording`

パラメータ           | データ型式  | 詳細         | 必須？
---------         | --------- | ----------- | -----------
**recording_key** | string    | Recording key | true

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
200	| Request succeeded

<!--===================================================================-->
## 録画オブジェクトの更新
<!--===================================================================-->

録画の更新

> 要求 記述予定

```shell
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/recording`

パラメータ           | データ型式  | 詳細         | 必須？
---------         | --------- | ----------- | -----------
**recording_key** | string    | Unique identifier (within an account) of a recording | true
meta              | object    | Meta data. This is meant to be a generic object that can store any data that is needed, so the properties are not predefined

> JSON 応答 TODO

```json
```

<details hidden>
### HTTP 応答 (JSON 属性)

パラメータ   | データ型式  | 詳細
--------- | --------- | -----------
<p hidden>???</p> | <p hidden>???</p> | <p hidden>???</p>
</details>

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
200	| Request succeeded
