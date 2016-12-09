# アカウント

<!--===================================================================-->

## 概要

アカウントサービスはスーパーユーザー及びアカウントスーパーユーザーによって管理します。

<!--===================================================================-->

## アカウント モデル

> Account Model

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
            "No Account"
        ],
        [
            "jeff@noaccount.com",
            "Jeff",
            "O'unverfied",
            "Unverfied Organization",
            "Fake Sponder"
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
            "10101010",
            "share@email.com",
            "hasno@account.com,No Account"
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
        "20130101",
        "20130527",
        "20130704",
        "20130902",
        "20131128",
        "20131225"
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
    "default_cluster": "c9000",
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
    "brand_subdomain": "c9000"
}
```
<!--Need to update the recording and search sections-->

### Account Attributes

パラメータ  | データ形式     | 詳細 | 編集可 | 必須
------------ | ----------- | -------- | --------  | ---------
id 						| 文字列 		| Unique identifier for the Account |false | GET, POST, DELETE
name 					| 文字列 		| Name of the account | true | PUT
owner_account_id 		| 文字列 		| Id of parent account | false | 
contact_first_name 		| 文字列 		| First name of primary contact for account | true | PUT
contact_last_name  		| 文字列 		| Last name of primary contact for account | true | PUT
contact_email 			| 文字列 		| Email of primary contact for account | true | 
contact_street 			| 配列[文字列] | Array of 文字列s representing 1 or more parts of a street address of primary contact for account | true | 
contact_city 			| 文字列 		| City of primary contact for account | true | 
contact_state 			| 文字列 		| State/province of primary contact for account | true | 
contact_postal_code 	| 文字列 		| Zip/postal code of primary contact for account | true | 
contact_country 		| 文字列 		| Country of primary contact for account | true | 
timezone 				| 文字列 		| ['US/Alaska' or 'US/Arizona' or 'US/Central' or 'US/Pacific' or 'US/Eastern' or 'US/Mountain' or 'US/Hawaii' or 'UTC']: Timezone of the account. Defaults to US/Pacific. | true | 
utc_offset 				| 整数 			| Signed 整数eger offset in seconds of the timezone from UTC | false | 
access_restriction 		| 配列[文字列] | ['enable_mobile' or 'enable_ip_restrictions']: Each entry in the list contains a restriction. Possible values: 'enable_mobile' = If present this account can has access to mobile clients. 'enable_ip_restrictions' = if present, and if allowable_ip_address_ranges has been specified, limits logins to the address ranges specified. | false |
allowable_ip_address_range | 配列[文字列] | Each entry in the list specifies one address range. Entries use the ‘/’ format. For example, to limit access to 192.168.123.0-192.168.123.255, the entry would be 192.168.123.0/24. If no entries are present, 0.0.0.0/0 i s implied. | false |
session_duration 		| 整数 			| session duration in minutes. Session duration of 0 means 'stay logged in forever' | true|
holiday 				| 配列[文字列] | List of dates that during which holidays are observed. Format for dates is YYYYMMDD | true | 
work_days 				| 文字列 		| String of length 7. Each position in the string corresponds to a day of the week. Monday is position 0, Tuesday is position 1, etc... Each character in the string can have a value of 1 or 0. 1 means that this day is a work day.| true | 
work_hours 				| 配列[文字列] | Two entries. Each entry contains a time expressed in local time. The first entry in the list is the work day start time . The second entry in the list is the stop time. Times are represented using a 24 hour clock and are formatted as HHMM. For example, 8AM would be 0800 and 5PM would be 1700.| true | 
alert_mode 				| 配列[文字列] | List of possible alert modes as defined for this account.| true | 
active_alert_mode 		| 文字列 		| Must be blank or one of the values defined in alert_mode list.| true | 
default_colo  			| 文字列 		| Name of the colo in which this account data for this account will be stored by default.| falae | 
default_camera_passwords| 文字列 		| Comma-delimited string of default camera passwords | true | 
camera_shares 			| 配列[配列[文字列]]) | Array of arrays, with each sub array representing a camera to be shared to 1 or more email addresses. First element of sub array is action, with 'm' for add/update, and 'd' for delete. Second element of sub array is camera ID. Third element of sub array is an array of email addresses, but only applies to the 'm' action. Example: [['m', '12345678', ['test@testing.com','test2@testing.com]]] | true | 
is_master 				| 整数 			| ['0' or '1']: Indicates whether the account is a Master account (1) or not (0) | false | 
is_active 				| 整数 			| ['0' or '1']: Indicates whether the account is Active (1) or not (0)   | false |
is_inactive 			| 整数 			| ['0' or '1']: Indicates whether the account is inactive (1) or not (0) | true |
is_suspended 			| 整数 			| ['0' or '1']: Indicates whether the account is Suspended (1) or not (0) | true |
product_edition 		| 文字列 		| The product edition the account is using | false |
camera_quantity 		| 整数 			| The total number of cameras the account is allowed to use, | false |
is_custom_brand_allowed | 整数 			| ['0' or '1']: Indicates whether the account is allowed to have branding (1) or not (0) | true |
is_custom_brand 		| 整数 			| ['0' or '1']: Indicates whether the account has branding enabled (1) or not (0)  | true |
brand_logo_small 		| 文字列 		| Base64 encoded image for the branded small logo | true |
brand_logo_large 		| 文字列 		| Base64 encoded image for the branded large logo | true |
brand_subdomain 		| 文字列 		| Sub domain for the branded url | true |
brand_corp_url 			| 文字列 		| Corporate web site url | true |
brand_name 				| 文字列 		| Branded company name | true |
brand_saml_publickey_cert | 文字列      | Public Certificate that Eagle Eye Networks will use to decrypt the SAML for SSO | true |
brand_saml_nameid_path | 文字列      | The path within the SAML xml to find the users email address | true |
is_without_initial_user | 文字列 | desiginates an account at creation to not have a contact user created automatically | true |
customer_id | 文字列 | an arbitrary id assigned to a sub account by a master | true |
is_master_video_disabled_allowed | 整数 | 1 or 0 designating whether or not a sub account can block video access to reseller | true |
is_master_video_disabled | 整数 | 1 or 0 designating whether or not video access is blocked to reseller | true |
is_contract_recording | 整数 | 1 or 0 designating if the account is of type contract_recording | true |
is_advanced_disabled | 整数 | 1 or 0 set by reseller disabling advanced functionality | true |
is_billing_disabled | 整数 | 1 or 0 set by reseller disables setting settings in a sub that affect billing | true |
is_add_delete_disabled | 整数 | 1 or 0 set by reseller disables adding or deleting devices | true|
is_disable_all_settings | 整数 | 1 or 0 set by reseller disables all device and most account settings | true |
first_responders | 配列[配列[文字列]] | 配列[[responder_email,responder_first_name,responder_last_name,responder_organization]] | true |
responder_cameras | 配列[esn] | array of camera esns that are shared to first responders | true |
inactive_session_timeout | 整数 | time without activity until the web session expires | true |


<!--===================================================================-->

## アカウントの取得

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/account -d "id=[ID]&A=[AUTH_KEY]"
```

