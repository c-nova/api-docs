# ユーザー

<!--===================================================================-->

## 概要
もしユーザーが自分自身以外の情報を要求する場合は、これらのAPIはスーパーユーザーまたはアカウント スーパーユーザー (もしアカウントが適合する場合) 権限を必要とします。もしユーザーIDを指定しなかった場合、APIは認証されコールしたユーザーのデータを取得しようと試みます。

<!--===================================================================-->

## ユーザー モデル

> ユーザー モデル

```json
{
    "id": "ca0e1cf2",
    "first_name": null,
    "last_name": "",
    "email": "john.doe@fakeemail.com",
    "owner_account_id": "00004206",
    "active_account_id": "00004206",
    "uid": " ",
    "is_superuser": 0,
    "is_account_superuser": 1,
    "is_staff": 0,
    "is_active": 1,
    "is_pending": 0,
    "is_master": 0,
    "is_user_admin": 1,
    "is_layout_admin": 1,
    "is_live_video": 1,
    "is_device_admin": 1,
    "is_export_video": 1,
    "is_recorded_video": 1,
    "street": [],
    "city": null,
    "state": null,
    "country": "US",
    "postal_code": null,
    "phone": null,
    "mobile_phone": null,
    "utc_offset": -25200,
    "timezone": "US/Pacific",
    "last_login": "20141006173752.672",
    "alternate_email": null,
    "sms_phone": null,
    "is_sms_include_picture": 0,
    "json": "{}",
    "camera_access": [
        [
            "1005f2ed",
            "r"
        ],
        [
            "100bd708",
            "r"
        ]
    ],
    "layouts": [
        "217f0fd4-450f-11e4-a983-ca8312ea370c"
    ],
    "is_notify_enable": 1,
    "notify_period": [
        "0-0000-2359",
        "1-0000-2359",
        "2-0000-2359",
        "3-0000-2359",
        "4-0000-2359",
        "5-0000-2359",
        "6-0000-2359"
    ],
    "notify_rule": [
        "one-email-0"
    ],
    "is_branded": 1,
    "active_brand_subdomain": "login",
    "account_map_lines": null,
    "access_period": [],
    "is_terms_noncompliant": 1
}
```

### ユーザー属性

