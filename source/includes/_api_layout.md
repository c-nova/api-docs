# レイアウト

<!--===================================================================-->
## 概要
<!--===================================================================-->

レイアウトはペインを含み、それらは画面の表示を行うためのカメラのグループを整理します。レイアウトはアカウントとアカウント ユーザーがレイアウトに対して与えられた 表示/書き込み/共有 権限に関連付けられます。ユーザーはカメラに対してアクセスできない場合であっても、共有されたレイアウトに含まれる全てのカメラに対してアクセスすることができます

レイアウトへのアクセスに関する重要な情報：  

  - 新しく作成されたユーザーは、ユーザー作成時より前にアカウントに存在するすべてのレイアウトに対して読み取り専用のアクセス権（レイアウトの許可文字列の「R」文字）を取得します
  - ユーザーは新しく作成されたレイアウトにアクセスすることはできません。 権限は明示的に割り当てられなければなりません。 *例外：is_layout_admin フラグを持つユーザーは、既存または新規のすべてのレイアウトに自由にアクセスできます*
  - スーパーユーザーとアカウントのスーパーユーザーは、レイアウトへの制約のないアクセス権を持ち、レイアウトのアクセス許可によって制限することはできません


ペインの並び順は、APIによって返される LayoutJsonPane 配列内の順序によって決定されます。それぞれのペインは1, 2または3のサイズを持ちます。サイズ1は最小で、レイアウト グリッド内で 1x1 の大きさを専有します。サイズ3は最大で、レイアウト グリッド内で 3x3 の大きさを専有します。もしグリッドがペインにフィットする十分な列を持っていない場合、ペインのサイズはグリッドがフィットするまで縮小されます。

Web及びモバイルでのレイアウト描画は以下のようになります:
<img src="images/api_layout/example_1.png" alt="Example 1" width="1000">
<img src="images/api_layout/example_2.png" alt="Example 2" width="400">

<!--===================================================================-->
## レイアウト モデル
<!--===================================================================-->

> レイアウト モデル

```json
{
    "id": "0b58ec7a-61e4-11e3-8f7d-523445989f37",
    "name": "Everything",
    "types": [
        "mobile"
    ],
    "permissions": "SWRD",
    "current_recording_key": null,
    "shares": [
        [
            "ca01ce6d",
            "SWRD"
        ],
        [
            "ca0c7d2c",
            "R"
        ],
        [...],
        [...],
        [...],
        [
            "ca05e8c2",
            "R"
        ]
    ],
    "configuration": {
        "panes": [
            {
                "cameras": [
                    "100ace90"
                ],
                "type": "preview",
                "pane_id": 0,
                "name": "",
                "size": 1
            },
            {
                "cameras": [
                    "10045dd6"
                ],
                "type": "preview",
                "pane_id": 0,
                "name": "",
                "size": 1
            },
            {...},
            {...},
            {...},
            {
                "cameras": [
                    "100891b7"
                ],
                "type": "preview",
                "pane_id": 0,
                "name": "",
                "size": 1
            }
        ],
        "settings": {
            "camera_row_limit": 3,
            "camera_name": true,
            "camera_aspect_ratio": 0.5625,
            "camera_border": false
        }
    }
}
```

### レイアウト (属性)

