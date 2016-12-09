# メトリック

<!--===================================================================-->
## Overview

このサービスはシステムからクエリ可能なメトリクスを定義します。

<!--===================================================================-->
## Camera Bandwidth

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/metric/camerabandwidth -d "A=[AUTH_KEY]&id=[CAMERA_ID]"
```

Used to query the bandwidth usage for a particular camera device.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/metric/camerabandwidth`

パラメータ       | データ型式   	| 詳細         	| 必須？
---------       | ----------- 	| -----------  	| ----------- 
**id**   		| 文字列      	| Bridge Id 	| true
start_timestamp | 文字列      	| Start timestamp of query, in EEN format: YYYYMMDDHHMMSS.NNN. Defaults to 7 days ago.
end_timestamp  	| 文字列   		| End timestamp of query, in EEN format: YYYYMMDDHHMMSS.NNN. Defaults to now.
group_by 		| 文字列, enum  | Hour or Day, indicating how the results should be grouped. <br><br>enum: day, hour, minute
motion_interval | 整数      		| Motion Interval used for Motion Activity metric, in milliseconds. Defaults to 15000.
metric          | 文字列, enum  | String delimited list used to filter which metrics gets returned. Setting this parameter to 'core,motion' will return data only for core and motion. <br><br>enum: core, packets, motion

> JSON応答

```json
{
    "core": [
        [
            "20141002190000.000",
            0.0,
            0.0,
            215910545.0,
            76733036.0,
            32049659.0,
            52716510.0
        ],
        [
            "20141002200000.000",
            0.0,
            0.0,
            252051927.0,
            164214711.0,
            36128066.0,
            223484133.0
        ],
        [...],
        [...],
        [...],
        [
            "20141009190000.000",
            0.0,
            0.0,
            41425890.0,
            10373660.0,
            5029677.0,
            78599812.0
        ]
    ],
    "packets": [
        [
            "20141002190000.000",
            0.00183
        ],
        [
            "20141002200000.000",
            0.0018439999999999999
        ],
        [...],
        [...],
        [...],
        [
            "20141009190000.000",
            0.0
        ]
    ],
    "motion": []
}
```

### 応答JSON属性

パラメータ       | データ型式                     | 詳細          
---------       | -----------                   | -----------  
core            | array[[CameraCore](#cameracore-json-array-elements)]     | Array of core metrics
packets         | array[[CameraPackets](#camerapackets-json-array-elements)]  | Array of packet metrics
motion          | array[[CameraMotion](#cameramotion-json-array-elements)] | Array of motion metrics

### CameraCore Json Array Elements

Index       | データ型式     | 詳細       
---------   | -----------   | -----------  
0           | 文字列        | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1           | 浮動小数点         | Average Kilobytes on Disk
2           | 浮動小数点         | Average Days on Disk
3           | 浮動小数点         | Bytes Stored
4           | 浮動小数点         | Bytes Shaped
5           | 浮動小数点         | Bytes Streamed
6           | 浮動小数点         | Bytes Freed

### CameraPackets Json Array Elements

Index       | データ型式     | 詳細       
---------   | -----------   | -----------  
0           | 文字列        | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1           | 浮動小数点         | Packet loss percentage (decimal)

### CameraMotion Json Array Elements

Index       | データ型式     | 詳細       
---------   | -----------   | -----------  
0           | 文字列        | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1           | 整数           | motion activity value

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
404 | Metrics not found

<!--===================================================================-->
## Bridge Bandwidth

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/metric/bridgebandwidth -d "A=[AUTH_KEY]&id=[BRIDGE_ID]"
```

Used to query the bandwidth usage for a particular bridge device.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/metric/bridgebandwidth`

パラメータ       | データ型式   	| 詳細         	| 必須？
---------       | ----------- 	| -----------  	| ----------- 
**id**   		| 文字列      	| Bridge Id 	| true
start_timestamp | 文字列      	| Start timestamp of query, in EEN format: YYYYMMDDHHMMSS.NNN. Defaults to 7 days ago.
end_timestamp  	| 文字列   		| End timestamp of query, in EEN format: YYYYMMDDHHMMSS.NNN. Defaults to now.
group_by 		| 文字列, enum  | Hour or Day, indicating how the results should be grouped. <br><br>enum: day, hour, minute

> JSON応答

```json
{
    "core": [
        [
            "20141002170000.000",
            711610368.0,
            673860608.0,
            21533380.0,
            10299.0,
            10064282.0,
            9903.0
        ],
        [
            "20141002180000.000",
            711610368.0,
            673802922.66666698,
            139693604.0,
            16579176.0,
            30849223.0,
            70446106.0
        ],
        [...],
        [...],
        [...],
        [
            "20141009170000.000",
            711610368.0,
            674052608.0,
            20663486.0,
            8637204.0,
            18879693.0,
            19383808.0
        ]
    ],
    "bandwidth": [
        [
            "20141002180000.000",
            253117.37089200001
        ],
        [
            "20141002220000.000",
            240255.52353499999
        ],
        [...],
        [...],
        [...],
        [
            "20141009150000.000",
            232692.09302299999
        ]
    ],
    "storage": [
        [
            "20141002170000.000",
            21523477
        ],
        [
            "20141002180000.000",
            69247498
        ],
        [...],
        [...],
        [...],
        [
            "20141009170000.000",
            1279678
        ]
    ]
}
```

### 応答JSON属性

パラメータ       | データ型式         | 詳細          
---------       | -----------       | -----------  
core            | array[[BridgeCore](#bridgecore-json-array-elements)]       | Array of core metrics
bandwith        | array[[BridgeBandwidth](#bridgecore-json-array-elements)]  | Array of bandwidth metrics
storage         | array[BridgeStorage](#bridgestorage-json-array-elements)]    | Array of storage metrics

### BridgeCore Json Array Elements

Index       | データ型式     | 詳細       
---------   | -----------   | -----------  
0           | 文字列        | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1           | 浮動小数点         | Average Kilobytes on Disk
2           | 浮動小数点         | Average Days on Disk
3           | 浮動小数点         | Bytes Stored
4           | 浮動小数点         | Bytes Shaped
5           | 浮動小数点         | Bytes Streamed
6           | 浮動小数点         | Bytes Freed

### BridgeBandwidth Json Array Elements

Index       | データ型式     | 詳細       
---------   | -----------   | -----------  
0           | 文字列        | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1           | 浮動小数点         | Bytes per second

### BandwidthStorage Json Array Elements

Index       | データ型式     | 詳細       
---------   | -----------   | -----------  
0           | 文字列        | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1           | 浮動小数点         | Bytes Diff

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
404 | Metrics not found