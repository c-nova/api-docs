# ブリッジ

<!--===================================================================-->
## 概要
<!--===================================================================-->

ブリッジはお客様先に設置され、業界標準カメラと通信を行うEagle Eyeの製品です。これによりカメラはEEVBとアセットの保存と互換するように変換されます。ブリッジはクラウドベースのユーザーインターフェイス経由でセットアップや制御が行われます。ブリッジにはユーザーインターフェイスはありません。ブリッジはローカルのクライアントのために、ローカルストレージに直接保存することが可能です。ブリッジはまた資産をEEVBに転送し、保存することが可能です。ブリッジはDHCPまたは固定IPアドレスによって構成されます。

<!--===================================================================-->
## ブリッジ モデル
<!--===================================================================-->

> ブリッジ モデル

```json
{
    "bridges": null,
    "camera_info_status_code": 404,
    "name": "Main",
    "settings": {
        "bridge": null,
        "is_logically_deleted": false
    },
    "camera_settings_status_code": 200,
    "camera_info": null,
    "utcOffset": -25200,
    "camera_parameters_status_code": 200,
    "id": "100d88a8",
    "timezone": "US/Pacific",
    "guid": "bceb04ec-8b24-4aee-a09a-8479d856e81c",
    "camera_parameters": {
        "active_settings": {
            "max_disk_usage": {
                "max": 0.97999999999999998,
                "min": 0.050000000000000003,
                "d": 0.80000000000000004,
                "v": 0.80000000000000004
            },
            "display_layouts": {
                "d": {},
                "v": {}
            },
            "local_display_enable": {
                "max": 1,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "bandwidth_background": {
                "max": 10000000000.0,
                "min": -1000.0,
                "d": 100000.0,
                "v": 100000.0
            },
            "bandwidth_recover": {
                "max": 10000000000.0,
                "min": 100000.0,
                "d": 5000000.0,
                "v": 5000000.0
            },
            "stream_stats_present_only": {
                "max": 1,
                "min": 0,
                "d": 1,
                "v": 1
            },
            "retention_days": {
                "max": 10000,
                "min": 1,
                "d": 14,
                "v": 14
            },
            "bridge_retention_days": {
                "max": 100000,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "stream_stats": {
                "d": "none",
                "v": "none"
            },
            "upnp_enable": {
                "max": 1,
                "min": -1,
                "d": 0,
                "v": 0
            },
            "bandwidth_demand": {
                "max": 10000000000.0,
                "min": 100000.0,
                "d": 10000000.0,
                "v": 10000000.0
            },
            "bandwidth_upload": {
                "max": 10000000000.0,
                "min": 100000.0,
                "d": 1000000.0,
                "v": 1000000.0
            },
            "retention_priority": {
                "max": 10000,
                "min": 1,
                "d": 100,
                "v": 100
            },
            "display_default_enabled": {
                "max": 1,
                "min": 0,
                "d": 1,
                "v": 1
            }
        },
        "active_filters": [
            "schedule_bandwidth_background",
            "user_user"
        ],
        "user_settings": {
            "versions": {},
            "settings": {
                "upnp_enable": "0",
                "bandwidth_background": 50000
            },
            "schedules": {
                "bandwidth_background": {
                    "priority": 1,
                    "start": {
                        "seconds": 0,
                        "hours": 8,
                        "months": "*",
                        "minutes": 0,
                        "wdays": [
                            1,
                            2,
                            3,
                            4,
                            5,
                            6,
                            7
                        ]
                    },
                    "end": {
                        "seconds": 0,
                        "hours": 17,
                        "months": "*",
                        "minutes": 30,
                        "wdays": [
                            1,
                            2,
                            3,
                            4,
                            5,
                            6,
                            7
                        ]
                    },
                    "when": "work",
                    "settings": {
                        "bandwidth_background": "100000"
                    }
                }
            }
        }
    },
    "tags": [],
    "permissions": "swr"
  }
```

### ブリッジ (属性)

