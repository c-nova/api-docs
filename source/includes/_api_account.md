# アカウント

<!--===================================================================-->
## 概要
<!--===================================================================-->

アカウントサービスはスーパーユーザー及びアカウントスーパーユーザーによって管理します

<!--===================================================================-->
## アカウント モデル
<!--===================================================================-->

> アカウント モデル

```json
{
    "is_master_video_disabled_allowed": 1,
    "is_inactive": 0,
    "is_suspended": 0,
    "brand_name": null,
    "alert_mode": [
        "default",
        "Weekend"
    ],
    "is_master_video_disabled": 0,
    "contact_state": null,
    "first_responders": [
        [
            "mark@responders.com",
            "Mark",
            "O'Malley",
            "Responders",
            "Fake Account"
        ],
        [
            "jeff@noaccount.com",
            "Jeff",
            "O'Unverified",
            "Unverified Organization",
            "No Account"
        ],
        ...
    ],
    "contact_first_name": "Willem",
    "is_disable_all_settings": 0,
    "timezone": "US/Pacific",
    "id": "11111111",
    "contact_country": "US",
    "is_system_notifications_disabled": 0,
    "camera_shares": [
        [
            "12345678",
            "joe@em.com,His account",
            "joe2@dd.com,That account"
            ...
        ],
        ...
    ],
    "owner_account_id": "1010101b",
    "product_edition": null,
    "cc_info": [
        {
            "city": "",
            "name": "",
            "default": "",
            "street1": "",
            "street2": "",
            "number": "",
            "state": "",
            "tag": "",
            "postal_code": "",
            "expire": "",
            "country": "US",
            "type": ""
        }
    ],
    "brand_saml_publickey_cert": null,
    "brand_support_email": null,
    "is_billing_disabled": 0,
    "is_advanced_disabled": 0,
    "inactive_session_timeout": 720,
    "brand_logo_large": null,
    "brand_corp_url": null,
    "responder_active": true,
    "contact_street": [],
    "is_system_notification_images_enabled": 1,
    "is_custom_brand_allowed": 0,
    "holiday": [
        "20180101",
        "20180527",
        "20180704",
        "20180902",
        "20181128",
        "20181225"
    ],
    "is_rtsp_cameras_enabled": 0,
    "brand_saml_nameid_path": null,
    "is_contract_recording": 0,
    "utc_offset": -28800,
    "session_duration": 480,
    "is_custom_brand": 0,
    "contact_postal_code": null,
    "brand_logo_small": null,
    "is_active": 1,
    "work_days": "1111111",
    "is_add_delete_disabled": 0,
    "is_master": 0,
    "contact_email": "support@eagleeyenetworks.com",
    "responder_cameras": [
        "1010fake",
        "not1c4mr"
    ],
    "brand_support_phone": null,
    "map_lines": null,
    "contact_mobile_phone": null,
    "work_hours": [
        "0800",
        "1730"
    ],
    "login_attempt_limit": null,
    "default_cluster": "c000",
    "customer_id": "1234",
    "name": "Account Name",
    "contact_city": null,
    "default_camera_passwords": "pwordpword",
    "contact_phone": null,
    "access_restriction": [
        "enable_mobile"
    ],
    "active_alert_mode": "default",
    "allowable_ip_address_range": [],
    "contact_last_name": "Dafoe",
    "contact_utc_offset": null,
    "camera_quantity": null,
    "brand_subdomain": "c000"
}
```

### アカウント (属性)

