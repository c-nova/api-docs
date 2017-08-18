# ユーザー

<!--===================================================================-->
## 概要
<!--===================================================================-->

ユーザーサービスでは、権限レベルに合わせてユーザーを管理できます

<!--===================================================================-->
## ユーザー モデル
<!--===================================================================-->

> ユーザー モデル

```json
{
    "id": "ca0e1cf2",
    "first_name": "Firstname",
    "last_name": "Lastname",
    "email": "john.doe@fakeemail.com",
    "owner_account_id": "00004206",
    "active_account_id": "00004206",
    "uid": " ",
    "is_superuser": 0,
    "is_account_superuser": 1,
    "is_staff": 0,
    "is_active": 1,
    "is_pending": 0,
    "is_master": 1,
    "is_user_admin": 1,
    "is_layout_admin": 1,
    "is_live_video": 1,
    "is_device_admin": 1,
    "is_export_video": 1,
    "is_recorded_video": 1,
    "is_edit_cameras": 1,
    "is_edit_all_users": 1,
    "is_edit_account": 1,
    "is_system_notifications_disabled": 0,
    "is_edit_ptz_stations": 1,
    "is_view_preview_video": 1,
    "is_edit_camera_on_off": 1,
    "is_edit_camera_less_billing": 1,
    "is_edit_all_and_add": 1,
    "is_edit_sharing": 1,
    "is_mobile_branded": 0,
    "is_edit_admin_users": 1,
    "is_view_contract": 1,
    "is_ptz_live": 1,
    "is_view_audit_trail": 1,
    "is_edit_users": 1,
    "is_edit_motion_areas": 1,
    "is_two_factor_authentication_enabled": 0,
    "user_authenticated_clients": null,
    "account_utc_offset": -21600,
    "account_work_days": "1111100",
    "account_work_hours": ["0800", "1730"],
    "language": "en-us",
    "inactive_session_timeout": 15,
    "street": ["address line 1", "address line 2"],
    "city": "New York",
    "state": "Alaska",
    "country": "US",
    "postal_code": "9980-999",
    "phone": "111111111",
    "mobile_phone": "000000000",
    "utc_offset": -21600,
    "timezone": "US/Pacific",
    "last_login": "20181006173752.672",
    "alternate_email": "alternate.email@fakeemail.com",
    "sms_phone": "222111222",
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
    "access_period": [
        "0-0000-2359",
        "1-0000-2359",
        "2-0000-2359",
        "3-0000-2359",
        "4-0000-2359",
        "5-0000-2359",
        "6-0000-2359"
    ],
    "is_terms_noncompliant": 1
}
```

### ユーザー (属性)