パラメータ                       | データ形式      | 詳細                                                                                                 | 編集可？      | 必須？
---------                     | ---------     | -----------                                                                                         |:-----------:| --------
**id**                        | 文字列         | デバイスの追加時に一意の識別子が自動的に生成され、割り当てられます                                                   | **&cross;** | **<sub><form action="#get-bridge"><button>GET</button></form></sub>** <br>**<sub><form action="#update-bridge"><button>POST</button></form></sub>** <br>**<sub><form action="#delete-bridge"><button>DELETE</button></form></sub>**
**name**                      | 文字列         | ブリッジの名前                                                                                          | **&check;** | **<sub><form action="#add-bridge-to-eevb"><button>PUT</button></form></sub>**
guid                          | 文字列         | GUID（Globally Unique Identifier）は、製造プロセス中にデバイスに割り当てられる不変のデバイス識別子です                 | **&cross;** |
timezone                      | 文字列         | デバイスがインストールされている場所の時間帯を示します。デフォルトはアカウントのタイムゾーンです。 例： `'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'` or `'UTC'` など                                                                                 | **&check;** |
utcOffset                     | 整数           | UTCからのタイムゾーンの秒単位の符号付き整数オフセット。タイムゾーンフィールドに基づいて自動的に生成されます                   | **&cross;** |
tags                          | 配列[文字列]    | タグ名を表す文字列の配列                                                                                   | **&check;** |
permissions                   | 文字列         | 現在のユーザーの権限レベルを定義する文字列                                                                     | **&cross;** |
[bridges](#camera-bridges)    | JSON          | <small>**(カメラにのみ適用)**</small>                                                                   | **&cross;** |
[settings](#bridge-settings)  | JSON          | 基本設定のJSONオブジェクト（場所など）                                                                       | **&check;** |
[camera_info](#bridge-camera_info) | JSON     | 基本的なブリッジ情報のJSONオブジェクト。何らかの理由でブリッジ情報を取得できない場合（たとえば、ブリッジとの通信が失われた場合）にはこれは空になり、camera_info_status_codeは404になります                                                                                                                                             | **&cross;** |
camera_info_status_code       | 整数           | デバイスに関する情報を取得することが可能か(200)、否か(404)                                                      | **&cross;** |
camera_parameters             | JSON          | ブリッジパラメータのJSONオブジェクト。何らかの理由でブリッジパラメータを取得できない場合（例：ブリッジとの通信が失われた場合）にはこれは空になり、camera_parameters_status_codeは404になります                                                                                                                                        | **&check;** |
camera_parameters_status_code | 整数           | デバイスのパラメータを取得することができたか(200)、否かを示します(404)                                             | **&cross;** |
camera_settings               | 文字列         | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>                                            | **&cross;** |
camera_settings_status_code   | 整数           | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>                                            | **&cross;** |

### ブリッジ - 設定

パラメータ                       | データ形式      | 詳細
---------                     | ---------     | -----------
analog_inputs_ignored         | 配列[文字列]     | ユーザが無視したいアナログ入力の数の配列
event_data_start_timestamp    | 文字列          | <p hidden>???</p>
local_display_layout_ids      | 配列[文字列]     | ローカルディスプレイ上で利用可能なレイアウトの配列
bridge                        | null          | <small>**(カメラにのみ適用)**</small>
site_name                     | 文字列          | ユーザー定義のブリッジロケーション名
floor                         | 整数           | 複数階の建物におけるブリッジの設置フロア数
retention_days                | 整数           | ブリッジがデータを格納する日数の合計。このしきい値を超えたデータは徐々に削除されます
local_retention_days          | 整数           | ブリッジがデータをローカルに格納する日数の合計。通常、データは格納されず、値は `'-1'` に設定されています。これは、ブリッジが指定された時間内にすべてのデータを直接アップロードすることを意味します。このしきい値を超えたデータは徐々に削除されます
longitude                     | 浮動小数点       | ブリッジの設置位置の経度
latitude                      | 浮動小数点       | ブリッジの設置位置の緯度
street_address                | 文字列          | ブリッジの設置位置の住所

<aside class="notice">CMVRモードでは、local_retention_daysとcloud_retention_daysは使用されません</aside>

### ブリッジ - カメラ

パラメータ                       | データ形式  | 詳細
---------                     | --------- | -----------
camera_property_model         | 文字列      | <p hidden>???</p>
model                         | 文字列      | <p hidden>???</p>
camera_property_version       | 文字列      | <p hidden>???</p>
version                       | 文字列      | <p hidden>???</p>
camera_property_make          | 文字列      | <p hidden>???</p>
make                          | 文字列      | <p hidden>???</p>
camera_abs_newest             | 文字列      | <p hidden>???</p>
camera_newest                 | 文字列      | <p hidden>???</p>
camera_abs_oldest             | 文字列      | <p hidden>???</p>
camera_oldest                 | 文字列      | <p hidden>???</p>
uuid                          | 文字列      | [ブリッジの属性](#bridge-model) セクションの `'guid' と同じです
ipaddr                        | 文字列      | デバイスに割り当てられたIPアドレス。カンマで区切られ、アスタリスク (\*) の接頭辞が使用されます
esn                           | 文字列      | [ブリッジの属性](#bridge-model) セクションの `'id' と同じです
class                         | 文字列      | デバイスのタイプを決定します（`'bridge'` または `'camera'`）
service                       | 文字列      | <p hidden>???</p>
[status](#status-bitmask)     | 文字列      | デバイス状態のビットマスク
camera_state_version          | 整数       | <p hidden>???</p>
no_video                      | 整数       | <p hidden>???</p>
tagmap_status_state           | 整数       | <p hidden>???</p>
camera_retention_asset        | 整数       | <p hidden>???</p>
camera_retention_etag         | 整数       | <p hidden>???</p>
run_mode                      | 文字列      | <p hidden>???</p>
register_id                   | 整数       | <p hidden>???</p>
camera_now                    | 文字列      | <p hidden>???</p>
ssn                           | 文字列      | ブリッジのシリアル番号
proxy                         | 文字列      | <p hidden>???</p>
now                           | 文字列      | 要求が完了した現在の時刻のEEN形式：YYYYMMDDHHMMSS.NNN
camera_property_analog        | ブール      | <p hidden>???</p>
[status_hex](#status-bitmask) | 文字列      | デバイス状態のビットマスク16進数値表示
camera_retention_interval     | 整数       | <p hidden>???</p>
camera_valid_ts               | 文字列      | <p hidden>???</p>

<!--TODO: Add the full bridge model bridge attributes table-->

<!--===================================================================-->
## ブリッジの取得
<!--===================================================================-->

IDによってブリッジ オブジェクトが返されます

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/device -d "A=[AUTH_KEY]&id=[BRIDGE_ID]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/device`

パラメータ   | データ型式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**id**    | 文字列    | ブリッジ ID   | true

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | ConnectIDまたはGUIDと一致するデバイスが見つかりませんでした
200 | 要求は成功しました

<!--===================================================================-->
## EEVBへのブリッジの追加
<!--===================================================================-->

Eagle Eyeビデオバンクにブリッジを追加します

> 要求

```shell
curl -X PUT https://login.eagleeyenetworks.com/g/device -d '{"name":"[NAME]","connectID":[CONNECT_ID]}' -H "content-type: application/json"-H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`PUT https://login.eagleeyenetworks.com/g/device`

パラメータ       | データ型式  | 詳細         | 必須？
---------     | --------- | ----------- | -----------
**name**      | 文字列    | ブリッジの名前 | true
**connectid** | 文字列    | アカウントへアクティブなブリッジを追加するにはConnect ID(訳注:Attach ID)が必要になります。全ての非数字、アルファベット文字は無視されます。 | true

> JSON 応答

```json
{
    "id": "100d88a8"
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ型式  | 詳細
--------- | --------- | -----------
id        | 文字列    | デバイスの一意な識別子

### エラー状態コード

HTTP 状態コード    | データ型式   
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | ConnectIDまたはGUIDと一致するデバイスが見つかりませんでした
409 | ConnectIDあたはGUIDは既にアカウントによって使用中です
410 | ブリッジと通信できないため、カメラを割り当てできませんでした
415 | 指定されたGUIDに割り当てられたデバイスはサポートされていません
200 | 要求は成功しました

<!--===================================================================-->
## ブリッジの更新
<!--===================================================================-->

ブリッジの情報を更新します

> 要求

```shell
curl -X POST https://login.eagleeyenetworks.com/g/device -d '{"id": "[BRIDGE_ID], "name": "[NAME]"}' -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/device`

パラメータ                 | データ型式       | 詳細         | 必須？
---------                | ---------     | ----------- | -----------
**id**                   | 文字列         | ブリッジ ID   | true
name                     | 文字列         | ブリッジの名前
timezone                 | 文字列         | デバイスがインストールされている場所の時間帯を示します。デフォルトはアカウントのタイムゾーンです。 例：`'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'` または `'UTC'`
tags                     | 配列[文字列]    | 文字列の配列で、それぞれの文字列はタグ名を表します
[settings](#bridge-settings) | JSON      | 基本設定のJSONオブジェクト（場所など）
camera_parameters_add    | JSON          | 追加/更新するカメラ設定のJSONオブジェクト
camera_parameters_delete | JSON          | 削除するカメラ設定のJSONオブジェクト

> JSON 応答

```json
{
    "id": "100d88a8"
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ型式  | 詳細       
--------- | --------- | -----------
id        | 文字列    | デバイスの一意な識別子

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | IDと一致するデバイスが見つかりませんでした
463 | 設定の追加/削除を行うカメラと通信できません。サポートに連絡してください
200 | 要求は成功しました

<!--===================================================================-->
## ブリッジの削除
<!--===================================================================-->

Eagle Eye ビデオ バンクからブリッジを削除する

> 要求

```shell
curl -X DELETE https://login.eagleeyenetworks.com/g/device -d "id=[BRIDGE_ID]" -G -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`DELETE https://login.eagleeyenetworks.com/g/device`

パラメータ   | データ型式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**id**    | 文字列    | ブリッジ ID     | true

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | IDと一致するデバイスが見つかりませんでした
463 | カメラまたはブリッジと通信できません。サポートに連絡してください
200 | 要求は成功しました

<!--===================================================================-->
## ブリッジのリストを取得する
<!--===================================================================-->

ユーザーが使用可能なブリッジを表すサブ配列をそれぞれに持つ配列の配列を返します。配列中の配列が返された場合、それぞれの子配列はユーザーで有効なデバイスを表します。`'service_status'` 属性は `'ATTD'` または `'IGND'` が設定されます。もし `'service_status'` が `'ATTD'` と表示された場合には、カメラはブリッジに割り当て済みとなります。もし `'service_status'` が `'IGND'` と表示された場合には、カメラはどのブリッジからも未割り当てとなり、割当可能となります。`'service_status'` が 'IDLE'の場合、カメラは登録されますが、動作しません（登録されていないブリッジ）。 `'ERSE'` ステータスは、ブリッジからすべてのカメラデータを消去するために使用されます

> 要求

```shell
curl --request GET https://login.eagleeyenetworks.com/g/device/list --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/device/list`

パラメータ   | データ形式  | 詳細
--------- | --------- | -----------
e         | 文字列     | ブリッジ ID
n         | 文字列     | ブリッジの名前
t         | 文字列     | デバイス形式
s         | 文字列     | デバイスのサービス状態

> JSON 応答

```json
[
    [
        "00004206",
        "100d88a8",
        "Main",
        "bridge",
        [
            [
                "100f2fa1",
                "ATTD"
            ],
            [
                "100c339a",
                "ATTD"
            ]
        ],
        "ATTD",
        "swr",
        [],
        "bceb04ec-8b24-4aee-a09a-8479d856e81c",
        "EEN-BR300-08480",
        1048576,
        "US/Pacific",
        -25200,
        1,
        "",
        0,
        "Greater Good",
        false,
        null,
        null,
        [
            null,
            null,
            null,
            null,
            null,
            null
        ],
        null,
        null,
        0,
        [],
        0
    ],
    [
        "00004206",
        "100c339a",
        "New Camera 1",
        "camera",
        [
            [
                "100d88a8",
                "ATTD"
            ]
        ],
        "ATTD",
        "swr",
        [],
        "1e574020-4e33-11e3-9b40-2504532f70b4",
        "4242325013460008",
        1441847,
        "US/Pacific",
        -25200,
        0,
        "*10.143.14.254",
        0,
        "Greater Good",
        false,
        null,
        null,
        [
            null,
            null,
            null,
            null,
            null,
            null
        ],
        null,
        null,
        0,
        [],
        0
    ],
    [
        "00004206",
        "100f2fa1",
        "Dome",
        "camera",
        [
            [
                "100d88a8",
                "ATTD"
            ]
        ],
        "ATTD",
        "swr",
        [],
        "3b3efd60-432d-11e3-b19b-11ac28dbc101",
        "4016825013440034",
        1441847,
        "US/Pacific",
        -25200,
        0,
        "*10.143.217.117",
        0,
        "Greater Good",
        false,
        null,
        null,
        [
            null,
            null,
            null,
            null,
            "",
            null
        ],
        null,
        null,
        0,
        [],
        0
    ]
]

```

### HTTP 応答 (属性の配列)

配列インデックス| 属性                 | データ型式              | 詳細
----------- | ---------           | ---------            | -----------
0           | account_id          | 文字列                 | デバイスを管理するアカウントの一意の識別子
1           | id                  | 文字列          　     | デバイスの一意の識別子
2           | name                | 文字列            　   | デバイス名
3           | type                | 文字列, 選択リスト       | デバイス形式 <br><br>選択リスト: bridge, camera
4           | cameras             | 配列[配列[文字列]]       | これは文字列配列の配列で、各配列はブリッジに接続されたカメラを表します。 配列の最初の要素はカメラESNです。 2番目の要素はサービス状態です
5           | service_status      | 文字列, 選択リスト       | デバイスサービス状態： <br>`'ATTD'` - カメラはブリッジにアタッチしています <br>`'IGND'` - カメラは全てのブリッジに接続しておらず、ブリッジに接続可能な状態です <br>`'IDLE'` - カメラは登録済みですが、操作されていません (登録されていないブリッジ) <br>`'ERSE'` - この状態になると、全てのカメラ データは削除されます <br><br>ブリッジではこのフィールドは常に `'ATTD'` になります <br><br>選択リスト: ATTD, IGND, IDLE, ERSE
6           | permissions         | 文字列                 | （現在のユーザの）権限レベルをそれぞれ定義する0文字以上の文字列
7           | tags                | 配列[文字列]            | タグ名を表す文字列の配列
8           | guid                | 文字列                 | GUID（Globally Unique Identifier）は、製造プロセス中にデバイスに割り当てられる不変のデバイス識別子です
9           | serial_number       | 文字列                 | デバイスのシリアル番号
10          | [device_status](#status-bitmask) | 整数      | デバイス状態のビットマスク
11          | timezone            | 文字列                 | デバイスがインストールされている場所の時間帯を示します。デフォルトはアカウントのタイムゾーンです。例： `'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'` または `'UTC'` など
12          | timezone_utc_offset | 整数                  | UTCからのタイムゾーンの秒単位の符号付き整数オフセット
13          | is_unsupported      | 整数                  | デバイスがサポートされていないか(1)、されているか(0)
14          | ip_address          | 文字列                 | デバイスに割り当てられたIPアドレス
15          | is_shared           | 整数                  | デバイスが共有されているか(1)、いないか(0) <small>**(カメラにのみ適用)**</small>
16          | owner_account_name  | 文字列                 | デバイスを所有するアカウントの名前
17          | is_upnp             | ブール                 | デバイスがUPNPデバイスか(1)否か(0)を示します <small>**(ONVIFまたはUPNP経由で検出されたカメラのうち、まだ割り当てられていないカメラにのみ適用されます)**</small>
18          | video_input         | 文字列                 | カメラのビデオ入力チャネルを示します。 <small>**(アナログカメラに適用)**</small>
19          | video_status        | 文字列                 | カメラのビデオ状態を示します： <small>**(アナログカメラに適用)**</small> <br>`'0x00000000'` - シグナル OK <br>`'0x00000102'` - シグナルなし
20          | location            | 配列                  | 次の方法で指定されたデバイスの設置場所: <br><br>`[` <br>&nbsp;&nbsp;&nbsp;&nbsp;`latitude(浮動小数点),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`longitude(浮動小数点),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`azimuth(浮動小数点/null for bridge),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`range(整数/null for bridge),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`street address(文字列),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`floor(整数),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`location name(文字列)` <br>`]` <br><br>注：フィールドが設定されていない場合、値はnullになります
21          | parent_camera_id    | 文字列                | 親カメラ ID
22          | child_camera_view   | 文字列                | 子カメラビュー
23          | is_hidden           | 整数                  | 非表示デバイスのGUI制御
24          | ignored_inputs      | 配列[文字列]           | ブリッジが無視すべきアナログポート番号の配列
25          | responder_camera    | 整数                  | カメラがファースト・レスポンダカメラか(1)、否か(0)を示します

<aside class="success">モデル定義にはプロパティ キーがありますが、これは単なる標準配列なので参照用です</aside>

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
200 | 要求は成功しました
