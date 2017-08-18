# アノテーション（注釈）

<!--===================================================================-->
## 概要

アノテーションサービスはカメラやビデオについての付加情報データをイベントストリームに追加することを可能にします。

<aside class="notice">アノテーションはデバイスとタイムスタンプに関連付けられます。これらは保存期間を超えると消去されてしまうような、通常の保管ロジックの影響を受けます。</aside>

<!--===================================================================-->
## アノテーションの作成

特定のタイムスタンプとデータ記述を使用して、デバイス用にアノテーションを作成します

<aside class="notice">アノテーションは、アノテーションの作成対象であるデバイスが存在するアカウント内からのみ作成できます</aside>

> 要求

```shell
curl -X PUT "https://login.eagleeyenetworks.com/annt/set?c=[ID]&ts=[TIMESTAMP]&ns=[NAMESPACE]" -d '{"data": "[ANNOTATION_DATA]"}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`PUT https://login.eagleeyenetworks.com/annt/set`

パラメータ     | データ形式 | 詳細     | 必須        |
---------     | -------  | ------- |:----------:|
**c**         | 文字列     | ID of the device the annotation should be associated with     | **&check;** |
**ns**        | 整数       | The numerical namespace value assigned by Eagle Eye Networks | **&check;** |
**\<data\>**  | JSON      | Json object representing the data to be used as the annotation content (can include HTML elements)  | **&check;** |
ts            | 文字列     | Timestamp associated with the annotation (optional - if left out the system will automatically provide a timestamp)              | **&cross;** |

> JSON応答

```json
{
    "uuid": "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
    "cameraid": "1000f60d",
    "ts": "20180526095435.831",
    "ns": 11
}
```

### HTTP 応答 (JSON属性)

パラメータ | データ形式 | 詳細
--------- | --------- | -----------
uuid      | 文字列    | Unique identifier of the annotation
cameraid  | 文字列    | Unique identifier of the device
ts        | 文字列    | Timestamp associated with the annotation
ns        | 文字列    | Namespace associated with the annotation

### エラー状態コード

HTTP 状態コード | 詳細
---------------- | -----------
400	| 予期しない、または特定できない引数が指定されました
401	| 無効なセッションCookieにより認証されませんでした
403	| ユーザーに必要な権限が無いため拒否されました
200	| 要求は成功しました

<!--===================================================================-->
## アノテーションの取得
<!--===================================================================-->

ID/UUIDにてアノテーション オブジェクトを返します

> 要求

```shell
curl -X GET https://login.eagleeyenetworks.com/annt/annt/get -d "id=[ID]" -d "uuid=[UUID1],[UUID2],[UUID3]" --cookie "auth_key=[AUTH_KEY]" -G
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/annt/annt/get`

パラメータ     | データ形式     | 詳細                                                                                                                  | 必須？    |
---------     | ---------     | -----------                                                                                                                  |:-----------:|
**id**        | 文字列        | ID of the device the annotation is associated with                                                                           | **&check;** |
**uuid**      | 配列[文字列] | Array of comma-separated annotation UUIDs to return                                                                          | **&check;** |

> JSON応答

```json
[
    [
        "3f06b432-41f9-11e7-aaf2-1c1b0daef2f5",
        "20180526095347.742",
        2,
        {
            "data": "{\"info\":\"Annotation1\";}"
        }
    ],
    [
        "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
        "20180526095435.831",
        11,
        {
            "info": "Annotation by cafedead"
        }
    ],
    [...]
]
```

### HTTP応答 (属性の配列)

Array Index | Attribute | データ形式 | 詳細
----------- | --------- | --------- | -----------
0           | uuid      | 文字列    | Unique identifier for the annotation assigned to it during creation
1           | timestamp | 文字列    | Time of the annotation creation in EEN Timestamp format (YYYYMMDDHHMMSS.NNN)
2           | namespace | 整数       | Namespace *grouping* assigned to the annotation (in the EEN structure namespaces can describe a specific category of annotations)
3           | \<data\>  | json      | Content of the annotation

<aside class="success">モデル定義にはプロパティキーがありますが、これは単なる標準配列なので参照用です</aside>

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | -----------
400	| 予期しないまたは認識できない属性が与えられました
401	| 無効なセッションクッキーによって許可されませんでした
403	| 必要な権限が足りないためユーザーは禁止されました
200	| 要求は成功しました

<!--===================================================================-->
## 次のアノテーション
<!--===================================================================-->

指定された方向に対して次のイベントを検索し、定義されたタイムスタンプの *あたり* で定義されているアノテーションに埋め込まれたオブジェクトを返します

> 要求