パラメータ                               | データ形式             | 詳細                                                                                  | 編集可        | 必須
---------                             | ---------            | -----------                                                                          |:-----------:| --------
**id**                                | 文字列               | Unique identifier of the account                                                     | **&cross;** | **<sub><form action="#get-account"><button>GET</button></form></sub>** <br>**<sub><form action="#update-account"><button>POST</button></form></sub>** <br>**<sub><form action="#delete-account"><button>DELETE</button></form></sub>**
**name**                              | 文字列               | Name of the account                                                                  | **&check;** | **<sub><form action="#create-account"><button>PUT</button></form></sub>**
**contact_first_name**                | 文字列               | First name of primary contact for account                                            | **&check;** | **<sub><form action="#create-account"><button>PUT</button></form></sub>**
**contact_last_name**                 | 文字列               | Last name of primary contact for account                                             | **&check;** | **<sub><form action="#create-account"><button>PUT</button></form></sub>**
contact_email                         | 文字列               | Email of primary contact for account                                                 | **&check;** |
contact_street                        | 配列[文字列]        | Array of strings containing street addresses of the primary contact for account [`'address line 1'`, `'address line 2'`]                                                                                                                                 | **&check;** |
contact_city                          | 文字列               | City of primary contact for account                                                  | **&check;** |
contact_state                         | 文字列               | State/province of primary contact for account                                        | **&check;** |
contact_postal_code                   | 文字列               | Zip/postal code of primary contact for account                                       | **&check;** |
contact_country                       | 文字列               | Country code of primary contact for account                                          | **&check;** |
contact_phone                         | 文字列               | Phone number of primary contact for account                                          | **&check;** |
contact_mobile_phone                  | 文字列               | Mobile phone number of primary contact for account                                   | **&check;** |
owner_account_id                      | 文字列               | ID of the parent account. Defaults to the account of the creating user               | **&cross;** |
timezone                              | 文字列               | Timezone of the account. Defaults to `'US/Pacific'` <br><br>Possible values: <br>`'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'`, `'UTC'`, ...                                                  | **&check;** |
status                                | 配列[文字列]        | Account status. This can only be edited by superusers and account superusers from the parent/owner account <br><br>Possible values: <br>`'active'` - normal working state <br>`'inactive'` - logins are not allowed <br>`'suspended'` - effectively no longer operational <br>`'pending_validation'` - default state after account creation (before the user has validated the account)                                       | **&check;** |
utc_offset                            | 整数                  | Signed integer offset in seconds of the timezone from UTC. Automatically generated based on the timezone field                                                                                                                                               | **&cross;** |
access_restriction                    | 配列[文字列]        | Array of strings containing access restrictions. Possible values: `'enable_mobile'` = If present this account has access to mobile clients. `'enable_ip_restrictions'` = if present and if `'allowable_ip_address_range'` has been specified, limits logins to the address ranges specified                                                                                                                                           | **&cross;** |
allowable_ip_address_range            | 配列[文字列]        | Each entry in the array specifies one address range. Entries use the `'/'` format. For example, to limit access to `'192.168.123.0-192.168.123.255'`, the entry would be `'192.168.123.0/24'`. If no entries are present, `'0.0.0.0/0'` is implied           | **&cross;** |
session_duration                      | 整数                  | Session duration in minutes. Session duration of 0 means *stay logged in forever*    | **&check;** |
holiday                               | 配列[文字列]        | Array of strings containing dates during which holidays are observed. Format for dates is YYYYMMDD                                                                                                                                            | **&check;** |
work_days                             | 文字列               | String of length 7. Each position in the string corresponds to a day of the week. Monday is position 0, Tuesday is position 1, etc. Each character in the string can have a value of 1 or 0. 1 means that this day is a work day                            | **&check;** |
work_hours                            | 配列[文字列]        | Two entries. Each entry containing a time expressed in local time. The first entry in the array is the work day start time. The second entry in the array is the stop time. Times are represented using a 24 hour clock and are formatted as HHMM <br><br>Example: 8AM would be 0800 and 5PM would be 1700                                                                                                                               | **&check;** |
alert_mode                            | 配列[文字列]        | Array of strings containing possible alert modes as defined for this account. Accepts an array of any number of strings of varying length. This controls what values are able to be chosen for the `'active_alert_mode'` field                                   | **&check;** |
active_alert_mode                     | 文字列               | A string chosen from values in the account `'alert_mode'` array. Must be blank or one of the values defined in the alert_mode array. This is used to determine when to send motion alert notifications (defined by camera settings in the device model). If a motion alert is defined with an alert mode from one of the strings in the account 'alert_mode' array, then the notifications triggered from that motion alert will only be sent when the account `'active_alert_mode'` is also set to that same alert mode string defined for that motion alert                                                      | **&check;** |
default_camera_passwords              | 文字列               | Comma-delimited string of default camera passwords                                   | **&check;** |
camera_shares                         | 配列[配列[文字列]] | Array of arrays with each sub-array representing a camera to be shared to 1 or more recipients. First element is camera ID. Second element is a string containing 1 or multiple recipients. All recipients are a single string value of `'email,account,email,account,...'` <br><br>Example: [[`'12345678'`, `'joe@em.com,His account,joe2@dd.com,That account'`]]                                                              | **&check;** |
is_revoke_admins                      | 整数                  | Indicates whether to revoke all admin permissions for the users in the account (1) or not (0). This field doesn't save anything on the account itself. It will revoke admin privileges of any admins in the account                                           | **&check;** |
is_master                             | 整数                  | Indicates whether the account is a master account (1) or not (0)                     | **&cross;** |
is_active                             | 整数                  | Indicates whether the account is active (1) or not (0)                               | **&cross;** |
is_inactive                           | 整数                  | Indicates whether the account is inactive (1) or not (0)                             | **&check;** |
is_suspended                          | 整数                  | Indicates whether the account is suspended (1) or not (0)                            | **&check;** |
product_edition                       | 文字列               | Product edition the account is using                                                 | **&cross;** |
camera_quantity                       | 整数                  | Total number of cameras the account is allowed to use                                | **&cross;** |
is_custom_brand_allowed               | 整数                  | Indicates whether the account is allowed to have branding (1) or not (0)             | **&check;** |
is_custom_brand                       | 整数                  | Indicates whether the account has branding enabled (1) or not (0)                    | **&check;** |
brand_logo_small                      | 文字列               | Base64 encoded image for the branded small logo (PNG, 160x52, transparent background)| **&check;** |
brand_logo_large                      | 文字列               | Base64 encoded image for the branded large logo (PNG, 460x184, white background)     | **&check;** |
brand_subdomain                       | 文字列               | Sub domain for the branded url                                                       | **&check;** |
brand_corp_url                        | 文字列               | Corporate website url                                                                | **&check;** |
brand_name                            | 文字列               | Branded company name                                                                 | **&check;** |
brand_saml_publickey_cert             | 文字列               | Public certificate which Eagle Eye Networks will use to decrypt the SAML for SSO     | **&check;** |
brand_saml_nameid_path                | 文字列               | The path within the SAML xml to find the users email address                         | **&check;** |
is_without_initial_user               | 文字列               | Indicates whether to create the new account without an initial user (1) or not (0). Defaults to 0, meaning an initial user with `'is_account_superuser=1'` will be created using the arguments `'contact_first_name/contact_last_name/contact_email'` specified upon account creation                                                                                                                                            | **&check;** |
customer_id                           | 文字列               | Arbitrary ID assigned to a sub-account by a master account                           | **&check;** |
is_master_video_disabled_allowed      | 整数                  | Indicates whether a sub-account can block video access to reseller (1) or not (0)    | **&check;** |
is_master_video_disabled              | 整数                  | Indicates whether video access is blocked to reseller (1) or not (0)                 | **&check;** |
is_contract_recording                 | 整数                  | Indicates whether the account is of type contract_recording. Controls whether contract recording features are enabled for the users in this account on the front-end GUI (1) or not (0)                                                                       | **&check;** |
is_advanced_disabled                  | 整数                  | Indicates whether the reseller has disabled advanced functionality (1) or not (0) If this is set for a sub-account, the users in the sub-account cannot change any settings related to bandwidth, billing (retention and resolution) and certain account settings. Master users switched in still can modify these things if their permissions allow it                                                                             | **&check;** |
is_billing_disabled                   | 整数                  | Indicates whether the reseller has disabled editing settings in a sub-account that affect billing (1) or not (0). This controls whether users can change camera resolution/retention, add/delete cameras, etc                                                    | **&check;** |
is_add_delete_disabled                | 整数                  | Indicates whether the reseller has disabled adding or deleting devices (1) or not (0)| **&check;** |
is_disable_all_settings               | 整数                  | Indicates whether the reseller has disabled all device and most account settings (1) or not (0). Does not affect editing users, layouts, or sharing                                                                                                           | **&check;** |
first_responders                      | 配列[配列[文字列]] | Array of arrays with each sub-array representing an emergency responder. Accounts can identify a list of email accounts that will serve as emergency responders. Emergency responders get access to the identified `'responder_cameras'` during an emergency (triggered by setting `'responder_active'`). A responder is identified by their email, first name, last name, company and their account <br><br>Example: [[`'mark@responders.com'`, `'Mark'`, `'O'Malley'`, `'Responders'`, `'Fake Account'`]]                                                                                                    | **&check;** |
responder_active                      | <p hidden>???</p>    | Indicates whether the responder cameras can be seen by the users defined under `'first_responders'`                                                                                                                                | **&check;** |
responder_cameras                     | 配列[文字列]        | Array of camera ESNs that are shared to first responders                             | **&check;** |
inactive_session_timeout              | 整数                  | Maximum time period in seconds without activity before web session expires           | **&check;** |
login_attempt_limit                   | 整数                  | Maximum incorrect login attempts before the user account access becomes locked       | **&check;** |
is_rtsp_cameras_enabled               | 整数                  | Indicates whether the account can have cameras attached over RTSP (instead of ONVIF) (1) or not (0)                                                                                                                                                 | **&check;** |
brand_support_phone                   | 文字列               | Branded support phone number                                                         | **&check;** |
default_cluster                       | 文字列               | Indicates the data center cluster the account is assigned to                         | **&check;** |
is_system_notification_images_enabled | 整数                  | Indicates whether email notifications about online/offlice status should contain images from those cameras (1) or not (0)                                                                                                                                      | **&check;** |
map_lines                             | json                 | This is used by the front end to overlay lines over a map of the cameras for the account                                                                                                                                             | **&check;** |
contact_utc_offset                    | 整数                  | This field is no longer being used <small>**(DEPRECATED)**</small>                   | **&check;** |

