# カメラ

<!--===================================================================-->
## 概要

デバイスサービスはアクセスを行うために、新しい論理デバイス（カメラまたはブリッジ）の作成と、論理及び物理デバイス間の関係性を成立させることを許可します。
Getメソッドは全てのユーザーに対し 'R'（読み取り）権限を有効にします。
Post及びDeleteメソッドはアカウントスーパーユーザーとユーザーに対し、選択されたカメラについての 'W'（書き込み）権限を有効にします。
Putメソッドはアカウントスーパーユーザーでのみ有効です。

新規カメラを追加する際には、名前と設定パラメータが必要です。
設定パラメータにはブリッジIDとカメラのGUIDが含まれます。

### カメラ設定の概要

カメラ設定システムは継承モデルを基本とします。
ユーザー設定はデバイスのデフォルト設定の最上位を "覆って" います。
ユーザー設定を消去すると、カメラ設定は自動的にEagle Eyeが用意したそのカメラのデフォルトの値に戻されます。

この作業は以下の内容を包括します:

* コードに組み込まれたデフォルトの設定、範囲と値は保証されたいかなる設定も、ソフトウェアの全ての機能についてサポートされます。これらの値はソフトウェアに実装される際に定義されます。
* オプションとして存在する "グローバル"設定ファイルは パッチまたは更新によってデフォルトの値及び範囲などは上書きまたは拡張されます。上記と同様に、これはアップグレードされる全てのブリッジに適用されます。これらはコードの変更を伴わない、異なるアップロード帯域幅やデフォルトのスケジュールのようなシステムポリシーについても変更を及ぼします。
* オプションとして make/model/version ファイル（make/model/version ドライバデプロイメントの一部）については、上記にまつわる設定の追加、調整が可能です。これらは特定の装置用にビルドされたドライバの感度やコーデックパラメータの最適化やカメラドライバの更新に使用されます。これは同じくカメラの特定の機能（音声の有効化）のアナウンスにも使用されます。
* 上記3点は各サポートされる機能ごとに、値や最大、最小値の定義などカメラの基本設定として結合して提供されます。
* ユーザーが設定（ユーザーが意図的に変更したもの）したものについては、上記の設定に対し動的に覆い、継承してカメラに設定されます。
* あらゆるスケジュールまたはトリガーは、実行中の設定によって最上位に覆われて変更されることがあります（アップロード帯域幅はユーザー設定とも、システムのデフォルトとも異なるスケジュールに変更されることがあります）が、スケジュールが"除去"されることでユーザー設定の値に戻ります。

この実装はユーザーがその設定の変更/管理によって "ピン留め" されていない場合、全てのシステムまたは make/model/version リリースのアップデートに追従します。つまり、ユーザーがそれら設定の変更/ピン留めをしていない限り、EENは操作パラメータを最適化させ、自動的に伝播させることが可能となります。さらに、ユーザーは特に オープン/クローズ制御型やチェックボックスによる項目- ユーザーによって "手動で" オープン設定にされた制御項目は問題なく動作しますが、クローズ設定はEENによってシステム全体で推奨設定に追随して設定されることに注意が必要です。最後に、全ての設定ではありませんが、特にユーザーによって変更された値は、"ユーザー"によってのみ管理が行われ、これらの追随から除外されます。

全ての設定セットは、多くののユーザーにとって必要であるよりも潜在的に大きいか、はるかに大きくなっています。ほとんどのユーザーが相互に必要とする設定 - "通常"設定は、それぞれのテーブルで管理されています。このリストは、リスト内の通常モードで表示されるコントロールのサブセットに含まれる全ての設定と"結合"されている必要があります。高度なモードでは全ての設定項目は基本設定と共に値のセットまたは削除が可能です。

このモデルに反する "ユーザー設定" オブジェクトは、デバイスによって必要最小限の介入を受ける一般オブジェクトです。既知の名前（例えばカメラベースまたはmmv設定）に合致する設定は利用されますが、全ての値は"ユーザー設定"フィールドに格納され、返されます。これはブリッジ/カメラが介入しない値を持つカメラの原則により、ユーザー インターフェイス要素をサポートするために利用されます。

### カメラ設定の読込 (GET device "camera_settings" property)

