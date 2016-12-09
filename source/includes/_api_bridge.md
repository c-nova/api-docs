# ブリッジ

<!--===================================================================-->
## 概要
ブリッジはお客様先に設置され、業界標準カメラと通信を行うEagle Eyeの製品です。これによりカメラはEEVBとアセットの保存と互換するように変換されます。ブリッジはクラウドベースのユーザーインターフェイス経由でセットアップや制御が行われます。ブリッジにはユーザーインターフェイスはありません。ブリッジはローカルのクライアントのために、ローカルストレージに直接保存することが可能です。ブリッジはまた資産をEEVBに転送し、保存することが可能です。ブリッジはDHCPまたは固定IPアドレスによって構成されます。


<!--===================================================================-->
## ブリッジの取得

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/device -d "A=[AUTH_KEY]&id=[BRIDGE_ID]"
```

> JSON応答

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

ユーザー オブジェクトはIDによって返されます。IDが返されない場合には現在認可されているユーザーが返されます。

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/device`

パラメータ     | データ型式   | 詳細
---------     | ----------- | -----------
**id**        | 文字列      | ブリッジID

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました

<!--===================================================================-->
## EEVBへのブリッジの追加

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X PUT -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/device -d '{"name":"[NAME]","connectID":[CONNECT_ID]}'
```

> JSON応答

```json
{
  "id": "100c339a"
}
```

Eagle Eyeビデオバンクにブリッジを追加します

### HTTP要求

`PUT https://login.eagleeyenetworks.com/g/device`

パラメータ | データ型式     | 詳細        
--------- | -----------   | ----------- 
name      | 文字列        | ブリッジの名前
connectID | 文字列        | アカウントへアクティブなブリッジを追加するにはConnect ID(訳注:Attach ID)が必要になります。全ての非数字、アルファベット文字は無視されます。

### 応答JSON属性

パラメータ       | データ型式   | 詳細       
---------       | ----------- | -----------
id              | 文字列      | デバイスの一意な識別子

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | ConnectIDまたはGUIDと一致するデバイスが見つかりませんでした
409 | ConnectIDあたはGUIDは既にアカウントによって使用中です
410 | ブリッジと通信できないため、カメラを割り当てできませんでした
415 | 指定されたGUIDに割り当てられたデバイスはサポートされていません

<!--===================================================================-->
## ブリッジの更新

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X POST -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/device -d '{"id": "[BRIDGE_ID], "name": "[NAME]"}'
```

> JSON応答

```json
{
  "id": "100c339a"
}
```

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/device`

パラメータ                 | データ型式     | 詳細          | 必須？
---------                 | -----------   | -----------   | -----------
**id**                    | 文字列        | ブリッジID     | true
name                      | 文字列        | ブリッジの名前
timezone                  | 文字列       | 未指定の場合、タイムゾーンは接続するブリッジのタイムゾーンになります(訳注:原文誤り。正しくはアカウントのタイムゾーンになる)
tags                      | 配列[文字列] | 文字列の配列で、それぞれの文字列は "tag" を表します。
settings                  | json          | その他設定
camera_parameters_add     | json          | カメラの追加、更新を行うパラメータ/設定のJSONオブジェクト
camera_parameters_delete  | json          | カメラの削除するパラメータ/設定のJSONオブジェクト

### 応答JSON属性

パラメータ       | データ型式   | 詳細       
---------       | ----------- | -----------
id              | 文字列      | デバイスの一意な識別子

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | IDと一致するデバイスが見つかりませんでした
463 | 設定の追加/削除を行うカメラと通信できません。サポートに連絡してください。

<!--===================================================================-->
## ブリッジの削除

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X DELETE -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/device -d "id=[BRIDGE_ID]" -G
```

### HTTP要求

`DELETE https://login.eagleeyenetworks.com/g/device`

パラメータ     | データ型式   | 詳細
---------     | ----------- | -----------
**id**        | 文字列      | ブリッジID

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | IDと一致するデバイスが見つかりませんでした
463 | カメラまたはブリッジと通信できません。サポートに連絡してください。

<!--===================================================================-->
## ブリッジのリストを取得する

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request GET https://login.eagleeyenetworks.com/g/device/list
```

> JSON応答

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
        ]
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
        ]
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
        ]
    ]
]
```

配列中の配列が返された場合、それぞれの子配列はユーザーで有効なデバイスを表します。'service_status' 属性は 'ATTD' または 'IGND' が設定されます。もしservice_statusが 'ATTD' と表示された場合には、カメラはブリッジに割り当て済みとなります。もしservice_statusが 'IGND' と表示された場合には、カメラはどのブリッジからも未割り当てとなり、割当可能となります。上記のListDevice モデル定義はプロパティ キーを持ちますが、これは参照のみを目的とした標準的な配列であることに注意してください。

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/device/list`

パラメータ | データ型式   | 詳細                  
--------- | ----------- | -----------           
e         | 文字列      | ブリッジID
n         | 文字列      | ブリッジの名前
t         | 文字列      | デバイスの形式
s         | 文字列      | デバイスのサービス状態

### 応答: ブリッジ モデル

配列インデックス | 属性       | データ型式  
---------   | -----------     | -----------
0           | account_id      | 文字列
1           | id              | 文字列
2           | name            | 文字列
3           | type            | 文字列
4           | bridges         | json
5           | service_status  | 文字列
6           | permissions     | 文字列
7           | tags            | 配列[文字列]
8           | guid            | 文字列
9           | serial_number   | 文字列
10          | [device_status](#status-bitmask)   | 整数
11          | timezone        | 文字列
12          | timezone_utc_offset | 整数
13          | is_unsupported  | 整数
14          | ip_address      | 文字列
15          | is_shared       | 整数
16          | owner_account_name | 文字列
17          | is_upnp         | boolean
18          | video_input     | 文字列
19          | video_status    | 文字列

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