<aside class="notice">カメラ関連のフラグは、カメラを格納するアカウント内でのみ有効なカメラに対してのみ変更または設定できます</aside>

<aside class="notice">状態スフラグは、マスタアカウントからのサブアカウントに対してのみ設定することができます</aside>

<!--===================================================================-->
## アカウントの取得
<!--===================================================================-->

アカウント オブジェクトをIDで返します

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/account -d "id=[ID]&A=[AUTH_KEY]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/account`

パラメータ 	| データ型式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**id**    | string    | アカウントの一意の識別子 | true

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限が見つからなかったため禁止されました
404	| 提供された ID によるアカウントが見つかりませんでした
200	| 要求は成功しました

<!--===================================================================-->
## アカウントの作成
<!--===================================================================-->

新規アカウントを作成します

> 要求

```shell
curl -X PUT https://login.eagleeyenetworks.com/g/account -d '{"name": "[NAME]", "contact_first_name": "[CONTACT_FIRST_NAME]", "contact_last_name": "[CONTACT_LAST_NAME]", "contact_email": "[CONTACT_EMAIL]"}' -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`PUT https://login.eagleeyenetworks.com/g/account`

パラメータ                               | データ型式    | 詳細                                                                                                    | 必須？
---------                             | ---------   | -----------                                                                                            | -----------
**name**                              | 文字列        | Name of the account                                                                                    | true
**contact_first_name**                | 文字列        | First name of primary contact for account                                                              | true
**contact_last_name**                 | 文字列        | Last name of primary contact for account                                                               | true
**contact_email**                     | 文字列        | Email of primary contact for account                                                                   | true
contact_street                        | 配列[文字列] | Array of strings containing street addresses of the primary contact for account [`'address line 1'`, `'address line 2'`]
contact_city                          | 文字列        | City of primary contact for account
contact_state                         | 文字列        | State/province of primary contact for account
contact_postal_code                   | 文字列        | Zip/postal code of primary contact for account
contact_country                       | 文字列        | Country code of primary contact for account
owner_account_id                      | 文字列        | ID of the parent account. Defaults to the account of the creating user
timezone                              | 文字列        | Timezone of the account. Defaults to `'US/Pacific'` <br><br>Possible values: <br>`'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'`, `'UTC'`, ...
status                                | 配列[文字列] | Account status. This can only be edited by superusers and account superusers from the parent/owner account <br><br>Possible values: <br>`'active'` - normal working state <br>`'inactive'` - logins are not allowed <br>`'suspended'` - effectively no longer operational <br>`'pending_validation'` - default state after account creation (before the user has validated the account)
access_restriction                    | 配列[文字列] | Array of strings containing access restrictions. Possible values: `'enable_mobile'` = If present this account has access to mobile clients. `'enable_ip_restrictions'` = if present and if `'allowable_ip_address_range'` has been specified, limits logins to the address ranges specified
allowable_ip_address_range            | 配列[文字列] | Each entry in the array specifies one address range. Entries use the `'/'` format. For example, to limit access to `'192.168.123.0-192.168.123.255'`, the entry would be `'192.168.123.0/24'`. If no entries are present, `'0.0.0.0/0'` is implied
session_duration                      | 整数           | Session duration in minutes. Session duration of 0 means *stay logged in forever*
holiday                               | 配列[文字列] | Array of strings containing dates during which holidays are observed. Format for dates is YYYYMMDD
work_days                             | 配列[文字列] | String of length 7. Each position in the string corresponds to a day of the week. Monday is position 0, Tuesday is position 1, etc. Each character in the string can have a value of 1 or 0. 1 means that this day is a work day
work_hours                            | 配列[文字列] | Two entries. Each entry containing a time expressed in local time. The first entry in the array is the work day start time. The second entry in the array is the stop time. Times are represented using a 24 hour clock and are formatted as HHMM <br><br>Example: 8AM would be 0800 and 5PM would be 1700
alert_mode                            | 配列[文字列] | Array of strings containing possible alert modes as defined for this account. Accepts an array of any number of strings of varying length. This controls what values are able to be chosen for the `'active_alert_mode field'`
active_alert_mode                     | 文字列        | A string chosen from values in the account `'alert_mode'` array. Must be blank or one of the values defined in the alert_mode array. This is used to determine when to send motion alert notifications (defined by camera settings in the device model). If a motion alert is defined with an alert mode from one of the strings in the account 'alert_mode' array, then the notifications triggered from that motion alert will only be sent when the account `'active_alert_mode'` is also set to that same alert mode string defined for that motion alert
default_camera_passwords              | 文字列        | Comma-delimited string of default camera passwords
is_without_initial_user               | 整数           | Indicates whether to create the new account without an initial user (1) or not (0). Defaults to 0, meaning an initial user with `'is_account_superuser=1'` will be created using the arguments `'contact_first_name/contact_last_name/contact_email'` specified upon account creation
is_initial_user_not_admin             | 整数           | Indicates whether the initial user is an admin (0) or not (1)