カメラ設定を取得すると、JSONオブジェクトは以下のJSON文字列として返されます:

  * “active_settings”: このデバイスを説明する全ての設定が、名前付きエンティティのセットとしてカプセル化されます。それぞれのエンティティは以下のオブジェクトを含みます
    * “v”: 基本設定のトップでフィルタされることによって影響を受けている設定についての、現在の値を指します
    * “max”: 許可される最大値
    * “min”: 許可される最小値
    * “d”: その設定フィールド用に定義されている形式における、デフォルトの値を指します
    * 注: max と min は数値フィールドのみで指定されます。セット用フィールド (例： preview_resolution) の場合は、minフィールドは値の配列として格納されます
    * 注: 補足的な説明用メンバーがこのオブジェクトに追加され続けていることがありますが、理解できない場合にフィールドを無効として実装する必要があります。
  * “active_filters”: 現在適用されているフィルタの配列です。リストは優先度順に並んでおり、先頭のエントリは最後のエントリによって上書きされます。それぞのエントリは文字列型式で、以下のうちの一つのフォーマットになります
    * “schedule_<名前>”: 名前の部分はスケジュール名になります
    * “user_user”: 定数、ユーザー設定が適用されている箇所を示します
    * “trigger_<名前>”: 名前の部分はトリガー名になります (例 “夜間”).
  * “user_settings”: 以下のフィールドのオブジェクト:
    * “settings”
      * 基本設定のサブセットであり、ユーザーが明示したアイテムを示します。
      * ユーザー設定は設定の中の「v」を含むものだけであり、素のオブジェクトです (例 “コントラス”: 0.1)
      * 殆どの設定は単一時間を更新する「原子」のエンティティです。値の設定、（明るさ）については明白ですが、複雑な設定（例アラート）について重要な点は、エントリ設定オブジェクトは新しい値で上書きされます。
      * 幾つかの設定（現在は「アラート」「関心領域」「アクティブなアラート」「アクティブな関心領域」）は蓄積型の設定です。設定は新しいメンバーが設定されるとトランザクションが追加され、そして設定が削除されるとメンバーを削除します。
    * “schedules”: 名前付きメンバーのセットであり、以下のいずれかのメンバーになります
      * “start”: 時間オブジェクト。スケジュールがいつオンになるかを示します。これは時間の中の移行点であり、アクティブ時間の区切りを説明するものではありません。次のようなスケジュールの場合、稼働時間内に実行されます - { “start”: { “hours”: 8, “wdays”: [1,2,3,4,5]}, “end”: {“hours”: 17, “wdays”: [1,2,3,4,5] }}.
      * “end”: 時間オブジェクト。スケジュールがいつ取り除かれるのかを示します
      * “priority”: 浮動小数点の値でスケジュールの優先順位を定義します。低い値ほど高優先です。全てのユーザー設定は10.0の優先度が与えられるため、10以下の優先度を持つスケジュールはユーザー設定を上書きし、10以下の場合は逆となります。同じ優先度のスケジュール設定は競合します。
      * “settings”: 上記の設定と一緒のメンバーを持つオブジェクト。スケジュールが有効な間、スケジュールが使用する新しい設定値を示します。蓄積型の設定のため、値は有効化されるとセット内に追加され、無効化時に削除されます。
    * 時間オブジェクトは以下の名前付きメンバーを持つオブジェクトであり、crontab引数に従ってゆるく作られます。それぞれの時間フィールドは現在時間と合致し、イベントは切り替えられます。
      * フィールド
          * seconds(0-59)(デフォルトは 0)
          * minutes (0-59) (デフォルトは 0)
          * hours (0-23) (デフォルトは 0)
          * mdays(1-31) (デフォルトは *)
          * wdays(1-7) (1=月曜日, 7=日曜日. デフォルトはなし。)
          * months(1-12) (デフォルトは *)
      * それぞれのフィールドは
          * 単一精度整数
          * 文字列 “*” は「全て」を指す
          * リストは整数
      * もし両方の “days” フィールドがセットされている場合、アクションは結合して実行されます

### カメラ設定の更新 (POST device "camera_settings_add" argument)

設定の更新/設定（例 "ユーザー"設定によってデフォルトの設定を上書きする）を行うには、以下のJSONオブジェクトを含むJSON文字列を送信する必要があります：

* “settings”: 基本設定値を上書きするメンバーを含むオプション オブジェクトです。素の値を指定します（基本設定の"v"フィールドを単純に置き換えます）。
* “schedules”: 1つ以上のメンバーを含むオプション オブジェクトで、それぞれのスケジュール オブジェクトは説明文字列を持ちます。同名のスケジュールはそれらのエンティティを新しい値で書き換えることに注意してください。

### カメラ設定の削除 (POST device "camera_settings_delete" argument)

設定の削除/設定解除（例 デフォルトの設定値に戻す）を行うには、以下のJSONオブジェクトを含むJSON文字列を送信する必要があります：

* “settings”: ユーザー設定から削除するメンバーを含むオプション オブジェクトです。値は無視されます。
* “schedules”: 1つ以上のメンバーを含むオプション オブジェクトで、それぞれのスケジュール オブジェクトは説明文字列を持ちます。メンバーの値は無視されます。

### 現在サポートしているカメラ設定

それぞれのカメラはメーカー/モデル/バージョンが異なるためいくつかのカメラでは全ての設定がサポートされるわけではありませんが、大部分のアプリケーションに関連する中心的なカメラ設定を以下に示します：

* "active_rois": このオブジェクトはどのROIが現在有効化を示します ("name" で示します; 以下の "rois" 設定を参照)
* "audio_enable": 音声が有効か無効かをブール (true/false) で示します
* "camera_on": カメラがオンまたはオフに設定されているかをブール整数 (1/0) で示します
* "motion_sensitivity": モーション検知の感度を0から1の間の浮動小数点で示します
* "motion_size_ratio": モーションを検知するオブジェクトの大きさを0から1の間の浮動小数点で示します
* "motion_boxes_metric_active": モーション検知時の矩形表示をブール整数で示します
* "preview_realtime_bandwidth": リアルタイムで転送されるプレビュー画像の最大転送幅を浮動小数点で示します
* "preview_transmit_mode": クラウドにプレビュー画像が転送れると、文字列で示します
* "preview_interval_ms": プレビュー動画間が何ミリ秒開いているかを整数で示します
* "preview_resolution": プレビュー画像の解像度を示す文字列です。この設定のオプションを表示する際には、表示用に"video_config.v.preview_quality_settings.<preview_resolution>" ("w" と "h")からのデータを使用する必要があります。この解像度の文字列は表示用に変換されます。
* "preview_quality": プレビュー画像の品質を文字列で示します
* "retention_days": クラウド内に最低限保管する期間の日数を整数で示します
* "rois": 拡張可能なオブジェクトで、"name"をキーとした複数のROIを含みます。それぞれのROIオブジェクトは以下のメンバーをサポートします:
    * “verts”: [[x,y],...], ポリゴンの頂点を順番に示します。座標は左上の角を0,0としたフルスクリーンのxとyに対応するよう0から1.0にスケールされます。辺の交差は予期せぬことが発生するため、避けて下さい。
    * "motion_noise_filter": メイン画面用。0.001以下の場合は適用されません
    * "motion_sensitivity": メイン画面用。0.001以下の場合は適用されません
    * "motion_hold_interval": メイン画面用。0.001以下の場合は適用されません
    * “priority”: 浮動小数点で（大きい方が高優先）、コントロール設定を上書きします。デフォルトは 0.0 です
    * “motion_threshold”: このROIでROIイベントを発生させる際にモーションとして認識するしきい値を、画面内の専有度のパーセント(浮動小数点で)で示します。
    * "name": GUIで表示するROIの名称で使用する文字列です。"name"はこのROIオブジェクトのキーと混同しないようにしてください。
    * "ignore_motion": このROIでモーションが無効化されるかをブール整数 (1/0) で表示します。これはmotion_sensitivityを ".001" と motion_noise_filterを ".001" に設定したことを示すGUI抽象概念として使用されます。
    * “roiid”: ROIイベントに(整数)idを付与します。もし0の場合、または設定されていない場合はイベントは作成されず、ROIベースのアラートも抑止されます。
    * “hold_off_ms”: イベントが作成される前のモーション継続時間(整数)ミリ秒で、motion_event_holdoff_msのデフォルトになります
    * “hold_on_ms”: ROIモーションイベント停止前のアイドル時間(整数)ミリ秒です。メイン設定のmotion_event_holdon_msのデフォルトになります。
