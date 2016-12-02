# ブリッジ

<!--===================================================================-->
## 概要
The Bridge is a product of Eagle Eye that sits at the customer location and talks to industry standard cameras. It converts the Cameras to be compatible with the EEVB and record the Assets. The Bridge is setup and controlled via a cloud based user inteface. There is no user interface on the Bridge. The Bridge may serve local Assets directly to local Clients. The Bridge will also store Assets until they are transferred to the EEVB. The Bridge may be configured via DHCP or with a static IP address.

<!--===================================================================-->
## Get Bridge

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

Returns user object by id. Not passing an id will return the current authorized user.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/device`

パラメータ     | データ型式   | 詳細
---------     | ----------- | -----------
**id**        | 文字列      | Bridge Id

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges

<!--===================================================================-->
## Add Bridge to EEVB

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

Adds a bridge to the Eagle Eye Video Bank

### HTTP要求

`PUT https://login.eagleeyenetworks.com/g/device`

パラメータ | データ型式     | 詳細        
--------- | -----------   | ----------- 
name      | 文字列        | Bridge Name
connectID | 文字列        | Connect ID is needed to add and activate bridge to account. All non-alphanumeric characters will be stripped.

### 応答JSON属性

パラメータ       | データ型式   | 詳細       
---------       | ----------- | -----------
id              | 文字列      | Unique identifier for the device

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
404 | No device matching the ConnectID or GUID was found
409 | ConnectID or GUID is currently already in use by an account
410 | Communication cannot be made to attach the camera to the bridge
415 | Device associated with the given GUID is unsupported

<!--===================================================================-->
## Update Bridge

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
**id**                    | 文字列        | Bridge Id     | true
name                      | 文字列        | Bridge Name
timezone                  | 文字列s       | If unspecified, this will default to the camera’s Bridge timezone
tags                      | 配列[文字列] | Array of strings, which each string representing a "tag"
settings                  | json          | Misc Settings
camera_parameters_add     | json          | JSON object of camera parameters/settings to add/update
camera_parameters_delete  | json          | JSON object of camera parameters/settings to delete

### 応答JSON属性

パラメータ       | データ型式   | 詳細       
---------       | ----------- | -----------
id              | 文字列      | Unique identifier for the device

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
404 | Device matching the ID was not found
463 | Unable to communicate with the camera to add/delete camera settings, contact support

<!--===================================================================-->
## Delete Bridge

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X DELETE -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/device -d "id=[BRIDGE_ID]" -G
```

### HTTP要求

`DELETE https://login.eagleeyenetworks.com/g/device`

パラメータ     | データ型式   | 詳細
---------     | ----------- | -----------
**id**        | 文字列      | Bridge Id

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
404 | Device matching the ID was not found
463 | Unable to communicate with the camera or bridge, contact support

<!--===================================================================-->
## Get List of Bridges

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

Returns array of arrays, with each sub-array representing a device available to the user. The 'service_status' attribute either be set to 'ATTD' or 'IGND'. If the service_status is 'ATTD', the camera is attached to a bridge. If the service_status is 'IGND', the camera is unattached from any bridge and is available to be attached. Please note that the ListDevice model definition below has property keys, but that's only for reference purposes since it's actually just a standard array.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/device/list`

パラメータ | データ型式   | 詳細                  
--------- | ----------- | -----------           
e         | 文字列      | Bridge Id             
n         | 文字列      | Bridge Name           
t         | 文字列      | Device Type           
s         | 文字列      | Device Service Status

### Response: Bridge Model

Array Index | Attribute       | データ型式  
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
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