> JSON応答

```JSON
{
    "id": "1234abcd"
}
```

### HTTP 応答 (JSON属性)

パラメータ  | データ形式   | 詳細
--------- | --------- | -----------
id        | 文字列     | アカウントの一意の識別子

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
409	| 指定された連絡先メールアドレスを持つ別のアカウントが既に存在します

<!--===================================================================-->
## アカウントの更新
<!--===================================================================-->

アカウント情報を更新します

> 要求

```shell
curl -X POST https://login.eagleeyenetworks.com/g/account -d '{"id": "[ACCOUNT_ID]", "contact_first_name": "[CONTACT_FIRST_NAME]"}' -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/account`

パラメータ                              | データ形式              | 詳細                                                                                             | 必須？
---------                             | ---------            | -----------                                                                                     | -----------
**id**                                | 文字列               | Unique identifier of the account                                                                | true
name                                  | 文字列               | Name of the account
contact_first_name                    | 文字列               | First name of primary contact for account
contact_last_name                     | 文字列               | Last name of primary contact for account
contact_email                         | 文字列               | Email of primary contact for account
contact_street                        | 配列[文字列]        | Array of strings containing street addresses of the primary contact for account [`'address line 1'`, `'address line 2'`]
contact_city                          | 文字列               | City of primary contact for account
contact_state                         | 文字列               | State/province of primary contact for account
contact_postal_code                   | 文字列               | Zip/postal code of primary contact for account
contact_country                       | 文字列               | Country code of primary contact for account
contact_phone                         | 文字列               | Phone number of primary contact for account
contact_mobile_phone                  | 文字列               | Mobile phone number of primary contact for account
timezone                              | 文字列               | Timezone of the account. Defaults to `'US/Pacific'` <br><br>Possible values: <br>`'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'`, `'UTC'`, ...
status                                | 配列[文字列]        | Account status. This can only be edited by superusers and account superusers from the parent/owner account <br><br>Possible values: <br>`'active'` - normal working state <br>`'inactive'` - logins are not allowed <br>`'suspended'` - effectively no longer operational <br>`'pending_validation'` - default state after account creation (before the user has validated the account)
access_restriction                    | 配列[文字列]        | Array of strings containing access restrictions. Possible values: `'enable_mobile'` = If present this account has access to mobile clients. `'enable_ip_restrictions'` = if present and if `'allowable_ip_address_range'` has been specified, limits logins to the address ranges specified
allowable_ip_address_range            | 配列[文字列]        | Each entry in the array specifies one address range. Entries use the `'/'` format. For example, to limit access to `'192.168.123.0-192.168.123.255'`, the entry would be `'192.168.123.0/24'`. If no entries are present, `'0.0.0.0/0'` is implied
session_duration                      | 整数                  | Session duration in minutes. Session duration of 0 means *stay logged in forever*
holiday                               | 配列[文字列]        | Array of strings containing dates during which holidays are observed. Format for dates is YYYYMMDD
work_days                             | 配列[文字列]        | String of length 7. Each position in the string corresponds to a day of the week. Monday is position 0, Tuesday is position 1, etc. Each character in the string can have a value of 1 or 0. 1 means that this day is a work day
work_hours                            | 配列[文字列]        | Two entries. Each entry containing a time expressed in local time. The first entry in the array is the work day start time. The second entry in the array is the stop time. Times are represented using a 24 hour clock and are formatted as HHMM <br><br>Example: 8AM would be 0800 and 5PM would be 1700
alert_mode                            | 配列[文字列]        | Array of strings containing possible alert modes as defined for this account. Accepts an array of any number of strings of varying length. This controls what values are able to be chosen for the `'active_alert_mode field'`
active_alert_mode                     | 文字列               | A string chosen from values in the account `'alert_mode'` array. Must be blank or one of the values defined in the alert_mode array. This is used to determine when to send motion alert notifications (defined by camera settings in the device model). If a motion alert is defined with an alert mode from one of the strings in the account `'alert_mode'` array, then the notifications triggered from that motion alert will only be sent when the account `'active_alert_mode'` is also set to that same alert mode string defined for that motion alert
default_camera_passwords              | 文字列               | Comma-delimited string of default camera passwords
camera_shares                         | 配列[配列[文字列]] | Array of arrays with each sub-array representing a camera to be shared to 1 or more recipients. First element of the sub-array is action, with `'M'` for add/update or `'D'` for delete. Second element is camera ID. Third element is a string containing 1 or multiple recipients. All recipients are a single string value of `'email,account,email,account,...'` and are only present in the `'M'` action <br><br>Example: [[`'M'`, `'12345678'`, `'joe@em.com,His account,joe2@dd.com,That account'`]]
is_revoke_admins                      | 整数                  | Indicates whether to revoke all admin permissions for the users in the account (1) or not (0). This field doesn't save anything on the account itself. It will revoke admin privileges of any admins in the account
is_custom_brand                       | 整数                  | Indicates whether the account has branding enabled (1) or not (0)
brand_logo_small                      | 文字列               | Base64 encoded image for the branded small logo (PNG, 160x52, transparent background)
brand_logo_large                      | 文字列               | Base64 encoded image for the branded large logo (PNG, 460x184, white background)
brand_subdomain                       | 文字列               | Sub domain for the branded url
brand_corp_url                        | 文字列               | Corporate website url
brand_name                            | 文字列               | Branded company name
brand_saml_publickey_cert             | 文字列               | Public certificate which Eagle Eye Networks will use to decrypt the SAML for SSO
brand_saml_nameid_path                | 文字列               | The path within the SAML xml to find the users email address
is_master_video_disabled_allowed      | 整数                  | Indicates whether a sub-account can block video access to reseller (1) or not (0)
is_master_video_disabled              | 整数                  | Indicates whether video access is blocked to reseller (1) or not (0)
is_contract_recording                 | 整数                  | Indicates whether the account is of type contract_recording. Controls whether contract recording features are enabled for the users in this account on the front-end GUI (1) or not (0)
is_advanced_disabled                  | 整数                  | Indicates whether the reseller has disabled advanced functionality (1) or not (0). If this is set for a sub-account, the users in the sub-account cannot change any settings related to bandwidth, billing (retention and resolution) and certain account settings. Master users switched in still can modify these things if their permissions allow it
is_billing_disabled                   | 整数                  | Indicates whether the reseller has disabled editing settings in a sub-account that affect billing (1) or not (0). This controls whether users can change camera resolution/retention, add/delete cameras, etc
is_add_delete_disabled                | 整数                  | Indicates whether the reseller has disabled adding or deleting devices (1) or not (0)
is_disable_all_settings               | 整数                  | Indicates whether the reseller has disabled all device and most account settings (1) or not (0). Does not affect editing users, layouts, or sharing
first_responders                      | 配列[配列[文字列]] | Array of arrays with each sub-array representing an emergency responder. Accounts can identify a list of email accounts that will serve as emergency responders. Emergency responders get access to the identified `'responder_cameras'` during an emergency (triggered by setting `'responder_active'`). A responder is identified by their email, first name, last name, company and their account <br><br>Example: [[`'mark@responders.com'`, `'Mark'`, `'O'Malley'`, `'Responders'`, `'Fake Account'`]]
responder_active                      | <p hidden>???</p>    | Indicates whether the responder cameras can be seen by the users defined under `'first_responders'`
responder_cameras                     | 配列[文字列]        | Array of camera ESNs that are shared to first responders
inactive_session_timeout              | 整数                  | Maximum time period in seconds without activity before web session expires
login_attempt_limit                   | 整数                  | Maximum incorrect login attempts before the user account access becomes locked
is_rtsp_cameras_enabled               | 整数                  | Indicates whether the account can have cameras attached over RTSP (instead of ONVIF) (1) or not (0)
brand_support_phone                   | 文字列               | Branded support phone number
default_cluster                       | 文字列               | Indicates the data center cluster the account is assigned to
customer_id                           | 文字列               | Arbitrary ID assigned to a sub-account by a master account
is_system_notification_images_enabled | 整数                  | Indicates whether email notifications about online/offlice status should contain images from those cameras (1) or not (0)
map_lines                             | 文字列               | This is used by the front end to overlay lines over a map of the cameras for the account
contact_utc_offset                    | 整数                  | This field is no longer being used <small>**(DEPRECATED)**</small>