* "scene_type": カメラが表示するシーン型式を文字列で示します
* "video_transmit_mode": クラウドに動画を転送する際の型式を文字列で示します
* "video_capture_mode": 動画が録画される際の型式を文字列で示します
* "video_bandwidth_factor": 動画のビットレートを整数で示します。この設定のオプションを表示する際、表示用に"video_config.v.video_quality_settings.<video_resolution>.quality.<video_quality>.kbps"からのデータを使用する必要があります。この設定は表示用に変換されます。
* "video_resolution": 動画の解像度を整数で示します。この設定のオプションを表示する際、表示用に"video_config.v.video_quality_settings.<video_resolution>" ("w" と "h") からのデータを使用する必要があります。この解像度文字列は表示用に変換されます。
* "video_quality": 動画の品質を文字列で示します
* "video_config": 対応可能な解像度毎のプレビューと動画の全ての構成パラメータが定義された読み取り専用のオブジェクトです。表示を行うための便利な "preview_resolution" "video_resolution" "video_bandwidth_factor" 設定/オプションの情報を提供します。

### 注目画像領域 (ROIs)

ROIは単純な多角形 - 連続したx,y座標で閉じられたオブジェクトで、 辺の交差は違反行為となり、予期せぬ結果を招きます - で定義されます。それぞれのROIは画面の一部分として描かれます。ROIは重ねることが可能で、感度設定は優先度（大き値が高優先）を考慮して決定されます。全ての重ねられたROIはモーション ブロック検知とROIモーション スパンでのトリガが可能です。

ROIは次のことが可能です

* DCT感度の調整とプロパティの検出 (エリア内のスタッフのの無視や、エリア内で動作しているスタッフの追跡)
* 特定のイベントの発生
* アラート発生/イベント処理後のオブジェクトの特徴付け (滞留、遷移、カウント)
* 領域内の現在の検出をオンにする。

ROIは “rois”: { “roiname”: roi,... } の中で設定されます。ROIは “active_rois”: { “roiname”: true,...} によって有効化または無効化でき、サポートスケジュール及びROIベースアラートによって簡単にオンまたはオフにすることができます。除去する場合には同じ属性を削除することでアクティブなROIを削除できます。

アラートのロジックのように、“rois” と “active_rois” は累積型設定です。殆どの設定のような全てのオブジェクトを置換する代わりに、現状のオブジェクトにオブジェクトが追加されます。同様にオブジェクトを削除すると親オブジェクトからは削除されますが、親オブジェクトはそのまま維持されます。両方共アクティブなESNデータストリームの更新により、自動的に起動されます。

ROIはそれぞれの範囲内の動作によって、イベントの生成と動画の録画を実行できます。これらのイベントはモーションイベント（全画面イベント）とは別の扱いです。それぞれのROIイベントはシンプルなスナップショット・イベントを持ち、スナップショットを即時補足するため、モーションイベントの物体追跡とは対極の最適化を行っています。ROIは小さく設定するほど、サマリイメージにとっては良い結果となります。

ROIイベントは ROMS 及び ROME eタグによって報告されます。

ROMS

* cameraid (guint32)
* eventid(guint32) - このイベントに対してユニーク
* roiid(guint32) - ROI定義によるROI ID
* videoid(guint32) - 関連する動画ID

ROME

* cameraid (guint32)
* eventid(guint32) - このイベントに対してユニーク

<!--===================================================================-->
## カメラのモデル

> カメラ モデル