Returns account object by Id

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/account`

パラメータ 	| データ型式   | 詳細        | 必須？
--------- 	| ----------- | ----------- | -----------
**id**  	| 文字列      | Account Id 	| true

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200	| Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges

<!--===================================================================-->

## アカウントの作成

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X PUT -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/account -d '{"name": "[NAME]", "contact_first_name": "[CONTACT_FIRST_NAME]", "contact_last_name": "[CONTACT_LAST_NAME]", "contact_email": "[CONTACT_EMAIL]"}'
```

> JSON応答

```json
{
    "id": "1234abcd"
}
```

Creates a new Account

### HTTP要求

`PUT https://login.eagleeyenetworks.com/g/account`

パラメータ 				| データ型式   	| 詳細        	| 必須？
--------- 				| ----------- 	| ----------- 	| -----------
**name**  				| 文字列  		| Name of Account	| true
owner_account_id  		| 文字列      	| ID of parent account. If omitted, parent is set to the account of the creating user. | 
**contact_first_name**	| 文字列      	| First name of primary contact for account | true
**contact_last_name**	| 文字列      	| Last name of primary contact for account | true
**contact_email**		| 文字列      	| Email of primary contact for account | true
contact_street			| 配列[文字列] | Array of 文字列s representing 1 or more parts of a street address of primary contact for account
contact_city			| 文字列      	| City of primary contact for account.
contact_state			| 文字列      	| State/province of primary contact for account.
contact_postal_code		| 文字列      	| Zip/postal code of primary contact for account.
contact_country			| 文字列      	| Country of primary contact for account.
timezone				| 文字列, enum  | Timezone of Account. Defaults to US/Pacific. <br><br>enum: "US/Alaska", "US/Arizona", "US/Central", "US/Pacific", "US/Eastern", "US/Mountain", "US/Hawaii", "UTC"
status					| 配列[文字列] | Account status. This can only be edited by superusers and account_superusers of the parent/owner account. 'realm_root' can only be set by superusers.
access_restriction		| 配列[文字列] | Each entry in the list contains a restriction. Possible values: 'enable_mobile' = If present this account can has access to mobile clients. 'enable_ip_restrictions' = if present, and if allowable_ip_address_ranges has been specified, limits logins to the address ranges specified.
allowable_ip_address_ranges | 配列[文字列] | Each entry in the list specifies one address range. Entries use the ‘/’ format. For example, to limit access to 192.168.123.0-192.168.123.255, the entry would be 192.168.123.0/24. If no entries are present, 0.0.0.0/0 i s implied.
session_duration		| 整数      		| Session duration in minutes. Session duration of 0 means 'stay logged in forever'
holiday					| 配列[文字列] | List of dates that during which holidays are observed. Format for dates is YYYYMMDD
work_days				| 配列[文字列] | String of length 7. Each position in the string corresponds to a day of the week. Monday is position 0, Tuesday is position 1, etc... Each character in the string can have a value of 1 or 0. 1 means that this day is a work day.
work_hours				| 配列[文字列] | Two entries. Each entry contains a time expressed in local time. The first entry in the list is the work day start time . The second entry in the ist is the stop time. Times are represented using a 24 hour clock and are formatted as HHMM. For example, 8AM would be 0800 and 5PM would be 1700.
alert_mode 				| 配列[文字列] | List of possible alert modes as defined for this account.
active_alert_mode 		| 文字列      	| Must be blank or one of the values defined in alert_mode list.
default_colo			| 文字列      	| Name of the colo in which this account data for this account will be stored by default.
default_camera_passwords| 文字列      	| Comma-delimited string of default camera passwords
is_without_initial_user	| 整数      		| Indicates whether you want to NOT create an initial user with the new account. Defaults to 0, meaning an initial user (with is_account_superuser=1) will be created using the info from “contact_first_name/contact_last_name/contact_email” arguments of this new account. If this is set to 1, NO initial user will be created.
is_initial_user_not_admin| 整数      	| Indicates whether you want do NOT want the initial user to be an admin.