<aside class="notice">カメラ関連のフラグは、カメラを格納するアカウント内でのみ有効なカメラに対してのみ変更または設定できます</aside>

<aside class="notice">状態フラグは、マスターアカウントからのサブアカウントに対してのみ設定することができます</aside>

> JSON応答

```JSON
{
    "id": "1234abcd"
}
```

### HTTP 応答 (JSON属性)

パラメータ   | データ形式  | 詳細
--------- | --------- | -----------
id        | 文字列     | アカウントの一意の識別子

### エラー状態コード

HTTP状態コード      | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限が見つからなかったため禁止されました
404	| 提供された ID によるアカウントが見つかりませんでした
200	| 要求は成功しました

<!--===================================================================-->
## アカウントの削除
<!--===================================================================-->

アカウントを削除します

> 要求

```shell
curl -X DELETE https://login.eagleeyenetworks.com/g/account -d "id=[ACCOUNT_ID]" -G -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`DELETE https://login.eagleeyenetworks.com/g/account`

パラメータ  | データ型式   | 詳細
--------- | --------- | -----------
**id**    | 文字列     | アカウント ID



<!--TODO: Verify the curl request for delete-->

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限が見つからなかったため禁止されました
404	| 提供された ID によるアカウントが見つかりませんでした
200	| 削除は成功しました