プロパティ              | データ形式              | 詳細                                                                                                  | 編集可能      | 必須？
--------              | ---------            | -----------                                                                                          |:-----------:| --------
**id**                | 文字列               | Unique identifier for the layout                                                                     | **&cross;** | **<sub><form action="#get-layout"><button>GET</button></form></sub>** <br>**<sub><form action="#update-layout"><button>POST</button></form></sub>** <br>**<sub><form action="#delete-layout"><button>DELETE</button></form></sub>**
**name**              | 文字列               | Name of the layout                                                                                   | **&check;** | **<sub><form action="#create-layout"><button>PUT</button></form></sub>**
**types**             | 配列[文字列]        | Specifies target(s) for layout. Multiple values are allowed                                          | **&check;** | **<sub><form action="#create-layout"><button>PUT</button></form></sub>**
**[configuration](#layout-configuration)** | JSON             | Json object of layout configuration                                                     | **&check;** | **<sub><form action="#create-layout"><button>PUT</button></form></sub>**
json                  | 文字列               | Json encoded string. The same content as the 'configuration' field. **Deprecated**
permissions           | 文字列               | String of zero or more characters. Each character defines a permission that the current user has for the layout  <br><br>Permissions include: <br>`'R'` - user can view this layout <br>`'W'` - user can modify this layout <br>`'D'` - user can delete this layout <br>`'S'` - user can share this layout             | **&cross;** |
current_recording_key | 文字列               | String key representing a recording currently being made with the cameras in the layout, which was initiated using the action/recordnow service                                                                                                                            | **&cross;** |
shares                | 配列[配列[文字列]] | Array of arrays, one per user account for whom sharing is enabled for this layout. Each string contains two field separated by comma. The first field is a user id and the second field are permissions for the user. `'account'` specifies that the layout is shared with all users of the account. Second field contains permissions for users in the account <br><br>Example: <br>[`'1005f2ed'`,`'RWDS'`] = user can view, change, delete or share this layout <br>[`'1005f2ed'`,`'RW'`] = user can view this layout and change this layout <br>[`'1005f2ed'`, `'R'`] = All users of the account can view this layout <br><br>Permissions for the user issuing the /layout GET are not included in this array                                                                                                                                               | **&check;** |


### レイアウト - 構成

パラメータ   | データ型式  | 詳細       
--------- | --------- | -----------
panes | 配列[json]      | Array of Json objects. Each object represents a [pane structure](#layout-configuration-panes)
[settings](#layout-configuration-settings) | json       | Json object of layout settings

### レイアウト - 構成 - ペイン

パラメータ   | データ型式      | 詳細       
--------- | ---------     | -----------
name      | 文字列        | Layout pane name
type      | 文字列        | Layout types: <br>`'preview'` - shows live preview images form cameras <br>`'carousel'` - rotates between preview images, IDs of cameras need to be included in the cameras array along with an integer in the delay array. The delay is an integer value of milliseconds as too how long the Camera will be displayed before switching to the next Camera. A `'carousel'` with only one camera is the same as preview <br>`'click'` - respond to click for other cameras in layout <br>`'motion'` - respond to motion for other cameras in layout <br>`'map'` - a static map with camera icons located on it <br>`'url'` - displays the contents of the url in the pane as a frame
pane_id   | 整数           | ID given to pane when created from the Layout Manager
size      | 整数           | Size of displayed image: <br>`1` - small <br>`2` - medium <br>`3` - large
cameras   | 配列[文字列] | Array of camera IDs (For `'carousel'`, cycle through the camera IDs with the delay setting in the corresponding `'delay'` property)

### レイアウト - 構成 - 設定

パラメータ             | データ型式  | 詳細       
---------           | --------- | -----------
camera_border       | ブール   | Show camera pane borders
camera_name         | ブール   | Show camera name
camera_aspect_ratio | 浮動小数点     | Aspect ratio of images: <br>`0.5625` - 16x9 <br>`0.75` - 4x3
camera_row_limit    | 整数       | Max number of cameras to show per row: <br>`3` - 3 cameras per row <br>`4` - 4 cameras per row  <br>`5` - 5 cameras per row
custom_id           | 文字列    |

<!--===================================================================-->
## レイアウトの取得
<!--===================================================================-->

IDによってレイアウト オブジェクトを返します

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/layout -d "A=[AUTH_KEY]&id=[LAYOUT_ID]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/layout`

パラメータ   | データ型式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**id**    | 文字列      | レイアウト ID   | true

### エラー状態コード

HTTP 状態コード | 詳細
---------------- | -----------
400	| 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限がないため拒否されました
404	| レイアウト ID が見つかりませんでした
200	| 要求は成功しました

<!--===================================================================-->
## レイアウトの作成
<!--===================================================================-->

新規レイアウトを作成します

> 要求

```shell
curl -X PUT https://login.eagleeyenetworks.com/g/layout -d '{"name": "[NAME]", "json":"{\"panes\":[ {} ] }", "types":[""]}' -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`PUT https://login.eagleeyenetworks.com/g/layout`

パラメータ          | データ型式       | 詳細         | 必須？
---------         | ---------     | ----------- | -----------
**name**          | 文字列         | レイアウト名   | true
**types**         | 配列[文字列] | レイアウトのターゲットの指定。複数の値が許可されます | true
**[configuration](#layout-configuration)** | json          | レイアウト設定を定義するJSONオブジェクト | true
shares            | 配列[配列]  | ネストされた配列で、このレイアウトで共有が有効になっているアカウントユーザーあたり1つの配列で表されます。各文字列には、カンマで区切られた2つのフィールドが含まれています。最初のフィールドはユーザーIDで、2番目のフィールドはユーザーのアクセス許可のリストです。2つの特別なユーザーIDが存在します： `'account’` は、レイアウトがアカウントのすべてのユーザーと共有されることを指定します。2番目のフィールドには、アカウント内のユーザーのアクセス許可が含まれています。例：<br>[`'1005f2ed'`, `'RWDS’`] = ユーザーは、このレイアウトを表示、変更、削除、または共有できます。<br>[`'1005f2ed’`, `'RW’`] = ユーザーはこのレイアウトを表示および変更できます。<br>[`'1005f2ed'`、 `'R’`] = アカウント内のすべてのユーザーがレイアウトを表示できます。<br><br>GET /layout を発行したユーザーの権限は、この配列には含まれていません。

> JSON 応答

```json
{
    "id": "80ca9ee0-4f28-11e4-81bf-523445989f37"
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ型式  | 詳細
--------- | --------- | -----------
id        | 文字列     | レイアウトの一意な識別子

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限がないため拒否されました
200	| 要求は成功しました

<!--===================================================================-->
## レイアウトの更新
<!--===================================================================-->

レイアウト構成を更新します

> Request TODO

```shell
```

### HTTP 要求

`POST https://login/eagleeyenetworks.com/g/layout`

パラメータ       | データ型式      | 詳細         | 必須？
---------     | ---------     | ----------- | -----------
**id**        | 文字列         |  レイアウトの一意の識別子 | true
name          | 文字列         | レイアウトの名前
types         | 配列[文字列]    | レイアウトのターゲットの指定。複数の値が許可されます
[configuration](#layout-configuration) | json          | レイアウト設定を定義するJSONオブジェクト
shares        | 配列[配列]     | ネストされた配列で、このレイアウトで共有が有効になっているアカウントユーザーあたり1つの配列で表されます。各文字列には、カンマで区切られた2つのフィールドが含まれています。最初のフィールドはユーザーIDで、2番目のフィールドはユーザーのアクセス許可のリストです。2つの特別なユーザーIDが存在します： `'account’` は、レイアウトがアカウントのすべてのユーザーと共有されることを指定します。2番目のフィールドには、アカウント内のユーザーのアクセス許可が含まれています。例：<br>[`'1005f2ed'`, `'RWDS’`] = ユーザーは、このレイアウトを表示、変更、削除、または共有できます。<br>[`'1005f2ed’`, `'RW’`] = ユーザーはこのレイアウトを表示および変更できます。<br>[`'1005f2ed'`、 `'R’`] = アカウント内のすべてのユーザーがレイアウトを表示できます。<br><br>GET /layout を発行したユーザーの権限は、この配列には含まれていません。

> JSON 応答

```json
{
    "id": "80ca9ee0-4f28-11e4-81bf-523445989f37"
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ型式  | 詳細
--------- | --------- | -----------
id        | 文字列    | レイアウトの一意の識別子

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限がないため拒否されました
404	| レイアウト ID が見つかりませんでした
200	| 要求は成功しました

<!--===================================================================-->
## レイアウトの削除
<!--===================================================================-->

レイアウトを削除します

> 要求

```shell
curl -X DELETE https://login.eagleeyenetworks.com/g/layout -d "id=[LAYOUT_ID]" -G -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP要求

`DELETE https://login.eagleeyenetworks.com/g/layout`

パラメータ   | データ型式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**id**    | 文字列    | レイアウト ID   | true

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限がないため拒否されました
404	| IDに合致するレイアウトが見つかりません
200	| 要求は成功しました

<!--===================================================================-->
## レイアウト リストの取得
<!--===================================================================-->

ユーザーが使用できるレイアウトを表す各サブ配列を持つ配列の配列を返します

> 要求

```shell
curl --request GET https://login.eagleeyenetworks.com/g/layout/list --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/layout/list`

> JSON 応答

```json
[
    [
        "0b58ec7a-61e4-11e3-8f7d-523445989f37",
        "Everything",
        [
            "mobile"
        ],
        "SWRD"
    ],
    [
        "75c03026-719a-11e3-afba-ca8312ea370c",
        "Glenn",
        [
            "mobile"
        ],
        "SWRD"
    ],
    [...],
    [...],
    [...]
]
```

### HTTP 応答 (属性の配列)

配列インデックス| 属性         | データ形式      | 詳細
----------- | ---------   | ---------     | -----------
0           | id          | 文字列	        | レイアウトの一意の識別子
1           | name        | 文字列	        | レイアウトの名前
2           | types       | 配列[文字列	] | レイアウトのターゲットの指定。複数の値が許可されます
3           | permissions | 文字列	        | ゼロ個以上の文字列。 各文字は、現在のユーザーがレイアウトに対して持つ権限を定義します。 権限は次のとおりです： <br>`'R’` - ユーザーはこのレイアウトを表示できます。 <br>`'W’` - ユーザーはこのレイアウトを変更できます。 <br>`’D’` - ユーザーはこのレイアウトを削除できます。 <br>`’S’` - ユーザーはこのレイアウトを共有できます

<aside class="success">モデル定義にはプロパティキーがありますが、これは単なる標準配列なので参照用です</aside>

### エラー状態コード

HTTP 状態コード | 詳細
---------------- | -----------
400	| 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限がないため拒否されました
200	| 要求は成功しました