```json
{
    "id": "1000f60d",
    "name": "Kitchen",
    "utcOffset": -18000,
    "timezone": "US/Central",
    "guid": "c6d11f36-9e63-11e1-a5b0-00408cdf9191",
    "permissions": "swr",
    "tags": [
        "austin",
        "kitchen"
    ],
    "bridges": {
        "100a9af6": "ATTD"
    },
    "settings": {
        "username": "onvif",
        "password": "securityCameraz",
        "bridge": "100a9af6",
        "roi_names": {},
        "alert_notifications": {},
        "alert_modes": {},
        "alert_levels": {},
        "notes": "",
        "longitude": -97.740714999999994,
        "latitude": 30.269064,
        "street_address": "717-799 Brazos Street, Austin, TX 78701, USA",
        "azimuth": 257.47226999999998,
        "range": 17.983694,
        "floor": 16,
        "share_email": "mcazares+videotest@eagleeyenetworks.com",
        "retention_days": 30,
        "cloud_retention_days": 30
    },
    "camera_info_status_code": 200,
    "camera_info": {
        "bridge": "bf5ce89d-8dbb-4eed-a2a8-60971e6d447e",
        "camera_state_version": 0,
        "intf": "Camera LAN",
        "camera_retention": 2592000000,
        "tagmap_status_state": 2,
        "camera_newest": "20141006190516.702",
        "camera_oldest": "20140906000000.000",
        "connect": "STRM",
        "uuid": "c6d11f36-9e63-11e1-a5b0-00408cdf9191",
        "service": "ATTD",
        "make": "AXIS",
        "ipaddr": "*169.254.12.141,10.143.236.65",
        "ts": "20141006182806.570",
        "version": "5.40.9.2",
        "admin_password": null,
        "esn": "1000f60d",
        "status": "1966143",
        "admin_user": null,
        "register_id": 0,
        "mac": "00:40:8C:DF:91:91",
        "proxy": "secondary",
        "bridgeid": "100a9af6",
        "now": "20141006210729.065",
        "class": "camera",
        "status_hex": "001e003f",
        "camera_now": "20141006210729.688",
        "camera_abs_newest": "20141006190516.702",
        "camera_abs_oldest": "20140906000000.000",
        "model": "AXIS M1054",
        "camtype": "ONVIF"
    },
    "camera_parameters_status_code": 200,
    "camera_parameters": {
        "active_settings": {
            "bandwidth_background": {
                "max": 10000000000.0,
                "min": -1000.0,
                "d": 0.0,
                "v": 0.0
            },
            "preview_jcmp_enable": {
                "max": 1,
                "min": 0,
                "d": 1,
                "v": 1
            },
            "bandwidth_recover": {
                "max": 10000000000.0,
                "min": 0.0,
                "d": 0.0,
                "v": 0.0
            },
            "video_transmit_mode": {
                "min": [
                    "always",
                    "event",
                    "background",
                    "on demand"
                ],
                "d": "background",
                "v": "background"
            },
            "preview_noise_limit_default": {
                "max": 16,
                "min": 2,
                "d": 16,
                "v": 16
            },
            "video_resolution": {
                "min": [
                    "cif",
                    "std",
                    "high"
                ],
                "d": "high",
                "v": "high"
            },
            "retention_days": {
                "max": 10000,
                "min": 1,
                "d": 14,
                "v": 30
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
            "motion_edge_expand_ratio": {
                "max": 0.98999999999999999,
                "min": 0.001,
                "d": 0.10000000000000001,
                "v": 0.10000000000000001
            },
            "preview_resolution": {
                "min": [
                    "cif",
                    "std",
                    "high"
                ],
                "d": "cif",
                "v": "std"
            },
            "display_features": {
                "max": 255,
                "min": 0,
                "d": 255,
                "v": 255
            },
            "motion_event_holdoff_ms": {
                "max": 1000,
                "min": 0,
                "d": 300,
                "v": 300
            },
            "retention_max_bytes": {
                "max": 1000000000000.0,
                "min": 0,
                "d": 0.0,
                "v": 0.0
            },
            "active_rois": {
                "d": {},
                "v": {}
            },
            "video_config": {
                "d": {
                    "preview_profile": "een_prvw",
                    "video_profile": "een_video",
                    "preview_quality_settings": {
                        "high": {
                            "h": 720,
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 1600,
                                    "fps": 4
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 1000,
                                    "fps": 4
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 800,
                                    "fps": 4
                                }
                            },
                            "w": 1280
                        },
                        "std": {
                            "h": "360",
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 500,
                                    "fps": 4
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 350,
                                    "fps": 4
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 250,
                                    "fps": 4
                                }
                            },
                            "w": 640
                        },
                        "cif": {
                            "h": "180",
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 200,
                                    "fps": 4
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 150,
                                    "fps": 4
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 100,
                                    "fps": 4
                                }
                            },
                            "w": 320
                        }
                    },
                    "video_quality_settings": {
                        "high": {
                            "h": 720,
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 2000,
                                    "fps": 30
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 1000,
                                    "fps": 15
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 500,
                                    "fps": 10
                                }
                            },
                            "w": 1280
                        },
                        "std": {
                            "h": "360",
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 600,
                                    "fps": 30
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 400,
                                    "fps": 15
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 200,
                                    "fps": 10
                                }
                            },
                            "w": 640
                        },
                        "cif": {
                            "h": "180",
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 300,
                                    "fps": 30
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 140,
                                    "fps": 15
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 70,
                                    "fps": 10
                                }
                            },
                            "w": 320
                        }
                    }
                },
                "v": {
                    "preview_profile": "een_prvw",
                    "video_profile": "een_video",
                    "preview_quality_settings": {
                        "high": {
                            "h": 720,
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 1600,
                                    "fps": 4
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 1000,
                                    "fps": 4
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 800,
                                    "fps": 4
                                }
                            },
                            "w": 1280
                        },
                        "std": {
                            "h": "360",
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 500,
                                    "fps": 4
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 350,
                                    "fps": 4
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 250,
                                    "fps": 4
                                }
                            },
                            "w": 640
                        },
                        "cif": {
                            "h": "180",
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 200,
                                    "fps": 4
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 150,
                                    "fps": 4
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 100,
                                    "fps": 4
                                }
                            },
                            "w": 320
                        }
                    },
                    "video_quality_settings": {
                        "high": {
                            "h": 720,
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 2000,
                                    "fps": 30
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 1000,
                                    "fps": 15
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 500,
                                    "fps": 10
                                }
                            },
                            "w": 1280
                        },
                        "std": {
                            "h": "360",
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 600,
                                    "fps": 30
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 400,
                                    "fps": 15
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 200,
                                    "fps": 10
                                }
                            },
                            "w": 640
                        },
                        "cif": {
                            "h": "180",
                            "quality": {
                                "high": {
                                    "q": 80,
                                    "kbps": 300,
                                    "fps": 30
                                },
                                "med": {
                                    "q": 60,
                                    "kbps": 140,
                                    "fps": 15
                                },
                                "low": {
                                    "q": 40,
                                    "kbps": 70,
                                    "fps": 10
                                }
                            },
                            "w": 320
                        }
                    }
                }
            },
            "video_capture_mode": {
                "min": [
                    "always",
                    "event"
                ],
                "d": "event",
                "v": "event"
            },
            "motion_noise_filter": {
                "max": 1.0,
                "min": 0.0,
                "d": 0.69999999999999996,
                "v": 0.69999999999999996
            },
            "motion_event_holdon_ms": {
                "max": 1000,
                "min": 0,
                "d": 300,
                "v": 300
            },
            "preview_realtime_bandwidth": {
                "max": 100000000.0,
                "min": 8000.0,
                "d": 50000.0,
                "v": 400000.0
            },
            "motion_snap_size_ratio": {
                "max": 0.98999999999999999,
                "min": 0.0001,
                "d": 0.001,
                "v": 0.001
            },
            "preview_history_depth_ms": {
                "max": 32000,
                "min": 1000,
                "d": 4000,
                "v": 4000
            },
            "encryption_type": {
                "max": 1,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "event_postroll_ms": {
                "max": 5000,
                "min": 0,
                "d": 1000,
                "v": 1000
            },
            "alerts": {
                "d": {},
                "v": {}
            },
            "preview_interval_ms": {
                "max": 16000,
                "min": 250,
                "d": 1000,
                "v": 1000
            },
            "motion_snap_age_threshold_ms": {
                "max": 2000,
                "min": 100,
                "d": 200,
                "v": 200
            },
            "preview_key_frame_hold_ms": {
                "max": 3600000,
                "min": 30000,
                "d": 1800000,
                "v": 1800000
            },
            "display_width": {
                "max": 64000,
                "min": 80,
                "d": 320,
                "v": 320
            },
            "preview_min_gop_ms": {
                "max": 180000,
                "min": 1000,
                "d": 4000,
                "v": 4000
            },
            "preview_first_frame_delta_target": {
                "max": 0.98999999999999999,
                "min": 0.01,
                "d": 0.25,
                "v": 0.25
            },
            "motion_logmask": {
                "max": 7,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "preview_log_mask": {
                "max": 15,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "local_retention_days": {
                "max": -1,
                "min": -1,
                "d": -1,
                "v": -1
            },
            "preview_noise_limit_min": {
                "max": 16,
                "min": 2,
                "d": 3,
                "v": 3
            },
            "motion_hold_interval": {
                "max": 120.0,
                "min": 0.0,
                "d": 5.0,
                "v": 5.0
            },
            "stream_stats_present_only": {
                "max": 1,
                "min": 0,
                "d": 1,
                "v": 1
            },
            "active_alerts": {
                "d": {},
                "v": {}
            },
            "motion_weights": {
                "max": 64,
                "length": 8,
                "min": 1,
                "d": [
                    8,
                    4,
                    2,
                    1,
                    1,
                    1,
                    1,
                    1
                ],
                "v": [
                    "8",
                    "4",
                    "2",
                    "1",
                    "1",
                    "1",
                    "1",
                    "1"
                ]
            },
            "preview_min_limit_change_ms": {
                "max": 500000,
                "min": 2000,
                "d": 10000,
                "v": 10000
            },
            "preview_transmit_mode": {
                "min": [
                    "always",
                    "event",
                    "background",
                    "on demand"
                ],
                "d": "always",
                "v": "always"
            },
            "bandwidth_demand": {
                "max": 10000000000.0,
                "min": 0.0,
                "d": 0.0,
                "v": 0.0
            },
            "audio_enable": {
                "d": false,
                "v": true
            },
            "video_bandwidth_factor": {
                "max": 64,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "shaping_mode": {
                "max": 127,
                "min": 0,
                "d": 31,
                "v": 31
            },
            "display_name": {
                "d": "none",
                "v": "none"
            },
            "display_height": {
                "max": 64000,
                "min": 80,
                "d": 180,
                "v": 180
            },
            "preview_compress_keyframes": {
                "max": 1,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "motion_snap_push_min_delay_ms": {
                "max": 5000,
                "min": 1000,
                "d": 2000,
                "v": 2000
            },
            "motion_size_ratio": {
                "max": 0.98999999999999999,
                "min": 0.0001,
                "d": 0.001,
                "v": 0.001
            },
            "video_quality": {
                "min": [
                    "low",
                    "med",
                    "high"
                ],
                "d": "med",
                "v": "med"
            },
            "video_source_flip": {
                "d": false,
                "v": false
            },
            "motion_sensitivity": {
                "max": 1.0,
                "min": 0.0,
                "d": 0.80000000000000004,
                "v": 0.80000000000000004
            },
            "motion_size_metric_active": {
                "max": 1,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "camera_on": {
                "max": 1,
                "min": 0,
                "d": 1,
                "v": 1
            },
            "motion_snap_excellent_hold_ms": {
                "max": 5000,
                "min": 100,
                "d": 1000,
                "v": 1000
            },
            "cloud_retention_days": {
                "max": 365,
                "min": 1,
                "d": 14,
                "v": 30
            },
            "video_source_bounds": {
                "max": [
                    1440,
                    900,
                    1440,
                    900
                ],
                "min": [
                    0,
                    0,
                    0,
                    0
                ],
                "d": [
                    0,
                    0,
                    1440,
                    900
                ],
                "v": [
                    0,
                    0,
                    1440,
                    900
                ]
            },
            "rois": {
                "d": {},
                "v": {}
            },
            "preview_max_gop_ms": {
                "max": 180000,
                "min": 5000,
                "d": 30000,
                "v": 30000
            },
            "retention_priority": {
                "max": 10000,
                "min": 1,
                "d": 100,
                "v": 100
            },
            "preview_noise_change_threshold": {
                "max": 64,
                "min": 1,
                "d": 2,
                "v": 2
            },
            "preview_quality": {
                "min": [
                    "low",
                    "med",
                    "high"
                ],
                "d": "med",
                "v": "med"
            },
            "motion_expand_ratio": {
                "max": 0.98999999999999999,
                "min": 0.001,
                "d": 0.10000000000000001,
                "v": 0.10000000000000001
            },
            "motion_boxes_metric_active": {
                "max": 1,
                "min": 0,
                "d": 0,
                "v": 0
            },
            "event_preroll_ms": {
                "max": 5000,
                "min": 0,
                "d": 1000,
                "v": 1000
            },
            "preview_queue_ms": {
                "max": 20000,
                "min": 1000,
                "d": 10000,
                "v": 10000
            }
        },
        "active_filters": [
            "user_user"
        ],
        "user_settings": {
            "versions": {},
            "settings": {
                "preview_realtime_bandwidth": 400000,
                "retention_days": 30,
                "cloud_retention_days": 30,
                "preview_resolution": "std",
                "audio_enable": true,
                "motion_weights": [
                    "8",
                    "4",
                    "2",
                    "1",
                    "1",
                    "1",
                    "1",
                    "1"
                ]
            },
            "schedules": {}
        }
    }
}
```