パラメータ                              | データ形式          | 説明                                                                                  | 編集可能      | 必須？
---------                            | ---------         | -----------                                                                          |:-----------:| --------
**id**                               | 文字列              | ユーザーの一意な識別子                                                                    | **&cross;** | **<sub><form action="#update-user"><button>POST</button></form></sub>** <br>**<sub><form action="#delete-user"><button>DELETE</button></form></sub>**
**first_name**                       | 文字列              | ユーザーの名                                                                            | **&check;** | **<sub><form action="#create-user"><button>PUT</button></form></sub>**
**last_name**                        | 文字列              | ユーザーの姓                                                                            | **&check;** | **<sub><form action="#create-user"><button>PUT</button></form></sub>**
**email**                            | 文字列              | 認可されたユーザーのEメール (このEメールはASCII文字のみ必要)                                      | **&check;** | **<sub><form action="#create-user"><button>PUT</button></form></sub>**
owner_account_id                     | 文字列              | ユーザーが所属するアカウントの一意の識別子                                                      | **&cross;** |
active_account_id                    | 文字列              | ユーザーのアクティブなアカウントの一意の識別子。サブアカウントに切り替えると、そのユーザーのセッションの `'active_account_id'` が、切り替えられたサブアカウントの一意の識別子になります                                                                                                                   | **&cross;** |
uid                                  | 文字列              | ユーザーの識別子 <small>**(内部利用のみ)**</small>                                          | **&cross;** |
is_staff                             | 整数               | ユーザーがスタッフであるか(1)、ないか(0) <small>**(内部利用のみ)**</small>                       | **&check;** |
is_superuser                         | 整数               | ユーザーがスーパーユーザーであるか(1)、ないか(0)かを示します。スーパーユーザーだけがこれを設定できます <small>**(内部利用のみ)**</small>                                                                                                                                    | **&check;** |
is_account_superuser                 | 整数               | ユーザーがアカウントのスーパーユーザーである(1)かないか(0)を示します                                 | **&check;** |
is_active                            | 整数               | ユーザーがアクティブか(1)、ないか(0)を示します                                                 | **&check;** |
is_pending                           | 整数               | ユーザーが保留中か(1)、ないか(0)を示します                                                    | **&cross;** |
is_master                            | 整数               | ユーザーがマスターアカウントにあるか(1)、ないか(0)を示します                                       | **&cross;** |
is_user_admin                        | 整数               | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>                             | **&check;** |
is_layout_admin                      | 整数               | ユーザーがレイアウト管理者か(1)、ないか(0)を示します                                             | **&check;** |
is_live_video                        | 整数               | ユーザーがライブビデオにアクセスする権限を持っているか(1)、ないか(0)を示します                         | **&check;** |
is_device_admin                      | 整数               | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>                             | **&check;** |
is_export_video                      | 整数               | ユーザーがビデオのエクスポートを許可を持っているか(1)、ないか(0)を示します                            | **&check;** |
is_recorded_video                    | 整数               | ユーザーが記録されたビデオを見る権限を持っているか(1)、ないか(0)を示します                            | **&check;** |
is_edit_cameras                      | 整数               | ユーザーがカメラの編集権限を持っているか(1)、ないか(0)を示します                                    | **&check;** |
is_edit_all_users                    | 整数               | マスターアカウントの管理者でないユーザーで、ユーザーを管理する権限が付与されているか(1)、ないか(0)を示します   | **&check;** |
is_edit_account                      | 整数               | ユーザーがアカウント設定を編集する権限を持っているか(1)、ないか(0)を示します                           | **&check;** |
is_system_notifications_disabled     | 整数               | ユーザーが所属するアカウントにシステム通知が無効か(1)、ないか(0)かが反映されます。trueの場合、ユーザーはアカウント内のカメラのシステムアラート通知を受け取ることができません                                                                                                                              | **&check;** |
is_edit_ptz_stations                 | 整数               | ユーザーがPTZステーションを編集する権限を持っているか(1)、ないか(0)を示します                         | **&check;** |
is_view_preview_video                | 整数               | ユーザーがカメラからプレビュー画像を表示する権限を持っているか(1)、ないか(0)を示します                   | **&check;** |
is_edit_camera_on_off                | 整数               | ユーザーがカメラをオンまたはオフにする権限を持っているか(1)、ないか(0)を示します                        | **&check;** |
is_edit_camera_less_billing          | 整数               | ユーザーが保存期間およびフルビデオの解像度以外のすべてのカメラ設定を編集する権限を持っているか(1)、ないか(0)を示します                                                                                                                                               | **&check;** |
is_edit_all_and_add                  | 整数               | ブリッジとカメラの追加/編集/削除権限がユーザーに付与されているか(1)、ないか(0)を示します                 | **&check;** |
is_edit_sharing                      | 整数               | ユーザーがアカウント設定内の *共有* と *レスポンダー* タブの表示/編集する権限を持っているか(1)、ないか(0)を示します                                                                                                                                              | **&check;** |
is_mobile_branded                    | 整数               | モバイル デバイスで使用                                                                   | **&cross;** |
is_edit_admin_users                  | 整数               | ユーザーがサブアカウント内のすべてのユーザーを管理する権限を持っているか(1)、ないか(0)を示します           | **&check;** |
is_view_contract                     | 整数               | ユーザーが契約の表示/再生ができるか(1)、ないか(0)を示します                                      　| **&check;** |
is_ptz_live                          | 整数               | PTZカメラのプレビューまたはライブビデオを表示しているときにパン、チルト、ズーム、ステーションへのリコールを制御する権限があるか(1)、ないか(0)を示します                                                                                                                                              | **&check;** |
is_view_audit_trail                  | 整数               | ユーザーが監査証跡機能の表示を許可されているか(1)、ないか(0)を示します                               | **&cross;** |
is_edit_users                        | 整数               | サブアカウントの管理者でないユーザーを管理する権限がユーザーに付与されているか(1)、ないか(0)を示します       | **&check;** |
is_edit_motion_areas                 | 整数               | カメラ設定内の *モーション* タブを表示および編集する権限があるか(1)、ないか(0)を示します                | **&check;** |
is_two_factor_authentication_enabled | 整数               | <p hidden>???</p>                                                                    | <p hidden>???</p> |
user_authenticated_clients           | <p hidden>???</p> | <p hidden>???</p>                                                                    | <p hidden>???</p> |
account_utc_offset                   | 整数               | UTCからのタイムゾーンの秒単位の符号付き整数オフセット。これは、ユーザの関連するアカウントモデルからの `'utc_offset'` の値です                                                                                                                                              | **&cross;** |
account_work_days                    | 文字列              | ユーザーの関連するアカウントモデルの `'work_days'` 値。どの日が稼働日であるかを示します               | **&cross;** |
account_work_hours                   | 配列[文字列]         | ユーザーの関連するアカウントモデルの `'work_hours'` 値。 アカウントの稼働時間を示します               | **&cross;** |
language                             | 文字列              | 言語コード。現在、APIはGUIの表示言語として英語（en-us）と日本語（ja）のみをサポートしています。有効な言語コードを入力として受け取りますが、サポートされていない言語の場合は英語のテキストが表示されます                                                                                                         | **&check;** |
inactive_session_timeout             | 整数               | Webセッションの有効期限が切れるまでの最大時間（秒単位）。ユーザーが所属するアカウントの設定で定義されます     | **&cross;** |
street                               | 配列[文字列]         | 住所を含む文字列の配列 [`'address line 1'`, `'address line 2'`]                           | **&check;** |
city                                 | 文字列              | 都市名（訳注： 日本では市区町村）                                                            | **&check;** |
state                                | 文字列              | 週/地方（訳注： 日本では都道府県）                                                           | **&check;** |
country                              | 文字列              | 2文字の国コード                                                                         | **&check;** |
postal_code                          | 文字列              | 郵便番号                                                                               | **&check;** |
phone                                | 文字列              | 電話番号                                                                               | **&check;** |
mobile_phone                         | 文字列              | 携帯電話番号                                                                            | **&check;** |
utc_offset                           | 整数               | UTCからのタイムゾーンの秒単位の符号付き整数オフセット。タイムゾーンフィールドに基づいて自動的に生成されます    | **&cross;** |
timezone                             | 文字列              | ユーザーのタイムゾーン。 可能な値：`'US/Pacific'` <br><br>利用可能な値: <br>`'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'`, `'UTC'` など                                                               | **&check;** |
last_login                           | 文字列              | EENユーザーによる最後のログインのタイムスタンプ。 フォーマット：YYYYMMDDHHMMSS.NNN                  | **&cross;** |
alternate_email                      | 文字列              | 別のEメールアドレス                                                                      | **&check;** |
sms_phone                            | 文字列              | SMS通知に使用する電話番号                                                                 | **&check;** |
is_sms_include_picture               | 整数               | 画像つきアラート通知をMMS経由で sms_phone 番号に通知するか(1)、ないか(0)を示します                   | **&check;** |
json                                 | 文字列              | JSON文字列としてのユーザーのその他の設定 ([UserJson](#userjson-attributes))                   | **&check;** |
camera_access                        | 配列[配列[文字列]]    | デバイス単位で定義された配列の配列（スーパーユーザーまたはアカウントスーパーユーザーのみがこのフィールドを編集できます）。各サブアレイには2つの要素が含まれています。最初のフィールドはデバイスの一意な識別子で、2番目のフィールドはユーザーのアクセス権限を示す1文字以上の文字列です<br><br>例：<br> [`'1005f2ed'`,`'RWS'`] = ユーザはこのデバイスを表示、変更、削除できます<br><br>権限は次のとおりです：<br> `'R'` - ユーザーはこのカメラの画像とビデオの表示権限があります<br>`'W'` - ユーザーはこのカメラの変更と削除が可能です<br>`'S'` - このカメラをグループシェアで共有することができます                                                                                                                                               | **&check;** |
layouts                              | 配列[文字列]         | ユーザーがアクセスできるレイアウトの一意の識別子のリスト                                           | **&check;** |
is_notify_enable                     | 整数               | ユーザーに対して通知が有効か(1)無効か(0)を示します                                               | **&check;** |
notify_period                        | 配列[文字列]         | ユーザーがアラート通知を受信する期間。配列の各要素には、ダッシュで区切られた3つのフィールドがあります。最初のフィールドは、月曜日を0とする週の曜日です。2番目の要素は開始時刻です。3番目の要素は終了時刻です。空の場合、ユーザーはアラート通知を受信しません <br><br>すべての時刻はローカルタイムで表され、HHMMとしてフォーマットされた24時間の時計を使用します                                                                                                                                               | **&check;** |
notify_rule                          | 配列[文字列]         | アラート通知ルール。各ルールは、`'Alert_Label-Notification_Method-Delay'` というフォームの中にダッシュで区切られた3つのフィールドを含みます <br><br>`'Alert_Label'` - ユーザが定義した名前 <br>`'Notification_Method'` - `'email'`、 `'SMS'` または `'GUI'` <br>`'Delay'` - 各通知の間隔時間（分）                                                                                                                                               | **&check;** |
is_branded                           | 整数               | ユーザーが関連しているアカウントで現在ブランディングが有効になっているか(1)、ないか(0)を示します            | **&cross;** |
active_brand_subdomain               | 文字列              | ユーザーが関連しているアカウントがブランディングを有効にしている場合、ここには存在しているそのブランドのサブドメインが示されます                                                                                                                                               | **&cross;** |
account_map_lines                    | JSON              | ユーザーの現在のアカウント設定 `'map_lines'` から自動的に取得されます                              | **&cross;** |
access_period                        | 配列[文字列]         | ユーザーがアカウントにアクセスできる期間が含まれます。配列の各要素には、ダッシュで区切られた3つのフィールドが含まれています。最初のフィールドは、月曜日を0とする週の曜日が含まれます。2番目の要素は開始時刻です。3番目の要素は終了時刻です。空の場合、ユーザーはアカウントへのアクセスに時間制限がありません。すべての時間はローカルタイムで表され、HHMMで表される24時間形式の時計を使用します                                                                                                                                              | **&check;** |
is_terms_noncompliant                | 整数               | 利用規約がユーザーによって受け入れられたか(0)、いないか(1)を示します                                 | **&cross;** |

### UserJson属性

パラメータ   | データ形式  | 詳細
--------- | --------- | -----------
een       | 文字列      | EEN オブジェクト ([UserJsonEEN](#userjsoneen-attributes))

### UserJsonEEN 属性

パラメータ                | データ形式    | 詳細
---------               | ---------  | -----------
show_AMPM               | ブーリアン    | 時刻をAM / PMで表示するか(True)、否か(False)を示します
milliseconds_display    | ブーリアン    | 時間をミリ秒で表示するか(True)、否か(False)を示します
layout_rotation_seconds | 整数        | 設定されている場合は、自動ローテーション中のレイアウト変更の待機時間を示します。設定されていない場合、または0に設定されている場合は自動ローテーションは行われません
motion_boxes            | ブーリアン    | モーションボックスを表示するか(True)、表示しないか(False)を示します
notify_levels           | 配列[整数]   | ユーザーへの通知を行うレベルを示す整数値の配列 <br><br>通知レベル：<br>1 - `'Low'` - 低アラート通知設定 <br>2 - `'High'` - 高アラート通知設定<br>3 - `'System'` - 非ユーザー定義の通知設定（カメラの状態変更を含む：オンライン/オフライン/オフ/インターネットオフライン/ ...） <br><br>カメラでモーションアラートが作成された場合、モーションボックストリガには、`'High'` または `'Low'` を割り当てることができます。カメラの状態が変化した場合、`'System'` アラート通知を受け取る設定をしているユーザーは、自分のアカウントのカメラ状態の変化が通知されます。イベントが `'High'` に設定されたモーションボックス内でモーションアラートが発報されると、通知レベルが `'High'` を受け取る設定をしているすべてのユーザに状態が通知されます
permissions             | JSON       | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>
employee_id             | 文字列       | 必要な権限を持つユーザーが他のユーザーに設定できる識別子
layouts                 | JSON       | アカウントの一意の識別子をキーとしたJson形式のデータ。各値は、アカウント内のレイアウトのグローバルな一意の識別子の配列であり、ユーザーがGUIで表示する際の順序が付けられます

<!--===================================================================-->
## 権限
<!--===================================================================-->

ユーザーにはいくつかのタイプがあります：

  - スーパーユーザー (superuser) <small>**(内部利用のみ)**</small>
  - スタッフ (staff) <small>**(内部利用のみ)**</small>
  - アカウント スーパーユーザー (account superuser)
  - 一般ユーザー (regular user)

**アカウント スーパーユーザー**

アカウントのスーパーユーザーには全ての権限があります。このユーザーは、アカウントとサブアカウントのすべてのユーザーを管理できます

<aside class="notice">管理者ステータスは 'is_account_superuser' フラグで示されます</aside>

**一般ユーザー**

一般ユーザーは作成された後、いくつかのデフォルトのアクセス権が付与されます： `'is_live_video'`, `'is_recorded_video'`, `'is_export_video'`

### 権限のリスト

必要なパラメータ                | 詳細
------------------          | -----------
is_superuser                | <small>**(内部利用のみ)**</small>
is_staff                    | <small>**(内部利用のみ)**</small>
is_account_superuser        | ユーザーで可能な最も高い権限レベル。すべての権限が有効になります（表示権限を含む）
is_edit_account             | すべてのアカウント設定（次のカテゴリーを含みます： コントロール、日数、セキュリティ、カメラ、アラート、通知、プライバシー、共有、レスポンダーなど）を表示および編集することができます
is_edit_camera_on_off       | カメラの電源をオンまたはオフにすることができます。これが唯一のカメラ権限の場合は、他のすべてのカメラ機能は隠されます
is_edit_cameras             | すべてのカメラ設定を編集できます（カメラの追加や削除はできません）。この権限でプレビュー表示が自動的に有効になります
is_edit_motion_areas        | カメラ設定の *モーション* タブを有効にします。この権限によってプレビューの表示と録画されたビデオの表示が自動的に有効になります
is_edit_ptz_stations        | カメラ設定の *PTZ* タブを有効にします。PTZモードの設定と、ステーションを追加/編集/削除が行えます。この権限によりプレビューの表示が自動的に有効になります
is_edit_sharing             | アカウント設定の *共有* と *レスポンダー* タブを有効にします（この設定は `'is_edit_account'` が有効な場合は不要です）
is_edit_users               | サブアカウントの管理者以外のユーザーの管理（ユーザーの追加/削除/変更）を有効にします。カメラとレイアウトへのアクセスを許可する権限が付与されます
is_export_video             | プレビューおよびフル解像度のビデオをダウンロードできます。プレビューの表示が自動的に有効になります
is_edit_all_and_add         | ブリッジとカメラの管理（追加/編集/削除）を有効にします。 デバイスのみを参照します。この権限でプレビューの表示が自動的に有効になります
is_edit_camera_less_billing | 保存期間およびフルビデオの解像度（追加/削除機能なし）以外のすべてのカメラ設定を編集できます。プレビューの表示は、この権限で自動的に有効になります
is_layout_admin             | レイアウトの管理を可能にします（ユーザーは自分のレイアウトを作成/編集/削除できます。ユーザーのレイアウトは常に管理者ユーザーに表示されます）
is_live_video               | カメラのフル解像度のライブビデオの表示を許可します。プレビューの表示は、この権限で自動的に有効になります
is_ptz_live                 | PTZカメラのプレビューまたはライブビデオの表示中に、パン、チルト、ズーム、ステーションへのリコールを制御できます。プレビュー表示は、この権限で自動的に有効になります
is_recorded_video           | ヒストリブラウザとカメラからの保存されたビデオを表示します。プレビューの表示は、この権限で自動的に有効になります
is_view_preview_video       | カメラからの画像のプレビューを可能にします
is_edit_admin_users         | サブアカウントのすべてのユーザーの管理を有効にします（管理者を含むすべてのユーザーの追加/削除/変更。マスターユーザーのみ利用可能）
is_edit_all_users           | 管理者ではないマスターユーザー（マスターアカウントユーザーの追加/削除/変更）の管理を可能にします <br><br>サブアカウントへのアクセスを許可します。サブアカウントにはユーザー権限は与えられていません。マスターアカウントユーザーのみ利用可能です
is_device_admin             | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>
is_user_admin               | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>


### ユーザー権限対応表

以下の表は、ユーザが所属するアカウントと有効にした許可フラグによって実行できるユーザ管理アクションを示しています

<table style="margin-top:30px;">
  <tr>
    <td style="background-color:#EAF2F6;" rowspan="3" colspan="3" ></td>
    <th colspan="4" style="text-align:center; border:solid 1px;background-color:#F3F7FA;">どのユーザーか</td>
  </tr>
  <tr>
    <th colspan="2" style="text-align:center;border:solid 1px;background-color:#F3F7FA;">マスターアカウント内</td>
    <th colspan="2" style="text-align:center;border:solid 1px;background-color:#F3F7FA;">サブアカウント内</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">アカウントスーパーユーザー (ASU)</td>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">一般ユーザー (RU)</td>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">アカウントスーパーユーザー (ASU)</td>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">一般ユーザー (RU)</td>
  </tr>
  <tr>
    <th style="vertical-align:middle; border:solid 1px;background-color:#F3F7FA;" rowspan="12">何ができるか</td>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;" rowspan="3">自分のアカウント内</td>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">対ASU</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">取得、作成、更新、削除</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">取得、作成、更新、削除</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">対RU</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">取得、作成、更新、削除</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">is_edit_all_users == Trueの場合は取得、作成、更新、削除</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">取得、作成、更新、削除</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">is_edit_users == Trueの場合は取得、作成、更新、削除</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">ユーザーリストの取得</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">はい</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">いいえ</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">はい</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">いいえ</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;" rowspan="3">親アカウント内</td>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">対ASU</td>
    <td colspan="2" rowspan="3" style="background-color:#EAF2F6;text-align:center;border:solid 1px;vertical-align:middle;">マスターアカウントには親はありません</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">対RU</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">ユーザーリストの取得</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">いいえ</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">いいえ</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;" rowspan="3">子アカウント内</td>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">対ASU</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">取得、作成、更新、削除</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">is_edit_admin_users == Trueの場合は取得、作成、更新、削除</td>
    <td rowspan="3" colspan="2" style="background-color:#EAF2F6;text-align:center;border:solid 1px;vertical-align:middle;">子アカウントには子はありません</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">対RU</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">取得、作成、更新、削除</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">is_edit_users == True または is_edit_admin_users==Trueの場合は取得、作成、更新、削除</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">ユーザーリストの取得</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">はい</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">is_edit_admin_users == Trueの場合は はい</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;" rowspan="3">兄弟アカウント内</td>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">対ASU</td>
    <td rowspan="3" colspan="2" style="background-color:#EAF2F6;text-align:center;border:solid 1px;vertical-align:middle;">マスターアカウントには兄弟関係はありません</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">対RU</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">なし</td>
  </tr>
  <tr>
    <th style="text-align:center;border:solid 1px;background-color:#F3F7FA;vertical-align:middle;">ユーザーリストの取得</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">いいえ</td>
    <td style="border:solid 1px;background-color:#F9FBFC;">いいえ</td>
  </tr>
</table>

<!--===================================================================-->
## ユーザー情報の取得
<!--===================================================================-->

IDが与えられるとユーザー オブジェクトを返します。

<aside class="notice">一意の識別子が与えられない場合、現在認可されているユーザーの情報が返されます</aside>

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/user -d "A=[AUTH_KEY]"

または

curl -G https://login.eagleeyenetworks.com/g/user -d "id=[USER_ID]" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/g/user`

パラメータ   | データ形式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
id        | 文字列    | ユーザーの一意の識別子 | false

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
404	| No user matching the unique identifier was found
200	| Request succeeded

<!--===================================================================-->
## ユーザーの作成
<!--===================================================================-->

新しいユーザーを作成します。 作成後、ユーザーは保留状態になります(`'is_pending=1'`, `'is_active=0'`)。ユーザー作成通知電子メールは、作成要求時に渡された電子メールアドレスに送信されます。その後、ユーザーはパスワードを入力することができます（この手順では、 [利用規約](#terms-of-service)) を受け入れる必要があります）。この操作の後、ユーザーはアクティブになります(`'is_pending=0'`, `'is_active=1'`)

> 要求

```shell
curl -X PUT https://login.eagleeyenetworks.com/g/user -d '{"first_name": "[FIRST_NAME]", "last_name": "[LAST_NAME]", "email": "[EMAIL]"}' -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP Request

`PUT https://login.eagleeyenetworks.com/g/user`

パラメータ        | データ形式  | 詳細         | 必須？
---------      | --------- | ----------- | -----------
**first_name** | 文字列     | The first name of the user | true
**last_name**  | 文字列     | The last name of the user | true
**email**      | 文字列     | The email address of the user | true
sms_phone      | 文字列     | Phone number to be used for SMS notifications

<aside class="notice">TFA認証が使用され、SMSによる認証コードの配信が設定されている場合、ユーザーの `'sms_phone'` 番号を定義する必要があります</aside>

> JSON 応答

```json
{
    "id": "ca0ffa8c"
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ形式  | 詳細
--------- | --------- | -----------
id        | 文字列     | ユーザーの一意の識別子

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
409	| The email address is currently already in use
200	| Request succeeded

<!--===================================================================-->
## ユーザー情報の更新
<!--===================================================================-->

ユーザー情報を更新します

> 要求

```shell
curl -X POST https://login.eagleeyenetworks.com/g/user -d '{"id": "[USER_ID]", "first_name": "[FIRST_NAME]"}' -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/g/user`

パラメータ                     | データ形式      | 説明                                     | 必須？
---------                   | ---------     | -----------                             | -----------
**id**                      | 文字列          | ユーザーの一意な識別子                        | true
first_name                  | 文字列          | ユーザーの名
last_name                   | 文字列          | ユーザーの姓
email                       | 文字列          | 認可されたユーザーのEメール (このEメールはASCII文字のみ必要)
phone                       | 文字列          | 電話番号
mobile_phone                | 文字列          | 携帯電話番号
uid                         | 文字列          | ユーザーの識別子。スーパーユーザーだけがこれを設定できます <small>**(内部利用のみ)**</small>
street                      | 配列[文字列]     | 住所を含む文字列の配列 [`'address line 1'`, `'address line 2'`]
city                        | 文字列          | 都市名（訳注： 日本では市区町村）
state                       | 文字列          | 週/地方（訳注： 日本では都道府県）
country                     | 文字列          | 2文字の国コード
postal_code                 | 文字列          | 郵便番号
json                        | 文字列          | JSON文字列としてのユーザーのその他の設定 ([UserJson](#userjson-attributes)) is_staff                    | 整数           | ユーザーがスタッフであるか(1)、ないか(0)。スーパーユーザーだけがこれを設定できます <small>**(内部利用のみ)**</small>
is_superuser                | 整数           | ユーザーがスーパーユーザーであるか(1)、ないか(0)かを示します。スーパーユーザーだけがこれを設定できます <small>**(内部利用のみ)**</small>
is_account_superuser        | 整数           | ユーザーがアカウントのスーパーユーザーである(1)かないか(0)を示します。スーパーユーザーまたはアカウントスーパーユーザーだけがこれを設定できます
is_layout_admin             | 整数           | ユーザーがレイアウト管理者か(1)、ないか(0)を示します
is_device_admin             | 整数           | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>
is_user_admin               | 整数           | これは下位互換性のためのパラメータです <small>**(廃止予定)**</small>
is_live_video               | 整数           | ユーザーがライブビデオにアクセスする権限を持っているか(1)、ないか(0)を示します
is_export_video             | 整数           | ユーザーがビデオのエクスポートを許可を持っているか(1)、ないか(0)を示します
is_recorded_video           | 整数           | ユーザーが記録されたビデオを見る権限を持っているか(1)、ないか(0)を示します
is_edit_cameras             | 整数           | ユーザーがカメラの編集権限を持っているか(1)、ないか(0)を示します
is_edit_all_users           | 整数           | マスターアカウントの管理者でないユーザーで、ユーザーを管理する権限が付与されているか(1)、ないか(0)を示します
is_edit_account             | 整数           | ユーザーがアカウント設定を編集する権限を持っているか(1)、ないか(0)を示します
is_edit_ptz_stations        | 整数           | ユーザーがPTZステーションを編集する権限を持っているか(1)、ないか(0)を示します
is_view_preview_video       | 整数           | ユーザーがカメラからプレビュー画像を表示する権限を持っているか(1)、ないか(0)を示します
is_edit_camera_on_off       | 整数           | ユーザーがカメラをオンまたはオフにする権限を持っているか(1)、ないか(0)を示します
is_edit_camera_less_billing | 整数           | ユーザーが保存期間およびフルビデオの解像度以外のすべてのカメラ設定を編集する権限を持っているか(1)、ないか(0)を示します
is_edit_all_and_add         | 整数           | ブリッジとカメラの追加/編集/削除権限がユーザーに付与されているか(1)、ないか(0)を示します
is_edit_sharing             | 整数           | ユーザーがアカウント設定内の *共有* と *レスポンダー* タブの表示/編集する権限を持っているか(1)、ないか(0)を示します
is_edit_admin_users         | 整数           | ユーザーがサブアカウント内のすべてのユーザーを管理する権限を持っているか(1)、ないか(0)を示します
is_view_contract            | 整数           | ユーザーが契約の表示/再生ができるか(1)、ないか(0)を示します
is_ptz_live                 | 整数           | PTZカメラのプレビューまたはライブビデオを表示しているときにパン、チルト、ズーム、ステーションへのリコールを制御する権限があるか(1)、ないか(0)を示します
is_edit_users               | 整数           | サブアカウントの管理者でないユーザーを管理する権限がユーザーに付与されているか(1)、ないか(0)を示します
is_edit_motion_areas        | 整数           | カメラ設定内の *モーション* タブを表示および編集する権限があるか(1)、ないか(0)を示します
camera_access               | 配列           | デバイス単位で定義された配列の配列（スーパーユーザーまたはアカウントスーパーユーザーのみがこのフィールドを編集できます）。各サブアレイには2つの要素が含まれています。最初のフィールドはデバイスの一意な識別子で、2番目のフィールドはユーザーのアクセス権限を示す1文字以上の文字列です<br><br>例：<br> [`'1005f2ed'`,`'RWS'`] = ユーザはこのデバイスを表示、変更、削除できます<br><br>権限は次のとおりです：<br> `'R'` - ユーザーはこのカメラの画像とビデオの表示権限があります<br>`'W'` - ユーザーはこのカメラの変更と削除が可能です<br>`'S'` - このカメラをグループシェアで共有することができます
sms_phone                   | 文字列          | SMS通知に使用する電話番号
is_sms_include_picture      | 整数           | 画像つきアラート通知をMMS経由で sms_phone 番号に通知するか(1)、ないか(0)を示します
alternate_email             | 文字列          | 別のEメールアドレス
timezone                    | 文字列          | ユーザーのタイムゾーン。 可能な値：`'US/Pacific'` <br><br>Possible values: <br>`'US/Alaska'`, `'US/Arizona'`, `'US/Central'`, `'US/Eastern'`, `'US/Hawaii'`, `'America/Anchorage'`, `'UTC'` など
access_period               | 配列           | ユーザーがアカウントにアクセスできる期間が含まれます。配列の各要素には、ダッシュで区切られた3つのフィールドが含まれています。最初のフィールドは、月曜日を0とする週の曜日が含まれます。2番目の要素は開始時刻です。3番目の要素は終了時刻です。空の場合、ユーザーはアカウントへのアクセスに時間制限がありません。すべての時間はローカルタイムで表され、HHMMで表される24時間形式の時計を使用します
notify_period               | 配列           | ユーザーがアラート通知を受信する期間。配列の各要素には、ダッシュで区切られた3つのフィールドがあります。最初のフィールドは、月曜日を0とする週の曜日です。2番目の要素は開始時刻です。3番目の要素は終了時刻です。空の場合、ユーザーはアラート通知を受信しません <br><br>すべての時刻はローカルタイムで表され、HHMMとしてフォーマットされた24時間の時計を使用します
is_notify_enable            | 整数           | ユーザーに対して通知が有効か(1)無効か(0)を示します
notify_rule                 | 配列           | アラート通知ルール。各ルールは、`'Alert_Label-Notification_Method-Delay'` というフォームの中にダッシュで区切られた3つのフィールドを含みます <br><br>`'Alert_Label'` - ユーザが定義した名前 <br>`'Notification_Method'` - `'email'`、 `'SMS'` または `'GUI'` <br>`'Delay'` - 各通知の間隔時間（分）
language                    | 文字列          | 言語コード。現在、APIはGUIの表示言語として英語（en-us）と日本語（ja）のみをサポートしています。有効な言語コードを入力として受け取りますが、サポートされていない言語の場合は英語のテキストが表示されます

<aside class="warning">以前の設定がある場合、 'camera_access' はコマンド 'D' を使用し権限をクリアした後にのみ 'M' コマンドで変更できます</aside>

> JSON 応答

```json
{
    "id": "ca0ffa8c"
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ形式  | 詳細
--------- | --------- | -----------
id        | 文字列     | ユーザーの一意の識別子

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
404	| No user matching the unique identifier was found
200	| Request succeeded

<!--===================================================================-->
## ユーザーの削除
<!--===================================================================-->

ユーザーを削除します

> 要求

```shell
curl -X DELETE https://login.eagleeyenetworks.com/g/user -d "id=[USER_ID]" -G -H "content-type: application/json" -H "Authentication: [API_KEY]:" --cookie "auth_key=[AUTH_KEY]"
```

### HTTP 要求

`DELETE https://login.eagleeyenetworks.com/g/user`

パラメータ   | データ形式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**id**    | 文字列     | ユーザーの一意の識別子 | true

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
400	| Unexpected or non-identifiable arguments are supplied
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
404	| No user matching the unique identifier was found
200	| Request succeeded

<!--===================================================================-->
## ユーザーリストの取得
<!--===================================================================-->

現在のユーザーが利用可能なユーザーを表すそれぞれにサブ配列を持つ配列の配列を返します。

> 要求

```shell
curl --request GET https://login.eagleeyenetworks.com/g/user/list --cookie "auth_key=[AUTH_KEY]"
```

### HTTP Request

`GET https://login.eagleeyenetworks.com/g/user/list`

> JSON 応答

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
        "20180929154619.000"
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
        "20180716205645.000"
    ],
    [...],
    [...],
    [...]
]
```

### HTTP 応答 (属性の配列)

配列インデックス | 属性        | データ形式      | 詳細
---------   | ----------- | ---------     | -----------
0           | id          | 文字列         | Unique identifier of the user
1           | first_name  | 文字列         | First name of the user
2           | last_name   | 文字列         | Last name of the user
3           | email       | 文字列         | Email address of the user
4           | permissions | 配列[文字列]    | List of user permissions
5           | last_login  | 文字列         | EEN timestamp of the last login by the user. Format: YYYYMMDDHHMMSS.NNN

<aside class="success">モデル定義にはプロパティキーがありますが、これは単なる標準配列なので参照用です</aside>

### エラー状態コード

HTTP 状態コード    | 詳細
---------------- | -----------
401	| Unauthorized due to invalid session cookie
403	| Forbidden due to the user missing the necessary privileges
200	| Request succeeded