<!--===================================================================-->
## アカウント リストの取得
<!--===================================================================-->

ユーザーが使用できるアカウントを表すそれぞれにサブ配列を持つ配列の配列を返します。

> 要求

```shell
curl --request GET https://login.eagleeyenetworks.com/g/account/list --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/account/list`

> JSON 応答

```JSON
[
    [
        "00004206",
        "Greater God",
        0,
        0,
        1,
        0,
        0,
        1,
        null,
        0,
        0,
        0,
        0,
        0,
        0,
        "20180228234555.722",
        0,
        "Greater ID"
    ],
    [...],
    [...]
]
```

### HTTP 応答 (属性の配列)

配列インデックス | 属性                   | データ形式  | 詳細
----------- | ---------              | --------- | -----------
0           | id                     | 文字列    | Unique identifier for the account
1           | name                   | 文字列    | Name of the account
2           | camera_online_count    | 整数       | Number of cameras currently online in the account
3           | camera_count           | 整数       | Number of cameras currently in the account
4           | user_count             | 整数       | Number of users currently in the account
5           | is_suspended           | 整数       | Indicates whether the account is suspended (1) or not (0)
6           | is_inactive            | 整数       | Indicates whether the account is inactive (1) or not (0)
7           | is_active              | 整数       | Indicates whether the account is active (1) or not (0)
8           | product_edition        | 文字列    | Product edition the account is using
9           | bridge_online_count    | 整数       | Number of online bridges owned by the account
10          | bridge_active_count    | 整数       | Number of active bridges owned by the account
11          | bridge_count           | 整数       | Number of bridges owned by the account
12          | camera_off_count       | 整数       | Number of account cameras that are currently offline
13          | camera_available_count | 整数       | Number of available cameras in the account
14          | is_account_active      | 整数       | Indicates the account is active (1) or not (0)
15          | last_login             | 文字列    | EEN timestamp of the last login by this account
16          | average_retention_days | 整数       | The average number of retention days for the account
17          | customer_id            | 文字列    | The customer ID assigned to this account

<aside class="success">Please note that the model definition has property keys, but that's only for reference purposes since it's just a standard array</aside>

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400 | 予期せぬまたは識別不能な引数が与えられました
401	| 無効なセッションクッキーにより認証されませんでした
403	| ユーザーに必要な権限が見つからなかったため禁止されました
200	| 要求は成功しました