### デバイスの属性

パラメータ                     | データ型式         | 詳細       
---------                     | ---------------   | -----------
id                            | 文字列            | デバイスの一意な識別子
name                          | 文字列            | デバイスの名前
utcOffset                     | 整数               | デバイスが導入されている場所のタイムゾーンとUTCとの符号付きUTCオフセット秒
timezone                      | 文字列            | サポートされるタイムゾーン: これがブリッジの場合、デフォルトはアカウントのタイムゾーンになります。これがカメラの場合、デフォルトはブリッジのタイムゾーンになります。それ以外では、デフォルトは US/Pacific になります。 <br><br>数値付きリスト: US/Alaska, US/Arizona, US/Central, US/Pacific, US/Eastern, US/Mountain, US/Hawaii, UTC
guid                          | 文字列            | デバイスのGUIDまたはその他の物理識別子
permissions                   | 文字列            | 一文字またはそれ以上の文字列。それぞれの文字は権限を表します。権限は次のものを含みます: 'R' - ユーザーはこのカメラに対して画像及び動画の表示アクセスを行えます。 'A' - ユーザーはこのカメラに対して管理権限を持ちます。 'S' - ユーザーはこのカメラに対してグループ共有内で共有できます。 注: グループ内の全てのカメラが 's' 権限を持っていない場合は共有できません
tags                          | 配列[文字列]     | 文字列の配列で、それぞれ "tag" を表します。
bridges                       | [DeviceBridges](#devicebridges-attributes)     | このデバイスが接続されているブリッジ
settings                      | [DeviceSettings](#devicesettings-attributes)    | その他の設定
camera_parameters             | オブジェクト            | カメラのパラメータ/設定(詳細は概要を参照)を含むJSONオブジェクト。もしカメラのパラメータが様々な理由(カメラとの通信が途絶するなど)により取得できない場合にはこの項目は空白となり、camera_parameters_status_code は404となります。
camera_parameters_status_code | 整数               | 200 はcamera_parametersが取得できたことを表します。404 はcamera_parametersが取得できなかったことを表します。
camera_info                   | [DeviceCameraInfo](#devicecamerainfo-attributes)  | カメラ関連情報で、カメラの場合のみ付加されます。
camera_info_status_code       | 整数               | 200 はcamera_parametersが取得できたことを表します。404 はcamera_parametersが取得できなかったことを表します。

### DeviceSettingsの属性

パラメータ           | データ型式                         | 詳細       
---------           | ---------------                   | -----------
username            | 文字列                            | カメラにログインするためのユーザー名。カメラのみに付与されます。
password            | 文字列                            | カメラにログインするためのパスワード。カメラのみに付与されます。
bridge              | 文字列                            | カメラが接続されているブリッジのデバイスID。カメラのみに付与されます。カメラにPUTする際に必須です。
guid                | 文字列                            | 物理デバイスのGUID。カメラのみに付与されます。カメラにPUTする際に必須です。
roi_names           | [DeviceSettingsRoiNames](#devicesettingsroinames-attributes) | ROI IDをキーとしたROI名。カメラのみに付与されます。
alert_notifications | [DeviceSettingsAlertNotifications](#devicesettingsalertnotifications-attributes) | ROI IDをキーとしたユーザーIDの配列。カメラのみに付与されます。
alert_modes         | [DeviceSettingsAlertModes](#devicesettingsalertmodes-attributes) | ROI IDをキーとしたアラート モードの配列。カメラのみに付与されます。
alert_levels        | [DeviceSettingsAlertLevels](#devicesettingsalertlevels-attributes) | ROI IDをキーとしたアラート レベルの配列。カメラのみに付与されます。
notes               | 文字列                            | メモ
latitude            | 浮動小数点                             | カメラ設置位置の緯度。
longitude           | 浮動小数点                             | カメラ設置位置の経度。
street_address      | 文字列                            | カメラ設置位置の住所。
azimuth             | 浮動小数点                             | カメラ中心の方向。値は 0.0-360.0 を取り、北は 0.0 となります。
range               | 整数                               | カメラの有効な「表示」距離をフィートで表します。
floor               | 整数                               | 建物が複数階の場合、回数を表します。
share_email         | 文字列                            | このデバイスが共有されているeメールのカンマ区切りリスト
local_retention_days| json                              | 総保存期間のJSONオブジェクト         例 ``{"max": 10000,"min": 1,"d": 14,"v": 14}``
cloud_retention_days| json                              | クラウド保存期間のJSONオブジェクト  例 ``{"max": 10000,"min": 1,"d": 14,"v": 14}``
bridge_retention_days| json                             | オンプレミス保存期間のJSONオブジェクト 例 ``{"max": 10000,"min": 1,"d": 14,"v": 14}``
* 注 local_retention_days と cloud_retention_days は **CMVR** モードでは無効です

### DeviceCameraInfoの属性

パラメータ           | データ型式         | 詳細       
---------           | ---------------   | -----------
bridge              | 文字列            | カメラが接続されているブリッジのデバイスID
camera_retention    | 整数               | 保存期間のミリ秒表記
camera_newest       | 文字列            | EENタイムスタンプフォーマット(YYYYMMDDHHMMSS.NNN)による、有効な最新イベントのタイムスタンプ。
camera_oldest       | 文字列            | EENタイムスタンプフォーマット(YYYYMMDDHHMMSS.NNN)による、有効な最も古いイベントのタイムスタンプ。
camera_info_version | 整数               | カメラ情報のバージョン
connect             | 文字列            | カメラ接続状態
camera_min_time     | 文字列            | EENタイムスタンプフォーマット(YYYYMMDDHHMMSS.NNN)による、有効な最小のタイムスタンプ。
uuid                | 文字列            | UUID 文字列
service             | 文字列            | サービス状態
make                | 文字列            | デバイスの製造元
ipaddr              | 文字列            | デバイスに割り当てられたIPアドレスで、カンマ区切りで保存されます。使用中の一つの先頭にアスタリスク * が付与されます。
ts                  | 文字列            | EENタイムスタンプフォーマット(YYYYMMDDHHMMSS.NNN)によるタイムスタンプ。
version             | 文字列            | ファームウェアバージョン
[status](#status-bitmask) | 文字列            | 状態のビットマスク
mac                 | 文字列            | MACアドレス
proxy               | 文字列            | プロキシ
bridgeid            | 文字列            | このデバイスが接続されているブリッジのデバイス
now                 | 文字列            | EENタイムスタンプフォーマット(YYYYMMDDHHMMSS.NNN)による現在のタイムスタンプ。
class               | 文字列            | カメラ、ブリッジまたはその他。
camera_now          | 文字列            | EENタイムスタンプフォーマット(YYYYMMDDHHMMSS.NNN)による現在のカメラのタイムスタンプ。
camera_abs_newest   | 文字列            | EENタイムスタンプフォーマット(YYYYMMDDHHMMSS.NNN)による、有効な最新イベントのタイムスタンプ。
camera_abs_oldest   | 文字列            | EENタイムスタンプフォーマット(YYYYMMDDHHMMSS.NNN)による、有効な最も古いイベントのタイムスタンプ。
model               | 文字列            | デバイスのモデル
esn                 | 文字列            | ESN ID
admin_user          | 文字列            | Web ユーザー名
admin_password      | 文字列            | Web パスワード

### DeviceSettingsRoiNamesの属性

パラメータ   | データ型式         | 詳細       
---------   | ---------------   | -----------
roi_id      | 文字列            | ROI IDをキーとしたオブジェクトと名前の値

### DeviceSettingsAlertNotificationsの属性

パラメータ   | データ型式         | 詳細       
---------   | ---------------   | -----------
roi_id      | 配列[文字列]     | ROI IDをキーとしたオブジェクトとユーザーIDの配列値

### DeviceSettingsAlertModesの属性

パラメータ   | データ型式         | 詳細       
---------   | ---------------   | -----------
roi_id      | 配列[文字列]     | ROI IDをキーとしたオブジェクトとアラート モードの配列値

### DeviceSettingsAlertLevelsの属性

パラメータ   | データ型式         | 詳細       
---------   | ---------------   | -----------
roi_id      | 配列[文字列]     | ROI IDをキーとしたオブジェクトとアラート レベルの配列値

### DeviceBridgesの属性

パラメータ   | データ型式         | 詳細       
---------   | ---------------   | -----------
device_id   | 文字列            | ROI IDをキーとしたオブジェクトと、ブリッジ上のカメラのサービス状態の値

<!--===================================================================-->
## カメラの取得

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/g/device -d "A=[AUTH_KEY]&id=[CAMERA_ID]"
```

カメラ オブジェクトをIDで返します

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/device`

パラメータ     | データ型式   | 詳細
---------     | ----------- | ----------- 
**id**        | 文字列      | カメラID

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました

<!--===================================================================-->
## ブリッジにカメラを追加する

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X PUT -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/device -d '{"name":"[NAME]","timezone":[TIMEZONE],"settings":{"bridge":"[BRIDGE_ID]","guid":"[CAMERA_GUID]","username":"","password":""}}'
```

> JSON応答

```json
{
  "id": "100c339a"
}
```

非割当カメラをブリッジに追加します

### HTTP要求

`PUT https://login.eagleeyenetworks.com/g/device`

パラメータ     | データ型式     | 詳細        | 必須？
---------     | -----------   | ----------- | -----------
**name**      | 文字列        | カメラの名前 | true
**settings**  | [DeviceSettings](#devicesettings-attributes)          | その他の設定 | true
timezone      | 文字列        | 指定しない場合、カメラが接続するブリッジのタイムゾーンに設定されます
tags          | 配列[文字列] | 文字列の配列で、それぞれの文字列は "tag" を表します

### 応答JSON属性

パラメータ       | データ型式   | 詳細       
---------       | ----------- | -----------
id              | 文字列      | デバイスの一意な識別子

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | 接続IDに合致するデバイスが見つからないか、GUIDが見つかりません
409 | 接続IDまたはGUIDは既にアカウントで使用されています
410 | ブリッジからカメラに通信できません
415 | 指定されたGUIDに割り当てられたデバイスはサポートされていません

<!--===================================================================-->
## カメラの更新

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X POST -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/device -d '{"id": "[CAMERA_ID], "name": "[NAME]"}'
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
**id**                    | 文字列        | カメラID     | true
name                      | 文字列        | カメラの名前
timezone                  | 文字列       | 指定しない場合、カメラが接続するブリッジのタイムゾーンに設定されます
tags                      | 配列[文字列] | 文字列の配列で、それぞれの文字列は "tag" を表します
settings                  | json          | その他の設定
camera_parameters_add     | json          | 追加または更新するカメラのパラメータ/設定のJSONオブジェクト
camera_parameters_delete  | json          | 削除するカメラのパラメータ/設定のJSONオブジェクト


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
404 | IDに合致するデバイスが見つかりません
463 | 追加/削除するカメラ設定の対象となるカメラと通信できません。サポートに連絡してください

<!--===================================================================-->
## カメラの削除

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X DELETE -v -H "Authentication: [API_KEY]:" -H "content-type: application/json" https://login.eagleeyenetworks.com/g/device -d "id=[CAMERA_ID]" -G
```

### HTTP要求

`DELETE https://login.eagleeyenetworks.com/g/device`

パラメータ     | データ型式   | 詳細
---------     | ----------- | -----------
**id**        | 文字列      | カメラID

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
404 | IDに合致するデバイスが見つかりません
463 | カメラまたはブリッジと通信できません。サポートに連絡してください

<!--===================================================================-->
## カメラリストの取得

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
    [...],
    [...],
    [...]
]
```

配列中の配列が返された場合、それぞれの子配列はユーザーで有効なデバイスを表します。'service_status' 属性は 'ATTD' または 'IGND' が設定されます。もしservice_statusが 'ATTD' と表示された場合には、カメラはブリッジに割り当て済みとなります。もしservice_statusが 'IGND' と表示された場合には、カメラはどのブリッジからも未割り当てとなり、割当可能となります。上記のListDevice モデル定義はプロパティ キーを持ちますが、これは参照のみを目的とした標準的な配列であることに注意してください。

### HTTP要求

`GET https://login.eagleeyenetworks.com/g/device/list`

パラメータ | データ型式   | 詳細        
--------- | ----------- | -----------           
e         | 文字列      | カメラID
n         | 文字列      | カメラの名前
t         | 文字列      | デバイス形式
s         | 文字列      | デバイスのサービス状態

### 応答: カメラモデル

Array Index | Attribute           | データ型式             | 詳細        
---------   | -----------         | -----------           | -----------           
0           | account_id          | 文字列                | デバイスのアカウントの一意な識別子
1           | id                  | 文字列                | デバイスの一意な識別子
2           | name                | 文字列                | デバイスの名前
3           | type                | 文字列, 数値付きリスト          | デバイスの形式 <br><br>数値付きリスト: camera, bridge
4           | bridges             | 配列[配列[文字列]]  | これは文字列配列の配列で、それぞれの配列はカメラから認識できるブリッジを表します。文字列配列の最初の要素はブリッジのESNを表します。2個目の要素は状態を表します。
5           | service_status      | 文字列, 数値付きリスト          | デバイスのサービス状態。ATTD = カメラはブリッジに割り当て済み。 IGND = カメラは全てのブリッジから未割り当てでブリッジに割当が可能。 <br><br>数値付きリスト: ATTD, IGND
6           | permissions         | 文字列                | 0以上の文字を持つ文字列。それぞれの文字は現在のユーザーのデバイスへの権限の定義を表します。権限は次の内容を含みます: 'R' - ユーザーはこのデバイスの表示が可能。 'W' - ユーザーはこのデバイスの変更、削除が可能。 'S' - ユーザーはこのデバイスの共有が可能。
7           | tags                | 配列[文字列]         | タグ
8           | guid                | 文字列                | GUID
9           | serial_number       | 文字列                | シリアル番号
10          | [device_status](#status-bitmask) | 整数                   | ビットマスクによるデバイス状態
11          | timezone            | 文字列                | タイムゾーン
12          | timezone_utc_offset | 整数                   | UTCとタイムゾーンの符号付き整数によるオフセット。“-25200”であれば、UTCから-7時間と解釈される。
13          | is_unsupported      | 整数                   | カメラがサポートされてない(1)か、されている(0)かを示します。
14          | ip_address          | 文字列                | デバイスのIPアドレス
15          | is_shared           | 整数                   | カメラが共有済み(1)か、されていない(0)かを示します。
16          | owner_account_name  | 文字列                | デバイスを所有するアカウントの名前を表します。これは共有済みカメラのみに付与され、このカメラが他のアカウントに所有されるまで表示されます。
17          | is_upnp             | ブール               | カメラがUPNPデバイスかを示します。このプロパティはその他全APIの 'is_*'と異なり、通常は整数(0または1)で表されます。現在このプロパティはアカウントに割り当てられていない場合にのみ付与され、ONVIFまたはUPNP経由でのみ検出されます。
18          | video_input         | 文字列                | アナログカメラのみで使用され、カメラの入力チャンネルを示します。
19          | video_status        | 文字列                | アナログカメラのみで使用され、カメラの動画入力状態を示します。

### エラー状態コード

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | 要求は成功しました
400 | 予期せぬまたは識別不能な引数が指定されました
401 | 無効なセッションCookieにより認可されませんでした
403 | ユーザーに必要な権限がないため拒否されました