<!--===================================================================-->

## アカウントの更新

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X POST -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/account -d '{"id": "[ACCOUNT_ID]", "contact_first_name": "[CONTACT_FIRST_NAME]"}'
```

> JSON応答

```json
{
    "id": "1234abcd"
}
```

Update an Account

### HTTP要求

`POST https://login.eagleeyenetworks.com/g/account`

パラメータ 				| データ型式   	| 詳細        	| 必須？
--------- 				| ----------- 	| ----------- 	| -----------
**id**  				| 文字列  		| Unique identifier of Account | true
name  					| 文字列  		| Name of Account
contact_first_name		| 文字列      	| First name of primary contact for account
contact_last_name		| 文字列      	| Last name of primary contact for account
contact_email			| 文字列      	| Email of primary contact for account
contact_street			| 配列[文字列] | Array of strings representing 1 or more parts of a street address of primary contact for account
contact_city			| 文字列      	| City of primary contact for account.
contact_state			| 文字列      	| State/province of primary contact for account.
contact_postal_code		| 文字列      	| Zip/postal code of primary contact for account.
contact_country			| 文字列      	| Country of primary contact for account.
timezone				| 文字列, enum  | Timezone of Account. Defaults to US/Pacific. <br><br>enum: "US/Alaska", "US/Arizona", "US/Central", "US/Pacific", "US/Eastern", "US/Mountain", "US/Hawaii", "UTC"
status					| 配列[文字列] | Account status. This can only be edited by superusers and account_superusers of the parent/owner account. 'realm_root' can only be set by superusers.
access_restriction		| 配列[文字列] | Each entry in the list contains a restriction. Possible values: 'enable_mobile' = If present this account can has access to mobile clients. 'enable_ip_restrictions' = if present, and if allowable_ip_address_ranges has been specified, limits logins to the address ranges specified.
allowable_ip_address_ranges | 配列[文字列] | Each entry in the list specifies one address range. Entries use the ‘/’ format. For example, to limit access to 192.168.123.0-192.168.123.255, the entry would be 192.168.123.0/24. If no entries are present, 0.0.0.0/0 i s implied.
session_duration		| 整数      		| Session duration in minutes. Session duration of 0 means 'stay logged in forever'
holiday					| 配列[文字列] | List of dates that during which holidays are observed. Format for dates is YYYYMMDD
work_days				| 配列[文字列] | String of length 7. Each position in the string corresponds to a day of the week. Monday is position 0, Tuesday is position 1, etc... Each character in the string can have a value of 1 or 0. 1 means that this day is a work day.
work_hours				| 配列[文字列] | Two entries. Each entry contains a time expressed in local time. The first entry in the list is the work day start time . The second entry in the ist is the stop time. Times are represented using a 24 hour clock and are formatted as HHMM. For example, 8AM would be 0800 and 5PM would be 1700.
alert_mode 				| 配列[文字列] | List of possible alert modes as defined for this account.
active_alert_mode 		| 文字列      	| Must be blank or one of the values defined in alert_mode list.
default_colo			| 文字列      	| Name of the colo in which this account data for this account will be stored by default.
default_camera_passwords| 文字列      	| Comma-delimited string of default camera passwords
camera_shares 			| array[array[string]] | Array of arrays, with each sub array representing a camera to be shared to 1 or more email addresses. First element of sub array is action, with 'm' for add/update, and 'd' for delete. Second element of sub array is camera ID. Third element of sub array is an array of email addresses, but only applies to the 'm' action. Example: [['m', '12345678', ['test@testing.com','test2@testing.com]]]
is_revoke_admins		| 整数      		| Indicates whether you want to revoke all Admin permissions for the users in the account.
is_custom_brand			| 整数      		| Indicates whether branding is enabled for the account
brand_logo_small		| 文字列      	| Base64 encoded image for the branded small logo
brand_logo_large		| 文字列      	| Base64 encoded image for the branded large logo
brand_subdomain			| 文字列      	| Sub domain for the branded url
brand_corp_url			| 文字列      	| Corporate web site url
brand_name				| 文字列      	| Branded company name
brand_saml_publickey_cert | 文字列      | Public Certificate that Eagle Eye Networks will use to decrypt the SAML for SSO
brand_saml_nameid_path | 文字列      | The path within the SAML xml to find the users email address


<!--===================================================================-->

## アカウントの削除

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X DELETE -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/account -d "id=[ACCOUNT_ID]" -G
```

Delete an Account

### HTTP要求

`DELETE https://login.eagleeyenetworks.com/g/account`

パラメータ     | データ型式   | 詳細
---------     | ----------- | -----------
**id**        | 文字列      | Account Id

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200	| Delete succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
404	| Account not found with the supplied ID

<!--===================================================================-->

## アカウント リストの取得

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" --request GET https://login.eagleeyenetworks.com/g/account/list
```

> JSON応答

```json
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
        "20160228234555.722",
        0,
        "Greater ID"
    ],
    [...],
    [...]
]
```

Returns array of arrays, with each sub-array representing an account available to the user. Please note that the ListAccount model definition below has property keys, but that's only for reference purposes since it's actually just a standard array.

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/account/list`

### Account Array Attributes

Array Index		| Attribute   			| データ型式  	| 詳細       
---------------	| --------------------- | -----------  	| -----------
0               | id          			| 文字列       	| Unique identifier for the Account
1 				| name 					| 文字列 		| Name of the account
2 				| camera_online_count	| 整数 			| Number of cameras currently online in the account
3				| camera_count 			| 整数 			| Number of cameras currently in the account
4 				| user_count 			| 整数 			| Number of users currently in the account
5 				| is_suspended 			| 整数 			| Indicates the account is Suspended (1) or not (0) 
6 				| is_inactive 			| 整数 			| Indicates the account is Inactive (1) or not (0)
7 				| is_active 			| 整数 			| Indicates the account is Active (1) or not (0)
8 				| product_edition 		| 文字列 		| Product edition in use by the account
9               | bridge_online_count   | 整数           | Number of online bridges owned by the account
10              | bridge_active_count   | 整数           | Number of active bridges owned by the account
11              | bridge_count          | 整数           | Number of bridges owned by the account
12              | camera_off_count      | 整数           | Number of account cameras that are currently offline
13              | camera_available_count| 整数           | Number of available cameras in the account
14              | is_account_active     | 整数           | 1 or 0 dennoting if account is active
15              | last_login            | 文字列        | EEN Timestamp of the last login by this account
16              | aberage_retention_days| 整数           | The average number of retention days for the account
17              | customer_id           | 文字列        | The customer id assigned this account

<!---TODO Update Account Array Attributes-->

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200	| Request succeeded
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