```shell
curl -X GET https://login.eagleeyenetworks.com/annt/annt/next -d "c=[ID]" -d "st=[START_TIMESTAMP]" --cookie "auth_key=[AUTH_KEY]" -G
```

### HTTP要求

`GET https://login.eagleeyenetworks.com/annt/annt/next`

パラメータ | データ形式 | 詳細                                                                                                                          | 必須？    |
--------- | --------- | -----------                                                                                                                          |:-----------:|
**c**     | 文字列    | ID of the device the annotation is associated with                                                                                   | **&check;** |
**st**    | 文字列    | Timestamp to get annotation(s) for in EEN format: YYYYMMDDHHMMSS.NNN                                                                 | **&check;** |

> JSON 応答

```json
{
    "ts": "20180526095435.831",
    "new": [
        [
            "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
            "20180526095435.831",
            11,
            {
                "info": "Annotation by cafedead"
            }
        ],
        [...],
        [...]
    ],
    "active": [
        "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
        "<uuid>",
        "<uuid>"
    ]
}
```

### HTTP 応答 (JSON 属性)

パラメータ | データ形式         | 詳細
--------- | ---------         | -----------
ts        | 文字列            | Timestamp to get annotation(s) after in EEN format: YYYYMMDDHHMMSS.NNN
new       | 配列[配列[obj]] | Array of arrays with each returned element being an annotation object with Json-formatted data <br>(See [Get Annotation](#get-annotation) for the returned annotation array structure)
active    | 配列[文字列]     | Array of all annotation UUIDs active around the specified `'st'` (or within the defined time window)

### エラー状態コード

HTTP 状態コード | 詳細
---------------- | -----------
400	| 予期しない、または特定できない引数が指定されました
401	| 無効なセッションCookieにより認証されませんでした
403	| ユーザーに必要な権限が無いため拒否されました
200	| 要求は成功しました

<!--===================================================================-->
## 前のアノテーション
<!--===================================================================-->

指定された方向に対して前のイベントを検索し、定義されたタイムスタンプの *あたり* で定義されているアノテーションに埋め込まれたオブジェクトを返します

> 要求

```shell
curl -X GET https://login.eagleeyenetworks.com/annt/annt/prev -d "c=[ID]" -d "et=[END_TIMESTAMP]" --cookie "auth_key=[AUTH_KEY]" -G
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/annt/annt/prev`

パラメータ | データ形式 | 詳細                                                                                                                          | 必須？    |
--------- | --------- | -----------                                                                                                                          |:-----------:|
**c**     | 文字列    | ID of the device the annotation is associated with                                                                                   | **&check;** |
**et**    | 文字列    | Timestamp to get annotation(s) for in EEN format: YYYYMMDDHHMMSS.NNN                                                                 | **&check;** |

> JSON 応答

```json
{
    "ts": "20180526095435.831",
    "new": [
        [
            "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
            "20180526095435.831",
            11,
            {
                "info": "Annotation by cafedead"
            }
        ],
        [...],
        [...]
    ],
    "active": [
        "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
        "<uuid>",
        "<uuid>"
    ]
}
```

### HTTP 応答 (JSON 属性)

パラメータ | データ形式         | 詳細
--------- | ---------         | -----------
ts        | 文字列            | Timestamp to get annotation(s) before in EEN format: YYYYMMDDHHMMSS.NNN
new       | 配列[配列[obj]] | Array of arrays with each returned element being an annotation object with Json-formatted data <br>(See [Get Annotation](#get-annotation) for the returned annotation array structure)
active    | 配列[文字列]     | Array of all annotation UUIDs active around the specified `'et'` (or within the defined time window)

### エラー状態コード

HTTP 状態コード | 詳細
---------------- | -----------
400	| 予期しない、または特定できない引数が指定されました
401	| 無効なセッションCookieにより認証されませんでした
403	| ユーザーに必要な権限が無いため拒否されました
200	| 要求は成功しました

<!--===================================================================-->
## 特定期間(ウィンドウ)のアノテーション
<!--===================================================================-->

特定の期間でアクティブなアノテーションが存在するオブジェクトを返します（オプションで、最近終了したアノテーションも含むこともできます）。結果は、除外したいUUIDリストを渡すことでフィルタすることもできます。`'st'`を指定すると、`'st'` と `'et'` の間で完了しているドキュメントが検索結果に含まれます（ `'st'` を指定しても検索間隔は変わりません）

> 要求

```shell
curl -X GET https://login.eagleeyenetworks.com/annt/annt/window  -d "c=[ID]" -d "st=[START_TIMESTAMP]" -d "et=[END_TIMESTAMP]" --cookie "auth_key=[AUTH_KEY]" -G
```

### HTTP要求

`GET https://login.eagleeyenetworks.com/annt/annt/window`

パラメータ | データ形式     | 詳細                                                                                                                      | 必須？    |
--------- | ---------     | -----------                                                                                                                      |:-----------:|
**c**     | 文字列        | ID of the device the annotation is associated with                                                                               | **&check;** |
**et**    | 文字列        | End timestamp of query in EEN format: YYYYMMDDHHMMSS.NNN                                                                         | **&check;** |
st        | 文字列        | Start timestamp of query in EEN format: YYYYMMDDHHMMSS.NNN                                                                       | **&cross;** |
uuid      | 配列[文字列] | Array of UUIDs to exclude from results                                                                                           | **&cross;** |

> JSON 応答

```json
{
    "ts": "20180526095435.831",
    "new": [
        [
            "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
            "20180526095435.831",
            11,
            {
                "info": "Annotation by cafedead"
            }
        ],
        [...],
        [...]
    ],
    "active": [
        "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
        "<uuid>",
        "<uuid>"
    ]
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ型式          | 詳細
--------- | ---------         | -----------
ts        | 文字列            | Timestamp to get annotation(s) for in EEN format: YYYYMMDDHHMMSS.NNN
new       | 配列[配列[obj]] | Array of arrays with each returned element being an annotation object with Json-formatted data <br>(See [Get Annotation](#get-annotation) for the returned annotation array structure)
active    | 配列[文字列]     | Array of all annotation UUIDs returned based on the specified criteria

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | -----------
400	| 予期しないまたは認識できない属性が与えられました
401	| 無効なセッションクッキーによって許可されませんでした
403	| 必要な権限が足りないためユーザーは禁止されました
200	| 要求は成功しました

<!--===================================================================-->
## アノテーションのリストを取得
<!--===================================================================-->

カウントまたは時間範囲を指定してアノテーションの配列を返します

> 要求

```shell
curl -X GET https://login.eagleeyenetworks.com/annt/annt/list -d "id=[ID]" -d "st=[START_TIMESTAMP]" -d "et=[END_TIMESTAMP]" -H 'Content-type: application/json' --cookie "auth_key=[AUTH_KEY]" -G
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/annt/annt/list`

パラメータ           | データ形式     | 詳細                                                                                                            | 必須？    |
---------           | ---------     | -----------                                                                                                            |:-----------:|
**id**              | 文字列        | ID of the device the annotation should be associated with                                                              | **&check;** |
**start_timestamp** | 文字列        | Start timestamp of the annotations to return                                                                           | **&check;** |
**end_timestamp**   | 文字列        | End timestamp of the annotations to return                                                                             | **&check;** |
count               | 整数           | N number of annotations to return (can be used to replace the `'end_timestamp'`, in which case will return the first N number of annotations after `'start_timestamp'`)                                                                                                                       | **&cross;** |
uuid                | 配列[文字列] | Array of comma-delimited UUIDs to list                                                                                 | **&cross;** |
namespace           | 配列[整数]    | Array of 1 to N comma-delimited namespaces to list                                                                     | **&cross;** |
exclusive           | boolean       | Whether to include annotations that span start or end (0) or not (1)                                                   | **&cross;** |

> JSON 応答

```json
[
    [
        "3f06b432-41f9-11e7-aaf2-1c1b0daef2f5",
        "20180526095347.742",
        2,
        {
            "data": "{\"info\":\"Annotation1\";}"
        }
    ],
    [
        "595e4b9c-41f9-11e7-aaf2-0d5g1hafj2z6",
        "20180526095435.831",
        11,
        {
            "info": "Annotation by cafedead"
        }
    ],
    [...],
    [...],
    [...]
]
```

### HTTP 応答 (属性の配列)

Array Index | Attribute              | データ形式 | 詳細
----------- | ---------              | --------- | -----------
0           | uuid                   | 文字列    | Unique identifier for the annotation assigned to it during creation
1           | timestamp              | 文字列    | Time of the annotation creation in EEN Timestamp format (YYYYMMDDHHMMSS.NNN)
2           | namespace              | 整数       | Namespace *grouping* assigned to the annotation (in the EEN structure namespaces can describe a specific category of annotations)
3           | \<data\>               | json      | Content of the annotation

<aside class="success">モデル定義にはプロパティキーがありますが、これは単なる標準配列なので参照用です</aside>

### エラー状態コード

HTTP 状態コード | 詳細
---------------- | -----------
400	| 予期しない、または特定できない引数が指定されました
401	| 無効なセッションCookieにより認証されませんでした
403	| ユーザーに必要な権限が無いため拒否されました
200	| 要求は成功しました
