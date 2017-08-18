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

パラメータ                      | データ形式       | 詳細                                                                                                 | 編集可？      | 必須？
---------                     | ---------     | -----------                                                                                         |:-----------:| --------
**id**                        | 文字列        | Unique identifier automatically generated and assigned while adding a device                        | **&cross;** | **<sub><form action="#get-bridge"><button>GET</button></form></sub>** <br>**<sub><form action="#update-bridge"><button>POST</button></form></sub>** <br>**<sub><form action="#delete-bridge"><button>DELETE</button></form></sub>**
**name**                      | 文字列        | Name of the bridge                                                                                  | **&check;** | **<sub><form action="#add-bridge-to-eevb"><button>PUT</button></form></sub>**
guid                          | 文字列        | The GUID (Globally Unique Identifier) is an immutable device identifier assigned to a device during the production process                                                                                                                                             | **&cross;** |
timezone                      | 文字列        | Indicates the timezone of where the device is installed. Defaults to the account timezone. Example: `'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'` or `'UTC'`                                                     | **&check;** |
utcOffset                     | 整数           | The signed integer offset in seconds of a timezone from UTC. Automatically generated based on the timezone field                                                                                                                                               | **&cross;** |
tags                          | 配列[文字列] | Array of strings each representing a tag name                                                       | **&check;** |
permissions                   | 文字列        | String of characters each defining a permission level of the current user                           | **&cross;** |
[bridges](#camera-bridges)    | JSON          | <small>**(APPLIES ONLY TO CAMERAS)**</small>                                                        | **&cross;** |
[settings](#bridge-settings)  | JSON          | Json object of basic settings (location, etc.)                                                      | **&check;** |
[camera_info](#bridge-camera_info) | JSON          | Json object of basic bridge information. If bridge information cannot be retrieved for whatever reason (example: communication with the bridge has been lost), this will be empty and camera_info_status_code will be 404                                            | **&cross;** |
camera_info_status_code       | 整数           | Indicates whether it was possible to retrieve information about the device (200) or not (404)       | **&cross;** |
camera_parameters             | JSON          | Json object of bridge parameters. If bridge parameters cannot be retrieved for whatever reason (example: communication with the bridge has been lost), this will be empty and camera_parameters_status_code will be 404                                                         | **&check;** |
camera_parameters_status_code | 整数           | Indicates whether it was possible to retrieve parameters of the device (200) or not (404)           | **&cross;** |
camera_settings               | 文字列        | This is for backwards compatibility <small>**(DEPRECATED)**</small>                                 | **&cross;** |
camera_settings_status_code   | 整数           | This is for backwards compatibility <small>**(DEPRECATED)**</small>                                 | **&cross;** |

### ブリッジ - 設定

Parameter                     | Data Type     | Description
---------                     | ---------     | -----------
analog_inputs_ignored         | 配列[文字列] | An array of numbers of analog inputs which the user wants to ignore
event_data_start_timestamp    | 文字列        | <p hidden>???</p>
local_display_layout_ids      | 配列[文字列] | An array of available layouts on a local display
bridge                        | null          | <small>**(APPLIES ONLY TO CAMERAS)**</small>
site_name                     | 文字列        | User-defined bridge location name
floor                         | 整数           | The floor of the building given that it is a multi-storey
retention_days                | 整数           | Total amount of days the bridge should store data. Data exceeding this threshold will gradually be deleted
local_retention_days          | 整数           | Total amount of days the bridge should store data locally. Normally data is not being stored and the value is set to `'-1'`, meaning the bridge should directly upload any and all data during the specified times. Data exceeding this threshold will gradually be deleted
longitude                     | float         | Longitude of the bridge location
latitude                      | float         | Latitude of the bridge location
street_address                | 文字列        | Street address of the bridge location

<aside class="notice">local_retention_days and cloud_retention_days are unpurposed in CMVR mode</aside>

### ブリッジ - カメラ

Parameter                     | Data Type | Description
---------                     | --------- | -----------
camera_property_model         | 文字列    | <p hidden>???</p>
model                         | 文字列    | <p hidden>???</p>
camera_property_version       | 文字列    | <p hidden>???</p>
version                       | 文字列    | <p hidden>???</p>
camera_property_make          | 文字列    | <p hidden>???</p>
make                          | 文字列    | <p hidden>???</p>
camera_abs_newest             | 文字列    | <p hidden>???</p>
camera_newest                 | 文字列    | <p hidden>???</p>
camera_abs_oldest             | 文字列    | <p hidden>???</p>
camera_oldest                 | 文字列    | <p hidden>???</p>
uuid                          | 文字列    | Identical to `'guid'` from the [bridge attributes](#bridge-model) section
ipaddr                        | 文字列    | IP addresses assigned to the device, comma delimited, with the one in use prefixed by an asterisk (\*)
esn                           | 文字列    | Identical to `'id'` from the [bridge attributes](#bridge-model) section
class                         | 文字列    | Determines the type of a device (`'bridge'` or `'camera'`)
service                       | 文字列    | <p hidden>???</p>
[status](#status-bitmask)     | 文字列    | The device status bitmask
camera_state_version          | 整数       | <p hidden>???</p>
no_video                      | 整数       | <p hidden>???</p>
tagmap_status_state           | 整数       | <p hidden>???</p>
camera_retention_asset        | 整数       | <p hidden>???</p>
camera_retention_etag         | 整数       | <p hidden>???</p>
run_mode                      | 文字列    | <p hidden>???</p>
register_id                   | 整数       | <p hidden>???</p>
camera_now                    | 文字列    | <p hidden>???</p>
ssn                           | 文字列    | The serial number of a bridge
proxy                         | 文字列    | <p hidden>???</p>
now                           | 文字列    | The current time of when the request has been completed in EEN format: YYYYMMDDHHMMSS.NNN
camera_property_analog        | ブール   | <p hidden>???</p>
[status_hex](#status-bitmask) | 文字列    | The device status bitmask as a hexadecimal value
camera_retention_interval     | 整数       | <p hidden>???</p>
camera_valid_ts               | 文字列    | <p hidden>???</p>

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
463 | 設定の追加/削除を行うカメラと通信できません。サポートに連絡してください。
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
463 | カメラまたはブリッジと通信できません。サポートに連絡してください。
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
0           | account_id          | 文字列               | Unique identifier of the device’s account
1           | id                  | 文字列               | Unique identifier of a device
2           | name                | 文字列               | Device name
3           | type                | 文字列, 選択リスト         | Device type <br><br>選択リスト: bridge, camera
4           | cameras             | array[array[文字列]] | This is an array of string arrays, each array representing a camera that is attached to the bridge. The first element of the array is the camera ESN. The second element is the service status
5           | service_status      | 文字列, 選択リスト         | Device service status: <br>`'ATTD'` - camera is attached to a bridge <br>`'IGND'` - camera is unattached from all bridges and is available to be attached to a bridge <br>`'IDLE'` - camera will register but will not operate (unregistered bridges) <br>`'ERSE'` - one shot, all camera data will be erased <br><br>For bridges this field is always `'ATTD'` <br><br>選択リスト: ATTD, IGND, IDLE, ERSE
6           | permissions         | 文字列               | String of zero or more characters each defining a permission level (of the current user)
7           | tags                | 配列[文字列]        | Array of strings each representing a tag name
8           | guid                | 文字列               | The GUID (Globally Unique Identifier) is an immutable device identifier assigned to a device during the production process
9           | serial_number       | 文字列               | Serial number of the device
10          | [device_status](#status-bitmask) | 整数                  | The device status bitmask
11          | timezone            | 文字列               | Indicates the timezone of where the device is installed. Defaults to the account timezone. Example: `'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'` or `'UTC'`
12          | timezone_utc_offset | 整数                  | The signed integer offset in seconds of a timezone from UTC
13          | is_unsupported      | 整数                  | Indicates whether the device is NOT supported (1) or is supported (0)
14          | ip_address          | 文字列               | IP address assigned to the device
15          | is_shared           | 整数                  | Indicates whether the device is shared (1) or not (0) <small>**(APPLIES ONLY TO CAMERAS)**</small>
16          | owner_account_name  | 文字列               | Name of the account that owns the device
17          | is_upnp             | boolean              | Indicates whether the device is a UPNP device (1) or not (0) <small>**(APPLIES ONLY TO CAMERAS THAT HAVEN’T YET BEEN ATTACHED TO THE ACCOUNT, IN WHICH THEY COULD HAVE BEEN DETECTED VIA ONVIF OR UPNP)**</small>
18          | video_input         | 文字列               | Indicates the video input channel of the camera <small>**(APPLIES TO ANALOG CAMERAS)**</small>
19          | video_status        | 文字列               | Indicates the video status of the camera: <small>**(APPLIES TO ANALOG CAMERAS)**</small> <br>`'0x00000000'` - signal ok <br>`'0x00000102'` - no signal
20          | location            | 配列                | Location of the device specified in the following way: <br><br>`[` <br>&nbsp;&nbsp;&nbsp;&nbsp;`latitude(float),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`longitude(float),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`azimuth(float/null for bridge),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`range(int/null for bridge),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`street address(文字列),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`floor(int),` <br>&nbsp;&nbsp;&nbsp;&nbsp;`location name(string)` <br>`]` <br><br>Note: If any field is not set, the value is null
21          | parent_camera_id    | 文字列               | Parent camera ID
22          | child_camera_view   | 文字列               | Child camera view
23          | is_hidden           | 整数                  | GUI control to not show device
24          | ignored_inputs      | 配列[文字列]        | Array of analog port numbers which should be ignored by the bridge
25          | responder_camera    | 整数                  | Indicates whether the camera is a first responder camera (1) or not (0)

<aside class="success">モデル定義にはプロパティ キーがありますが、これは単なる標準配列なので参照用です</aside>

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
200 | 要求は成功しました
