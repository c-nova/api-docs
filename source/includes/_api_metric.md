# メトリック

<!--===================================================================-->
## 概要
<!--===================================================================-->

このサービスはシステムからクエリ可能なメトリクスを定義します。

<!--===================================================================-->
## カメラの帯域幅
<!--===================================================================-->

特定のカメラデバイスの帯域幅の使用量をクエリするために使用されます

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/metric/camerabandwidth -d "A=[AUTH_KEY]&id=[CAMERA_ID]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/metric/camerabandwidth`

パラメータ        | データ型式      | 詳細         | 必須？
---------       | ---------    | ----------- | -----------
**id**          | 文字列         | Camera ID   | true
start_timestamp | 文字列         | Start timestamp of query in EEN format: YYYYMMDDHHMMSS.NNN. Defaults to 7 days ago
end_timestamp   | 文字列         | End timestamp of query in EEN format: YYYYMMDDHHMMSS.NNN. Defaults to *now*
group_by        | 文字列, 選択リスト | Hour or day indicating how the results should be grouped <br><br>選択リスト: day, hour, minute
motion_interval | 整数          | Motion Interval used for Motion Activity metric, in milliseconds. Defaults to 15000
metrics         | 文字列, 選択リスト | String delimited list used to filter which metrics get returned. Setting this parameter to `'core,motion'` will return data only for core and motion <br><br>選択リスト: core, packets, motion

> JSON 応答

```json
{
    "core": [
        [
            "20181002190000.000",
            0.0,
            0.0,
            215910545.0,
            76733036.0,
            32049659.0,
            52716510.0
        ],
        [
            "20181002200000.000",
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
            "20181009190000.000",
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
            "20181002190000.000",
            0.00183
        ],
        [
            "20181002200000.000",
            0.0018439999999999999
        ],
        [...],
        [...],
        [...],
        [
            "20181009190000.000",
            0.0
        ]
    ],
    "motion": []
}
```

### HTTP 応答 (JSON 属性)

パラメータ  | データ型式   | 詳細
--------- | --------- | -----------
core      | 配列[[CameraCore](#cameracore-json-array-elements)]       | Array of core metrics
packets   | 配列[[CameraPackets](#camerapackets-json-array-elements)] | Array of packet metrics
motion    | 配列[[CameraMotion](#cameramotion-json-array-elements)]   | Array of motion metrics

### CameraCore JSON 属性の配列

インデックス | データ型式  | 詳細
-----     | --------- | -----------
0         | 文字列     | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1         | 浮動小数点  | Average kilobytes on disk
2         | 浮動小数点  | Average days on disk
3         | 浮動小数点  | Bytes stored
4         | 浮動小数点  | Bytes shaped
5         | 浮動小数点  | Bytes streamed
6         | 浮動小数点  | Bytes freed

### CameraPackets JSON 属性の配列

インデックス | データ型式  | 詳細
-----     | --------- | -----------
0         | 文字列     | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1         | 浮動小数点  | Packet loss percentage (decimal)

### CameraMotion JSON 属性の配列

インデックス | データ型式  | 詳細
-----     | --------  | -----------
0         | 文字列     | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1         | 整数       | Motion activity value

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
404 | Metrics not found
200 | Request succeeded

<!--===================================================================-->
## ブリッジの帯域幅
<!--===================================================================-->

特定のブリッジ デバイスの帯域幅の使用量をクエリするために使用されます

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/metric/bridgebandwidth -d "A=[AUTH_KEY]&id=[BRIDGE_ID]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/metric/bridgebandwidth`

パラメータ        | データ型式      | 詳細         | 必須？
---------       | ---------    | ----------- | -----------
**id**          | 文字列        | Bridge ID   | true
start_timestamp | 文字列        | Start timestamp of query in EEN format: YYYYMMDDHHMMSS.NNN. Defaults to 7 days ago
end_timestamp   | 文字列        | End timestamp of query in EEN format: YYYYMMDDHHMMSS.NNN. Defaults to *now*
group_by        | 文字列, 選択リスト | Hour or day indicating how the results should be grouped <br><br>enum: day, hour, minute

> JSON 応答

```json
{
    "core": [
        [
            "20181002170000.000",
            711610368.0,
            673860608.0,
            21533380.0,
            10299.0,
            10064282.0,
            9903.0
        ],
        [
            "20181002180000.000",
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
            "20181009170000.000",
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
            "20181002180000.000",
            253117.37089200001
        ],
        [
            "20181002220000.000",
            240255.52353499999
        ],
        [...],
        [...],
        [...],
        [
            "20181009150000.000",
            232692.09302299999
        ]
    ],
    "storage": [
        [
            "20181002170000.000",
            21523477
        ],
        [
            "20181002180000.000",
            69247498
        ],
        [...],
        [...],
        [...],
        [
            "20181009170000.000",
            1279678
        ]
    ]
}
```

### HTTP Response (Json Attributes)

パラメータ  | データ型式   | 詳細
--------- | --------- | -----------
core      | 配列[[BridgeCore](#bridgecore-json-array-elements)]           | Array of core metrics
bandwith  | 配列[[BridgeBandwidth](#bridgebandwidth-json-array-elements)] | Array of bandwidth metrics
storage   | 配列[[BridgeStorage](#bridgestorage-json-array-elements)]     | Array of storage metrics

### BridgeCore JSON 属性の配列

インデックス | データ型式  | 詳細
-----     | --------- | -----------
0         | 文字列      | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1         | 浮動小数点   | Average kilobytes on disk
2         | 浮動小数点   | Average days on disk
3         | 浮動小数点   | Bytes stored
4         | 浮動小数点   | Bytes shaped
5         | 浮動小数点   | Bytes streamed
6         | 浮動小数点   | Bytes freed

### BridgeBandwidth JSON 属性の配列

インデックス | データ型式  | 詳細
-----     | --------- | -----------
0         | 文字列     | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1         | 浮動小数点  | Bytes per second

### BridgeStorage JSON 属性の配列

インデックス | データ型式  | 詳細
-----     | --------- | -----------
0         | 文字列     | EEN Timestamp: YYYYMMDDHHMMSS.NNN
1         | 浮動小数点  | Bytes difference

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
401 | Unauthorized due to invalid session cookie
403 | Forbidden due to the user missing the necessary privileges
404 | Metrics not found
200 | Request succeeded