パラメータ               | データ形式     | 説明
---------               | -----------   | -----------
id                      | 文字列        | 認可されたユーザーの一意な識別子
first_name              | 文字列        | 認可されたユーザーの名
last_name               | 文字列        | 認可されたユーザーの姓
email                   | 文字列        | 認可されたユーザーのEメール (* このEメールはASCII文字のみ必要)
owner_account_id        | 文字列        | ユーザーアカウントの一意な識別子
active_account_id       | 文字列        | アクティブなユーザーアカウントの一意な識別子
uid                     | 文字列        | UID
is_superuser            | 整数           | ユーザーはスーパーユーザーか
is_account_superuser    | 整数           | ユーザーはアカウント スーパーユーザーか
is_staff                | 整数           | ユーザーはスタッフ ユーザーか
is_active               | 整数           | ユーザーはアクティブか
is_pending              | 整数           | ユーザーは保留されたユーザーか
is_master               | 整数           | マスターアカウントのユーザーか
is_user_admin           | 整数           | ユーザーユーザーユーザー管理者か
is_layout_admin         | 整数           | ユーザーはレイアウト管理者か
is_live_video           | 整数           | ユーザーはライブ動画へのアクセス認可があるか
is_device_admin         | 整数           | ユーザーはデバイス管理者か
is_export_video         | 整数           | ユーザーは動画のエクスポート認可があるか
is_recorded_video       | 整数           | ユーザーは録画された動画の閲覧認可があるか
street                  | 配列[文字列] | 配列化された住所 [住所 1, 住所 2, ...])
city                    | 文字列        | 都市、市区町村
state                   | 文字列        | 州、都道府県
country                 | 文字列        | 国
postal_code             | 文字列        | 郵便番号
phone                   | 文字列        | 電話番号
mobile_phone            | 文字列        | 携帯電話番号
utc_offset              | 整数           | UTCと設定タイムゾーンとの差分秒 (符号付き整数)
timezone                | 文字列        | タイムゾーン
last_login              | 文字列        | ユーザーのEENタイムスタンプ形式 (YYYYMMDDHHMMSS.NNN) での最終ログイン時間 
alternate_email         | 文字列        | その他のEメールアドレス
sms_phone               | 文字列        | SMS 電話番号
is_sms_include_picture  | 整数           | SMS通知に写真を含めるか
json                    | [UserJson](#userjson-attributes) | ユーザーのその他設定のJSON文字列
camera_access           | 配列[文字列] | ユーザーがアクセス可能なデバイス (ID) の一覧
layouts                 | 配列[文字列] | ユーザーがアクセス可能なレイアウト (ID) の一覧
is_notify_enable        | 整数           | ユーザーへの通知が有効か
notify_period           | 配列[文字列] | D-HHMM-HHMM 形式の通知可能期間のリスト
notify_rule             | 配列[文字列] | id-type-delay 形式の通知ルールのリスト (例 one-email-0)
is_branded              | 整数           | 現在ユーザーが紐付いているアカウントがブランド化されているか
active_brand_subdomain  | 文字列        | ユーザーにホモづいているアカウントのブランド化が有効な場合のブランドサブドメイン(1つ以上ある場合)
account_map_lines       | ???           | 
access_period           | ???           | 
is_terms_noncompliant   | 整数           | 利用規約に承諾しなかった場合は真

### UserJson属性

パラメータ   | データ形式     | 説明
---------   | -----------   | -----------
een         | [UserJsonEen](#userjsoneen-attributes)   | EEN オブジェクト

### UserJsonEen 属性

パラメータ               | データ形式     | 説明
---------               | -----------   | -----------
show_AMPM               | ブーリアン       | AM/PMを使用した時刻表示
milliseconds_display    | ブーリアン       | ミリ秒の表示
layout_rotation_seconds | 整数           | 設定されている場合、自動ローテーションにおけるレイアウト変更の表示時間を示します。未設定または 0 の場合、自動ローテーションは発生しません。
motion_boxes            | ブーリアン       | モーションボックスを表示するか決定します
notify_levels           | 配列[整数]    | 


<!--===================================================================-->

## ユーザー情報の取得

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/user -d "A=[AUTH_KEY]"

または

curl --cookie "auth_key=[AUTH_KEY]" -G https://login.eagleeyenetworks.com/g/user -d id=[USER_ID]
```

IDが与えられるとユーザー オブジェクトを返します。IDが与えられない場合、現在認可されているユーザーの情報が返されます。

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/user`

パラメータ | データ形式   | 説明 | 必須
--------- | ----------- | ----------- | -----------
id        | 文字列      | ユーザーID     | false

<!--===================================================================-->

## ユーザーの作成

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X PUT -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/user -d '{"first_name": "[FIRST_NAME]", "last_name": "[LAST_NAME]", "email": "[EMAIL]"}'
```

> Json応答

```json
{
    "id": "ca0ffa8c"
}
```

新規ユーザーを作成します。

### HTTP要求

`PUT https://login.eagleeyenetworks.com/g/user`

パラメータ        | データ形式   | 説明   
---------         | ----------- | -----------   
**first_name**    | 文字列      | 名    
**last_name**     | 文字列      | 姓     
**email**         | 文字列      | Eメールアドレス

<!--
パラメータ        | データ形式   | 説明   | 必須
---------         | ----------- | -----------   | -----------
**first_name**    | 文字列      | 名    | true
**last_name**     | 文字列      | 姓     | true
**email**         | 文字列      | Email Address | true
phone             | 文字列      | Phone Number |
mobile_phone      | 文字列      | Mobile Phone Number |
uid               | 文字列      | An identifier of the user. Only Super Users can set this. |
owner_account_id  | 文字列      | ID of owner account. Defaults to account of the user creating it. Must be an account the user has access to. For SuperUsers, it can be any account, for Account SuperUsers, it can be theirs or a child account. |
street        | 文字列  | Street Address |
city          | 文字列  | City |
state         | 文字列  | State |
country       | 文字列  | Country |
postal_code   | 文字列  | Postal Code |
json          | 文字列  | JSON formatted data representing various user settings. |
is_staff              | 整数     | 1 or 0 indicating the user has Staff permission. Only Super Users can set this. | 
is_superuser          | 整数     | 1 or 0 indicating the user has Super User permission. Only Super Users can set this. |
is_account_superuser  | 整数     | 1 or 0 indicating the user as Account Super User permission. Only Super Users and Account Super Users can set this. |
is_layout_admin       | 整数     | 1 or 0 indicating whether the user is a layout admin or not. |
is_device_admin       | 整数     | 1 or 0 indicating whether the user is a device admin or not. |
camera_access         | 配列   | 配列 of 配列s, one per device for which the uer has permissions. Each sub 配列 contains two elements. The first field is a device id, and the second field is a 文字列 of 1 or more chacterse indicating permissions for the user, for example: [‘cafedead’,’RWS’] = user can view, change, delete this device. [‘cafe0001’,’RW’] = user can view this layout and change this device. Permissions include: 'R' - user has access to view images and video for this camera. 'A' - user is an admin for this camera. 'S' - user can share this camera in a group share. Only superusers or account_superusers can edit this field. |
sms_phone             | 文字列  | Phone number to be used for SMS messaging. |
is_sms_include_picture| 整数     | 1 or 0. If 1, use MMS messaging to include a picture w with alert messages sent to the sms_phone number. |
alternate_email       | 文字列  | Email address to be used for alert notifications. |
timezone              | 文字列  | User timezone. Defaults to US/Pacific. |
access_period         | 配列   | Contains the time periods during which the user has access to the account. Each element of the 配列 contains three field separated by dashes. The first field is the day of the week where Monday is 0. The second element is the start time. The third element is the end time. If empty, user has no time restrictions for access to the account. All times are expressed in local time and use a 24 hour clock formatted as HHMM. |
notify_period         | 配列   | Contains the time periods during which the user will receive alert notifications.. Each element of the 配列 contains three field separated by dashes. The first field is the day of the week where Monday is 0. The second element is the start time. The third element is the end time. If empty, user will not receive any alert notifications. All times are expressed in local time and use a 24 hour clock formatted as HHMM. |
is_notify_enable      | 整数     | 1 or 0. If 1, user will receive alert notifications as specified in notify_period. |
notify_rule           | 配列   | Contains alert notification rules Each rule contains three fields separated by dashes And takes the form: Alert_Label-Notification_Method-Delay. Alert_Label: a name defined by the user. Notification_Method: Valid values: email, sms, gui. Delay: the amount of time, in minutes between between notifications. |
-->



### 応答するJson属性

パラメータ      | データ形式   | 説明
---------       | ----------- | -----------
id              | 文字列      | ユーザーの一意の識別子

<!--===================================================================-->
## ユーザー情報の更新

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X POST -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/user -d '{"id": "[USER_ID]", "first_name": "[FIRST_NAME]"}'
```

> Json応答

```json
{
    "id": "ca0ffa8c"
}
```

ユーザー情報を更新します。

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/user`

パラメータ              | データ形式     | 説明   | 必須
---------               | -----------   | -----------   | -----------
**id**                  | 文字列        | ユーザーID       | true
first_name              | 文字列        | 名
last_name               | 文字列        | 姓
email                   | 文字列        | Eメール アドレス
phone                   | 文字列        | 電話番号
mobile_phone            | 文字列        | 携帯電話番号
uid                     | 文字列        | ユーザーの識別子。スーパーユーザーのみが設定できます。
owner_account_id        | 文字列        | IDまたは所有者アカウント。既定ではユーザーを作成したアカウントになります。これはユーザーがアクセスするアカウントである必要があります。スーパーユーザーの場合はどのアカウントでも可能で、アカウント スーパーユーザーの場合は自身のアカウントでも子アカウントでも可能です。
street                  | 文字列        | 住所
city                    | 文字列        | 都市または市区町村
state                   | 文字列        | 州または都道府県
country                 | 文字列        | 国
postal_code             | 文字列        | 郵便番号
json                    | [UserJson](#userjson-attributes) | 様々なユーザー設定のJSON形式データ
is_staff                | 整数           | ユーザーがスタッフ権限を持つか1または0で示します。スーパー ユーザーのみがこれを設定できます。
is_superuser            | 整数           | 1 or 0 indicating the user has Super User permission. Only Super Users can set this.
is_account_superuser    | 整数           | 1 or 0 indicating the user as Account Super User permission. Only Super Users and Account Super Users can set this.
is_layout_admin         | 整数           | 1 or 0 indicating whether the user is a layout admin or not.
is_device_admin         | 整数           | 1 or 0 indicating whether the user is a device admin or not.
camera_access           | 配列         | Array of arrays, one per device for which the uer has permissions. Each sub array contains two elements. The first field is a device id, and the second field is a string of 1 or more chacterse indicating permissions for the user, for example: [‘cafedead’,’RWS’] = user can view, change, delete this device. [‘cafe0001’,’RW’] = user can view this layout and change this device. Permissions include: 'R' - user has access to view images and video for this camera. 'A' - user is an admin for this camera. 'S' - user can share this camera in a group share. Only superusers or account_superusers can edit this field.
sms_phone               | 文字列        | Phone number to be used for SMS messaging.
is_sms_include_picture  | 整数           | 1 or 0. If 1, use MMS messaging to include a picture w with alert messages sent to the sms_phone number.
alternate_email         | 文字列        | Email address to be used for alert notifications.
timezone                | 文字列        | User timezone. Defaults to US/Pacific.
access_period           | 配列         | Contains the time periods during which the user has access to the account. Each element of the 配列 contains three field separated by dashes. The first field is the day of the week where Monday is 0. The second element is the start time. The third element is the end time. If empty, user has no time restrictions for access to the account. All times are expressed in local time and use a 24 hour clock formatted as HHMM.
notify_period           | 配列         | Contains the time periods during which the user will receive alert notifications.. Each element of the 配列 contains three field separated by dashes. The first field is the day of the week where Monday is 0. The second element is the start time. The third element is the end time. If empty, user will not receive any alert notifications. All times are expressed in local time and use a 24 hour clock formatted as HHMM.
is_notify_enable        | 整数           | 1 or 0. If 1, user will receive alert notifications as specified in notify_period.
notify_rule             | 配列         | Contains alert notification rules Each rule contains three fields separated by dashes And takes the form: Alert_Label-Notification_Method-Delay. Alert_Label: a name defined by the user. Notification_Method: Valid values: email, sms, gui. Delay: the amount of time, in minutes between between notifications.

### 応答Json属性

パラメータ      | データ形式   | 説明
---------       | ----------- | -----------
id              | 文字列      | ユーザーの一意な識別子

<!--===================================================================-->
## ユーザーの削除

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X DELETE -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/user -d "id=[USER_ID]" -G
```

ユーザーを削除します。

### HTTP要求

`DELETE https://login.eagleeyenetworks.com/g/user`

パラメータ    | データ形式   | 説明
---------     | ----------- | -----------
**id**        | 文字列      | ユーザーID

<!--===================================================================-->
## ユーザー リストの取得

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request GET https://login.eagleeyenetworks.com/g/user/list
```

> Json応答

```json
[
    [
        "ca0555c7",
        "Katherine",
        "Xiao",
        "katherine.xiao@fakeemail.com",
        [
            "export_video",
            "recorded_video",
            "live_video",
            "device_admin",
            "layout_admin",
            "account_superuser",
            "user_admin",
            "active"
        ],
        "20140929154619.000"
    ],
    [
        "ca00783b",
        "George",
        "Adams",
        "george.adams@fakeemail.com",
        [
            "export_video",
            "recorded_video",
            "live_video",
            "active"
        ],
        "20140716205645.000"
    ],
    [...],
    [...],
    [...]
]
```

配列の中の配列がある場合、それぞれの子配列は現在のユーザーが取得可能なユーザーを返します。下記のListUserモデル定義がプロパティ キーを持っていることに注意してください。しかし、これは実際には参照用の単純な標準配列です。

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/user/list`

### ユーザー配列属性

配列インデックス     | 属性   | データ形式       | 説明
---------       | ----------- | -----------     | -----------
0               | id          | 文字列          | ユーザーの一意な識別子
1               | first_name  | 文字列          | ユーザーの名
2               | last_name   | 文字列          | ユーザーの姓
3               | email       | 文字列          | ユーザーのEメール アドレス
4               | permissions | 配列[文字列]   | ユーザーの権限リスト
5               | last_login  | 文字列          | ユーザーのEENタイムスタンプ形式 (YYYYMMDDHHMMSS.NNN) での最終ログイン時間
