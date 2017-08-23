# ポーリング

<!--===================================================================-->
## 概要
<!--===================================================================-->

ポーリング サービスは、アプリケーションがEagle Eye Networksからのイベントまたはスパンの通知を受信するためのメカニズムを提供します。これらのエンティティはリソース別にグループ分けされています

リソース:

  - pre - プレビュー画像のタイムスタンプ。 後でタイムスタンプを使用して実際のプレビュー画像を取得することができます
  - thumb - サムネイル画像のタイムスタンプ。 タイムスタンプは、後で実際のサムネイル画像を検索するために使用することがでます
  - video - ビデオ イベントの開始と終了のタイムスタンプ
  - [status](#status-bitmask) - ブリッジまたはカメラの状態を定義するビットマスク
  - [event](#event-objects) - フル イベント情報

イベント リソース:

  - Camera または device (カメラ アラート、録画の開始と停止など)
  - System (メンテナンス、サーバー変更など)
  - Account (その他のユーザー変更、アカウント アラート、レイアウト変更など)

カメラとデバイスのイベントには次のものを含みます： オン、オフ、オンライン、オフライン、現在の録画、現在のモーション検出、スケジュールの開始/停止イベント、PTZ制御など。

<aside class="success">このサービスは継続的に拡張されます</aside>

ポール(またはポーリング)はサービス内で発生し、合致したイベントをいつでも更新するステートフルな要求です。初期化のポール要求は、追跡するリソースを示すJSONでフォーマットされた文書をPOST (デフォルトは [WebSocket](#websocket-polling) に GET で要求します) で要求することで行います。動画、プレビュー、サムネイルのようなリソースは、それぞれのイベントを呼び出し元のAPIに自動的に登録を行います。しかし `'event'` 形式のリソースは、API呼び出し元に対してどのようなイベントをリッスンするか要求します

それぞのオブジェクトは、モニターするID要素とリソースの形式から成ります。POSTトランザクションは、全ての要求されたリソースの現在のタイムスタンプが即時に返されたJSONフォーマット文書を受け取ります。応答にはクッキーも含まれ、これはGETトランザクション経由で変化点が示されたリソースを追跡するために使用されます

### 応答リソース形式

各リソース形式は、特定のオブジェクト形式で応答します：

形式                       | 応答              | 詳細
----                      | --------         | -----------
pre                       | prets            | 最新のプレビュー画像のタイムスタンプ
thumb                     | thumbts          | 最新のサムネイル画像のタイムスタンプ
video                     | [startts, endts] | 動画セグメントの開始と終了タイムスタンプのリスト。開始から終了までキーフレーム毎に更新が行われる
[status](#status-bitmask) | bitmask          | 状態を定義した数値のビットマスク。ビット位置は状態を定義する。それぞれのビットは、以下の表のとおり定義される
[event](#event-objects)   | object           | イベントはキーと値のペアであり、キーは四文字 (four cc)、そしてイベント構造は特定イベントの実際のメタデータで構成される。有効なイベントは以下の表に表される

## 状態のビットマスク

HEX値      | 状態
--------- | ------
0x000001  | カメラ オンライン  <small>**(廃止予定)**</small>
0x000002  | ストリーム割り当て済み (カメラはブリッジと通信中)  <small>**(廃止予定)**</small>
0x000004  | カメラ オン (ユーザー設定) <small>**(廃止予定)**</small>
0x000008  | カメラ録画中 <small>**(廃止予定)**</small>
0x000010  | カメラはプレビューを送信中
0x000020  | カメラ検出中 (ブリッジからカメラが見えている)
0x000040  | カメラは未サポート
0x000080  | カメラは構成中 (ブリッジはカメラを構成中)
0x000100  | カメラはONVIFパスワードが必要
0x000200  | カメラは有効だがブリッジに接続されていない
0x000400  | *内部ステータス*
0x000800  | カメラ エラー
0x001000  | *内部ステータス*
0x002000  | *内部ステータス*
0x004000  | *予約済み*
0x008000  | *予約済み*
0x010000  | 不正な状態 (不明な状態)
0x020000  | カメラ オン (ユーザーによる設定)
0x040000  | カメラは動画をストリーミング中
0x080000  | カメラは録画中
0x100000  | カメラ オンライン

この状態のビットマスクは以下のロジックに従い、

<aside class="notice">カメラの高レベル/全体的な状態がどうなっているか決定されます：</aside>

IF "Camera On" (**bit 17**)==0 THEN "Off" (オレンジの禁止アイコン)
<br>ELSE IF "Registered" (**bit 20**)==0 THEN "Internet Offline" (赤の！アイコン)
<br>ELSE IF "Streaming" (**bit 18**)==1 THEN "Online" (緑のチェック アイコン)
<br>ELSE IF "Password" (**bit 8**)==1 THEN "Password Needed" (実体は “Offline”) (赤の鍵ロック アイコン)
<br>ELSE "Offline" (赤の×アイコン)

<aside class="notice">録画状態は以下のロジックを使用します：</aside>

IF "Recording" (**bit 19**) THEN Recording (緑の●アイコン))
IF "Invalid" (**bit 16**)==1 THEN no status change (どんな状態であっても直前の状態ビットをセット)

<!--===================================================================-->
## イベント オブジェクト
<!--===================================================================-->

> イベント オブジェクト

```json
{
    "status_code": 200,
    "message": "OK",
    "data": {
        "100e1e23": {
            "event": {
                "PRSS": {
                    "status": 31,
                    "format": 1,
                    "frame_delay": 1000,
                    "timestamp": "20180425100000.000",
                    "cameraid": "10087ff5",
                    "flags": 0,
                    "duration": 3600000,
                    "previewid": 1493114470
                }
            }
        },
        "<object_id>": {...},
        "<object_id>": {...},
        "<object_id>": {...}
    }
}
```

<aside class="notice">各イベントタイプは、EENフォーマットのタイムスタンプで返されます： YYYYMMDDhhmmss.xxx</aside>

**注:** '&#9702;' とマークされたイベントオブジェクトの説明については、イベントに関する追加情報のために拡張することが可能です

Four&nbsp;CC | 詳細                                                             | 戻り パラメータ
------------ | -----------                                                     | -------------------
VRES	| 動画開始イベント                                                           | cameraid, videoid, format, status
VREE	| 動画終了イベント                                                           | cameraid, videoid, videosize, format, status
VRKF	| 動画キーフレーム イベント                                                    | cameraid, videoid, file_offset, format
EAES	| <details><summary>常時動画録画開始イベント&nbsp;&#9702;</summary><p><br>バックグラウンドで「常時」動画録画イベントが開始されました</br></p></details> | cameraid, videoid, eventid
EAEE	| <details><summary>常時動画録画終了イベント&nbsp;&#9702;</summary><p><br>バックグラウンドで「常時」動画録画イベントが終了しました</br></p></details> | cameraid, eventid
AEDO	| 動画ダウンロード イベント                                                    | cameraid, status, source_userid, source_accountid, resource_type, deviceid, endtime
EVVS	| <details><summary>動画スワップ イベント&nbsp;&#9702;</summary><p><br>このイベントは次の2つの異なるビデオIDにまたがります： `'eventid'` 、 `'videoid'`（新しいスワップインID）</br></p></details> | cameraid, videoid, eventid
PRTH	| サムネイル イベント                                                       　| cameraid, previewid, eventid, file_offset, frame_size
PRFR	| <details><summary>プレビュー イベント&nbsp;&#9702;</summary><p><br>プレビューフレームが録画されたことを示します</br></p></details> | cameraid, previewid, file_offset, frame_size
PRFB	| プレビュー支援イベント                                                  　　　| cameraid, previewid, file_offset, frame_size
EMES	| モーション開始イベント                                                      | cameraid, videoid, eventid
EMEE	| モーション終了イベント                                                      | cameraid, eventid
EMEU	| <details><summary>モーション更新イベント&nbsp;&#9702;</summary><p><br>モーションイベントのハートビート <br>(10秒間隔)</br></p></details> | cameraid, videoid, eventid
MRBX	| <details><summary>モーション ボックス イベント&nbsp;&#9702;</summary><p><br>指定された領域でモーションが発生しました（座標は右上隅から 0xffff の小数部にあります）</br></p></details> | cameraid
MRSZ	| <details><summary>モーションサイズ レポートイベント&nbsp;&#9702;</summary><p><br>画面上でのモーション数と各アクティブROI（0xffff 以上の比率が画面の割合で表示されます）を示します。 <br>フラグ `'0x1'` は  - 定義済みのしきい値を超えるモーションを指します</br></p></details> | cameraid, flags, motion
ALMS	| <details><summary>モーションアラート 開始イベント&nbsp;&#9702;</summary><p><br>モーションイベントが発生しました（示されたアラートに関連しています）</br></p></details> | cameraid, eventid, alertid, alertmotionid
ALME	| <details><summary>モーションアラート 終了イベント&nbsp;&#9702;</summary><p><br>モーションイベントが終了しました（示されたアラートに関連しています）</br></p></details> | cameraid, alertmotionid
ROMS	| <details><summary>ROI モーション開始イベント&nbsp;&#9702;</summary><p><br>関心領域モーション開始イベント</br></p></details> | cameraid, roiid, videoid, eventid
ROME	| <details><summary>ROI モーション終了イベント&nbsp;&#9702;</summary><p><br>関心領域モーション終了イベント</br></p></details> | cameraid, eventid
ROMU	| <details><summary>ROI モーション更新イベント&nbsp;&#9702;</summary><p><br>ROIモーションイベントのハートビート</br></p></details> | cameraid, roiid, videoid, eventid
ALRS	| <details><summary>ROI アラート開始イベント&nbsp;&#9702;</summary><p><br>アラートにリンクしたROIモーションイベントが開始されました</br></p></details> | cameraid, eventid, alertid, alertroiid
ALRE	| <details><summary>ROI アラート終了イベント&nbsp;&#9702;</summary><p><br>アラートにリンクしたROIモーションイベントが終了しました</br></p></details> | cameraid, alertroiid
AEDA	| デバイスアラート イベント                                                    | cameraid, status, deviceid, source_userid, source_accountid, values
AEDN	| デバイスアラート通知イベント                                                  | cameraid, status, target_deviceid, triggerid, starttime, endtime, target_userid, json
AEDC	| <details><summary>デバイスイベントの作成&nbsp;&#9702;</summary><p><br>`'cameraid'` はESN（電子シリアル番号）として理解されます。アカウント、ブリッジ、カメラまたはユーザーを表すことができます</br></p></details> | cameraid, status, deviceid, source_userid, source_accountid
AEDD	| <details><summary>デバイスイベントの削除&nbsp;&#9702;</summary><p><br>`'cameraid'` はESN（電子シリアル番号）として理解されます。アカウント、ブリッジ、カメラまたはユーザーを表すことができます</br></p></details> | cameraid, status, deviceid, source_userid, source_accountid
AEDH	| <details><summary>デバイス変更イベント&nbsp;&#9702;</summary><p><br>`'cameraid'` はESN（電子シリアル番号）として理解されます。アカウント、ブリッジ、カメラまたはユーザーを表すことができます</br></p></details> | cameraid, status, deviceid, source_userid, source_accountid, values
ESES	| <details><summary>ストリーム開始イベント&nbsp;&#9702;</summary><p><br>ユーザー要求のストリームイベントが開始されました</br></p></details> | cameraid, videoid, eventid
ESEE	| <details><summary>ストリーム終了イベント&nbsp;&#9702;</summary><p><br>ユーザー要求のストリームイベントが終了しました</br></p></details> | cameraid, eventid
SBWS	| <details><summary>ストリーム帯域サンプルイベント&nbsp;&#9702;</summary><p><br>有効にした場合、カメラからの最後のN秒間のストリームで帯域幅のサンプリングを行います</br></p></details> | cameraid, bw10, bw60, bw300, streamtype
SBW0  | <details><summary>ストリーム帯域サンプル0イベント&nbsp;&#9702;</summary><p><br>ストリーム0のカメラ帯域幅のサンプル <br><br>`'PREV'` - プレビューチャンネル+サムネイルのベースの帯域幅（選択したレート/品質のすべてのフレーム、圧縮なし）</br></p></details> | cameraid, bw10, bw60, bw300
SBW1  | <details><summary>ストリーム帯域サンプル1イベント&nbsp;&#9702;</summary><p><br>ストリーム1のカメラ帯域幅のサンプル <br><br>`'PSND'` - *送信する必要がある* 帯域幅 <br>`'VIDC'` - 動画キャプチャ帯域幅 (動画と音声同一)</br></p></details> | cameraid, bw10, bw60, bw300
SBW2  | <details><summary>ストリーム帯域サンプル2イベント&nbsp;&#9702;</summary><p><br>ストリーム2のカメラ帯域幅のサンプル <br><br>`'VIDE'` - 動画ストリームのベース帯域幅 (非モーション フィルタ)</br></p></details> | cameraid, bw10, bw60, bw300
SBW3  | <details><summary>ストリーム帯域サンプル3イベント&nbsp;&#9702;</summary><p><br>ストリーム3のカメラ帯域幅のサンプル <br><br>`'AUDI'` - 音声ストリームのベース帯域幅 (非モーション フィルタ)</br></p></details> | cameraid, bw10, bw60, bw300
SBW4  | <details><summary>ストリーム帯域サンプル4イベント&nbsp;&#9702;</summary><p><br>ストリーム4のカメラ帯域幅のサンプル <br><br>`'VIDC'` - 動画キャプチャ帯域幅 (動画と音声同一)</br></p></details> | cameraid, bw10, bw60, bw300
SSTE	| ストリーマ状態イベント                                                     | cameraid, stype, event, seconds
CSAU	| <details><summary>カメラストリーム接続イベント&nbsp;&#9702;</summary><p><br>カメラがブリッジへのデータのストリーミングを開始しました（ `'streamid'`はCSDUとCSSUで共通です）</br></p></details> | cameraid, streamid, stream_format, stream_type
CSDU	| <details><summary>カメラストリーム除去イベント&nbsp;&#9702;</summary><p><br>カメラがブリッジへのデータのストリーミングを停止しました</br></p></details> | cameraid, streamid, stream_format, stream_type
CSSU	| <details><summary>カメラストリーム統計イベント&nbsp;&#9702;</summary><p><br>カメラがカメラとブリッジ間のストリームの統計情報を送信しています（CSAU / CSDUのハートビート）</br></p></details> | cameraid, streamtype, streamformat, total_expected, total_rcvd, delta_expected, delta_rcvd, interval, streamid
CECF	| <details><summary>カメラ検出イベント&nbsp;&#9702;</summary><p><br>ブリッジによってカメラが検出されました</br></p></details> | cameraid, uuid, svc_state
CECL	| <details><summary>カメラ逸失イベント&nbsp;&#9702;</summary><p><br>ブリッジが検出した後、カメラは正常に応答を停止しました</br></p></details> | cameraid
RCON	| カメラオンライン イベント                                                   | cameraid, registerid
RCOF	| カメラオフライン イベント                                                   | cameraid, registerid
CONN	| カメラオン イベント                                                       | cameraid
COFF	| カメラオフ イベント                                                       | cameraid
RCHB	| <details><summary>カメラハートビート イベント&nbsp;&#9702;</summary><p><br>カメラがまだ登録されていることをハートビートが示します</br></p></details> | cameraid, registerid
ABRT	| <details><summary>カメラア中断イベント&nbsp;&#9702;</summary><p><br>ブリッジのプロセスが再開しました（すべてのカメラストリームを中止）</br></p></details> | cameraid, aborted
COBC	| <details><summary>カメラバウンス イベント&nbsp;&#9702;</summary><p><br>カメラは強制的に再起動されました</br></p></details> | cameraid
CZTC	| <details><summary>カメラ設定変更イベント&nbsp;&#9702;</summary><p><br>示されたカメラの設定が新しい値に変更されました（データはzlib圧縮されています）</br></p></details> | cameraid, userid, flags, command, change
CZTS	| <details><summary>カメラ設定変更イベント&nbsp;&#9702;</summary><p><br>カメラ設定が変更されました（データはzlib圧縮されています）</br></p></details> | cameraid, sequence, settings
CZDC	| <details><summary>カメラ設定変更イベント&nbsp;&#9702;</summary><p><br>カメラの設定が古いものから新しいものに変更されました（データはzlib圧縮されています）</br></p></details> | cameraid, userid, flags, command, change
CPRG	| <details><summary>カメラパージ イベント&nbsp;&#9702;</summary><p><br>ストレージの制限によりカメラのデータをパージしました</br></p></details> | cameraid, day, bytes
CDLT	| <details><summary>カメラデータ消失イベント&nbsp;&#9702;</summary><p><br>ストレージの制限により、カメラの保存期間内にデータを削除しました</br></p></details> | cameraid, day, bytes
CBWS	| <details><summary>カメラ帯域幅サンプルイベント&nbsp;&#9702;</summary><p><br>カメラがクラウドに取り込み/送信したデータ量</br></p></details> | cameraid, kbytesondisk, bytesstored, bytesshaped, bytesstreamed, bytesfreed, daysondisk
BBWS	| <details><summary>ブリッジ帯域幅サンプルイベント&nbsp;&#9702;</summary><p><br>このブリッジ上のすべてのデバイスが取り込んでクラウドに送信したデータ量に関する統計</br></p></details> | cameraid, kbytessize, kbytesavail, bytesstored, bytesshaped, bytesstreamed, bytesfreed
BBTW	| <details><summary>ブリッジ帯域幅タグフロー イベント&nbsp;&#9702;</summary><p><br>ブリッジとクラウド間の帯域幅に関する統計</br></p></details> | cameraid, ip, bytes_sent, bytes_rcvd, active_write_us, paused_write_us
BUBW	| <details><summary>アップロード帯域幅サンプル イベント&nbsp;&#9702;</summary><p><br>クラウドに定期的に送信して帯域幅をテストするためのデータのメトリック（Nミリ秒単位での `'bytessent'`）</br></p></details> | cameraid, bytessent, millisecs
BBOO	| ブリッジ起動イベント                                                      | cameraid, booted
NOOP	| 非操作イベント                                                           | cameraid
AEAC	| アカウント作成イベント                                                     | cameraid, status, new_accountid, source_userid, source_accountid
AEAD	| アカウント削除イベント                                                     | cameraid, status, source_userid, source_accountid
AEAH	| アカウント変更イベント                                                     | cameraid, status, source_userid, source_accountid, values
AELI	| アカウント ログイン イベント                                                | cameraid, status, source_userid
AELO	| アカウント ログアウト イベント                                               | cameraid, status, source_userid
AEUC	| ユーザー作成イベント                                                       | cameraid, status, target_userid, source_userid, source_accountid
AEUD	| ユーザー削除イベント                                                       | cameraid, status, target_userid, source_userid, source_accountid
AECC	| ユーザー設定変更イベント                                                    | cameraid, status, target_userid, source_userid, source_accountid, values
AEEC	| レイアウト作成イベント                                                  　  | cameraid, status, source_userid, source_accountid, layoutid
AEED	| レイアウト削除イベント                                                     | cameraid, status, source_userid, source_accountid, layoutid
AEEL	| レイアウト変更イベント                                                     | cameraid, status, source_userid, source_accountid, layoutid, values
CCCF	| <details><summary>Curl失敗イベント&nbsp;&#9702;</summary><p><br>示されたcURLエラーコードにより、ブリッジとカメラ間の通信に失敗しました</br></p></details> | cameraid, errcode
ANNT	| アノテーション イベント                                                    | cameraid, ns, flags, uuid, seq, op, mpack
NVPT	| 名称、値表イベント                                                        | cameraid, ns, key_offset, op, mpack
ITFU	| インターフェイス更新イベント                                                 | cameraid, ip, flags, valid, mpack
SCRN	| 画面接続イベント                                                          | cameraid, ns, uuid, mpack
AELD	| ライブ表示イベント                                                        | cameraid, status, source_userid, deviceid
CCLC	| <details><summary>クラウド接続イベント&nbsp;&#9702;</summary><p><br>指定された接続を介してクラウドに接続されたブリッジ</br></p></details> | cameraid, src_ip, dest_ip, src_port, dest_port, ctype
CCLD	| <details><summary>クラウド切断イベント&nbsp;&#9702;</summary><p><br>ブリッジはクラウドとの接続を失いました</br></p></details> | cameraid, src_ip, dest_ip, src_port, dest_port, ctype, reason, seconds
ENES	| アプリケーション指定イベント開始                                              | cameraid, videoid, eventid, ns
ENEE	| アプリケーション指定イベント終了                                              | cameraid, eventid, ns
ENEU	| <details><summary>アプリケーション指定更新イベントApp-specific update event&nbsp;&#9702;</summary><p><br>アプリケーションイベントのハートビート <br>（10秒間隔）</br></p></details> | cameraid, videoid, eventid, ns
AEPT	| <details><summary>PTZ イベント&nbsp;&#9702;</summary><p><br>パン チルト ズーム イベント</br></p></details> | cameraid, status, source_userid, deviceid
EPES	| <details><summary>PTZ カメラ イベント開始&nbsp;&#9702;</summary><p><br>PTZ カメラの移動/変更イベントは開始しました</br></p></details> | cameraid, videoid, eventid
EPEE	| <details><summary>PTZ カメラ イベント終了&nbsp;&#9702;</summary><p><br>PTZ カメラの移動/変更イベントは終了しました</br></p></details> | cameraid, eventid
PTZS	| <details><summary>PTZ 状態イベント&nbsp;&#9702;</summary><p><br>特定時点のPTZ状態のスナップショット（移動中のPTZを追跡するため）</br></p></details> | cameraid, userid, flags, reason, pan_status, zoom_status, x, y, z
PRSS	| <small>プレビューストリーム開始イベント <br>**(内部使用のみ)**</small>           | cameraid, previewid, frame_delay, duration, flags, format, status
PRSE	| <small>プレビューストリーム終了イベント <br>**(内部使用のみ)**</small>           | cameraid, previewid, status
PRFU	| <small>プレビュー アップロード イベント <br>**(内部使用のみ)**</small>          | cameraid, file_offset, frame_size
AABT	| <small>カメラ アーカイバ 中断イベント <br>**(内部使用のみ)**</small>            | cameraid, aborted
ECON	| <small>カメラ オンライン イベント <br>**(廃止予定)**</small>                  | cameraid
ECOF	| <small>カメラ オフライン イベント <br>**(廃止予定)**</small>                  | cameraid
CSTS	| <small>カメラ設定変更イベント <br>**(廃止予定)**</small>                     | cameraid, sequence, settings
CSTC	| <small>カメラ設定変更イベント <br>**(廃止予定)**</small>                     | cameraid, sequence, settings
CSAT	| <small>カメラストリーム接続イベント <br>**(廃止予定)**</small>                 | cameraid, stream_format, stream_type
CSDT	| <small>カメラストリーム切断イベント <br>**(廃止予定)**</small>                 | cameraid, stream_format, stream_type
CSST	| <small>カメラストリーム統計イベント <br>**(廃止予定)**</small>                 | cameraid, streamtype, total_expected, total_rcvd, delta_expected, delta_rcvd, interval
PRSU	| <small>プレビューストリーム更新イベント <br>**(廃止予定)**</small>              | cameraid, previewid, status
VRSU	| <small>動画更新イベント <br>**(廃止予定)**</small>                          | cameraid, videoid, format, status

<!-- TODO: Unhide and fill out the below table when the information gets delivered -->

<details hidden>
### イベント パラメータ

パラメータ         | 詳細
---------        | -----------
aborted          | <p hidden>???</p>
active_write_us  | <p hidden>???</p>
alertid          | <p hidden>???</p>
alertmotionid    | <p hidden>???</p>
alertroiid       | <p hidden>???</p>
booted           | <p hidden>???</p>
bw10             | <p hidden>???</p>
bw60             | <p hidden>???</p>
bw300            | <p hidden>???</p>
bytes            | <p hidden>???</p>
bytes_rcvd       | <p hidden>???</p>
bytes_sent       | <p hidden>???</p>
bytesfreed       | <p hidden>???</p>
bytessent        | <p hidden>???</p>
bytesshaped      | <p hidden>???</p>
bytesstored      | <p hidden>???</p>
bytesstreamed    | <p hidden>???</p>
cameraid         | <p hidden>???</p>
change           | <p hidden>???</p>
command          | <p hidden>???</p>
ctype            | <p hidden>???</p>
day              | <p hidden>???</p>
daysondisk       | <p hidden>???</p>
delta_expected   | <p hidden>???</p>
delta_rcvd       | <p hidden>???</p>
dest_ip          | <p hidden>???</p>
dest_port        | <p hidden>???</p>
deviceid         | <p hidden>???</p>
duration         | <p hidden>???</p>
endtime          | <p hidden>???</p>
errcode          | <p hidden>???</p>
event            | <p hidden>???</p>
eventid          | <p hidden>???</p>
file_offset      | <p hidden>???</p>
flags            | <p hidden>???</p>
format           | <p hidden>???</p>
frame_delay      | <p hidden>???</p>
frame_size       | <p hidden>???</p>
interval         | <p hidden>???</p>
ip               | <p hidden>???</p>
kbytesavail      | <p hidden>???</p>
kbytesondisk     | <p hidden>???</p>
kbytessize       | <p hidden>???</p>
key_offset       | <p hidden>???</p>
layoutid         | <p hidden>???</p>
millisecs        | <p hidden>???</p>
motion           | <p hidden>???</p>
mpack            | <p hidden>???</p>
new_accountid    | <p hidden>???</p>
ns               | <p hidden>???</p>
op               | <p hidden>???</p>
pan_status       | <p hidden>???</p>
paused_write_us  | <p hidden>???</p>
previewid        | <p hidden>???</p>
reason           | <p hidden>???</p>
registerid       | <p hidden>???</p>
resource_type    | <p hidden>???</p>
roiid            | <p hidden>???</p>
seconds          | <p hidden>???</p>
seq              | <p hidden>???</p>
sequence         | <p hidden>???</p>
settings         | <p hidden>???</p>
source_accountid | <p hidden>???</p>
source_userid    | <p hidden>???</p>
src_ip           | <p hidden>???</p>
src_port         | <p hidden>???</p>
starttime        | <p hidden>???</p>
status           | <p hidden>???</p>
stream_format    | <p hidden>???</p>
stream_type      | <p hidden>???</p>
streamformat     | <p hidden>???</p>
streamid         | <p hidden>???</p>
streamtype       | <p hidden>???</p>
stype            | <p hidden>???</p>
target_deviceid  | <p hidden>???</p>
target_userid    | <p hidden>???</p>
total_expected   | <p hidden>???</p>
total_rcvd       | <p hidden>???</p>
triggerid        | <p hidden>???</p>
userid           | <p hidden>???</p>
uuid             | <p hidden>???</p>
valid            | <p hidden>???</p>
values           | <p hidden>???</p>
videoid          | <p hidden>???</p>
videosize        | <p hidden>???</p>
x                | <p hidden>???</p>
y                | <p hidden>???</p>
z                | <p hidden>???</p>
zoom_status      | <p hidden>???</p>
</details>

<!--===================================================================-->
## ポーリングの初期化
<!--===================================================================-->

<aside class="notice">ポール サービスの購読を行うには、GET /poll が必要です。応答： token=xxxxx / 応答ヘッダ： set_cookie: ee-poll-ses/poll_id=xxxxx</aside>

応答には、2つのセッションCookieと返されたトークン（同一）が含まれます。 GET /poll 要求には、セッションCookieの1つのみを提供する必要があります

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY]" -X POST -H 'Content-Type: application/json' https://c001.eagleeyenetworks.com/poll -d '{"cameras":{"111st658":{"resource":["event","status"],"event":["VREE","PRFR","CPRG"]}}}'
```

> JSON 要求

```json
{
    "cameras": {
        "100e1e23": {
            "resource": [
                "pre",
                "thumb",
                "status",
                "event"
            ],
            "event": [
              "MRBX"
            ]
        },
        "10097d15": {
            "resource": [
                "pre",
                "thumb",
                "status",
                "event"
            ],
            "event": [
              "MRBX"
            ]
        },
        "<object_id>": {...},
        "<object_id>": {...},
        "<object_id>": {...}
    }
}
```

### HTTP 要求

`POST https://login.eagleeyenetworks.com/poll`

<aside class="notice">カメラパラメータはエンティティであり、ID（カメラ、ブリッジまたはアカウントESN）をキーとした任意のオブジェクト構造を含むことができます</aside>

イベントポーリングの機構は展開が進んでいるため、パラメータ `'cameras'`
 は数多くの変更を受けておりますが、下位互換性のためにそのまま維持されています。デバイス/アカウントとしてこれらを理解する必要があります

パラメータ   | データ型式  | 詳細   
--------- | --------- | -----------
cameras   | JSON      | [\<object_id\>](#object-structure) をキーとしたJSON属性（異なるタイプの複数のJSONオブジェクトを含むことができます）

### オブジェクトの構造

パラメータ       | データ型式  | 詳細   
---------     | --------- | -----------
\<object_id\> | JSON      | `'resource'` や `'event'` をキーとしたJSON属性

JSONオブジェクトは、どのタイプのエンティティをポーリングするかを指定することによって、ポーリング範囲を絞り込むことを可能にします。タイプには次のものがあります：

パラメータ      | データ型式      | 詳細         | 必須？
---------    | ---------     | ----------- | -----------
**resource** | 配列[文字列]    | 提供されたデバイス/アカウントから検索する必要があるデータの種類を含む1つ以上の文字列の配列 <br><br>選択した：[pre, thumb, video, status, event](#poll) | true
event        | 配列[文字列]    | イベント [Four CC](#event-objects) （リソースに `'event'` が含まれる場合、ここで指定されたイベントの配列は検索されたイベントの範囲を絞り込みます）を含む1つまたは複数の文字列の配列

<!--TODO: Find out why the video as a feasible resource has been excluded from the above table-->

<aside class="warning">イベントパラメータには、（WebSocketの代わりに）HTTP経由でポーリングする際にイベントリソースが存在する必要があります</aside>

> JSON 応答

```json
{
    "cameras": {
        "100e1e23": {
            "status": 1441847
        },
        "10097d15": {
            "status": 1441847
        },
        "<object_id>": {...},
        "<object_id>": {...},
        "<object_id>": {...}
    },
    "token": "ooe0eoEAMNsF"
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ型式  | 詳細
--------- | --------- | -----------
cameras   | JSON      | [\<object_id\>](#response-object-structure) をキーとしたJSON属性（異なるタイプの複数のJSONオブジェクトを含むことができます）
token     | 文字列     | 後続のGET /poll 要求に使用されるトークン

### 応答オブジェクト構造

パラメータ       | データ型式  | 詳細
---------     | --------- | -----------
\<object_id\> | JSON      | JSON属性は [resource](#poll) 型をキーとしています。取得された値は、指定されたリソースの最新のエンティティです

キーの量は、送信されたリクエストの問い合わせに依存します（要求が `'pre'` と `'video'` を伴う場合、取得されたデータは `'pre'` と `'video'` 情報のみをカバーします）

指定されたイベントがデバイス/アカウントでトリガーされていない場合は、ポーリングサービスによってリストされません（エラーは報告されません）

返される値は、[returned resource types](#response-resource-types) と合致します

<aside class="warning">状態パラメータが優先され（複数の場合）、HTTP POST /pollでポーリングすると他のすべては抑制されます</aside>

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| 予期せぬまたは識別不能な引数が指定されました
401	| 無効なセッションCookieにより認可されませんでした
403	| ユーザーに必要な権限がないため拒否されました
200	| 要求は成功しました

<!--===================================================================-->
## ポーリング
<!--===================================================================-->

<aside class="notice">リアルタイムの変更に関するアップデートを受信するために使用されます。 このAPIコールでは、POST /poll で生成された有効な 'ee-poll-ses' クッキーが必要です</aside>

> 要求

```shell
curl --cookie "auth_key=[AUTH_KEY];ee-poll-ses=[TOKEN]" --request GET https://c001.eagleeyenetworks.com/poll
```

### HTTP 要求

`GET https://login.eagleeyenetworks.com/poll`

> JSON 応答

```json
{
    "cameras": {
        "100e1e23": {
            "pre": "20181121165011.233",
            "event": {
                "MRBX": {
                    "timestamp": "20181121165011.499",
                    "cameraid": "100c299e",
                    "boxes": [
                        {
                            "x": 24575,
                            "y": 29126,
                            "w": 4095,
                            "h": 5825
                        }
                    ]
                },
                "PRFU": {
                    "timestamp": "20181121165011.233",
                    "cameraid": "100c299e",
                    "file_offset": 26311872,
                    "frame_size": 7838
                },
                "PRFR": {
                    "timestamp": "20181121165011.233",
                    "cameraid": "100c299e",
                    "previewid": 1416585600,
                    "file_offset": 26311872,
                    "frame_size": 7830
                }
            }
        },
        "10097d15": {
            "pre": "20181121165011.281",
            "event": {
                "PRFU": {
                    "timestamp": "20181121165011.281",
                    "cameraid": "1002a2a4",
                    "file_offset": 6126297,
                    "frame_size": 4014
                },
                "PRFR": {
                    "timestamp": "20181121165011.281",
                    "cameraid": "1002a2a4",
                    "previewid": 1416585600,
                    "file_offset": 6126297,
                    "frame_size": 4006
                }
            }
        }
    }
}
```

### HTTP 応答 (JSON 属性)

パラメータ   | データ型式  | 詳細
--------- | --------- | -----------
cameras   | JSON      | \<object_id\> をキーとしたJSON属性（異なるタイプの複数のJSONオブジェクトを含むことができます）

### 応答オブジェクトの構造

パラメータ       | データ型式  | 詳細
---------     | --------- | -----------
\<object_id\> | JSON      | JSON属性は [resource](#poll) 型をキーとしています。取得された値は、指定されたリソースの最新のエンティティです

キーの量は送信されたPOST要求に依存します（要求が `'pre'` と `'video'` を伴う場合、取得されたデータは `'pre'` と `'video'` 情報のみをカバーします）

指定されたイベントがデバイス/アカウントでトリガーされていない場合は、ポーリングサービスによってリストされません（エラーは報告されません）

返される値は、[returned resource types](#response-resource-types) に対応します

<aside class="warning">状態パラメータが優先され（複数の場合）、HTTP POST /pollでポーリングすると他のすべては抑制されます</aside>

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| 予期せぬまたは識別不能な引数が指定されました
401	| 無効なセッションCookieにより認可されませんでした
403	| ユーザーに必要な権限がないため拒否されました
200	| 要求は成功しました

<!--===================================================================-->
## WebSocket ポーリング
<!--===================================================================-->

WebSocketは、クライアントとサーバー間の永続的な接続を提供します。 このアップリンクは、ブロック化されたデータをメッセージとして送受信できる双方向のデータストリームを有効可します。このプロトコルは、単一のTCP接続を介して全二重通信チャネルを提供し、クライアントが応答をサーバーにポーリングすることなくイベントドリブンの応答を受信できるようにします（実質的にデータトラフィックを減少させます）

<aside class="notice">WebSocketのHTTPプロトコルとの類似点は、そのハンドシェイクがHTTPサーバーによってHTTPの「アップグレード要求」として解釈されることです</aside>

> 要求 JSON

```json
{
    "cameras": {
        "100e1e23": {
            "resource": [
                "pre",
                "thumb",
                "status",
                "event"
            ],
            "event": [
              "MRBX"
            ]
        },
        "10097d15": {
            "resource": [
                "pre",
                "thumb",
                "status",
                "event"
            ],
            "event": [
              "MRBX"
            ]
        },
        "<object_id>": {...},
        "<object_id>": {...},
        "<object_id>": {...}
    }
}
```

### クライアント ハンドシェイク要求

`GET /api/v2/Device/00001007/Events HTTP/1.1`  
`Upgrade: websocket`  
`Connection: Upgrade`  
`Host: c000.eagleeyenetworks.com`  
`Origin: http://c000.eagleeyenetworks.com`  
`Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==`  
`Sec-WebSocket-Version: 13`  
`Cookie: auth_key=[AUTH_KEY]`

WebSocket プロトコルは2つの部分に分かれます:

  - ハンドシェイク（アップグレードされた接続を確立するため）
  - データ転送

<aside class="notice">ハンドシェイクプロセスは、クライアント側から標準のHTTPリクエスト（HTTPバージョンは1.1以上でなければならず、メソッドはGETでなければならない）によって開始されなければならななりません</aside>

<table>
    <tr>
        <th colspan=7>WebSocketリクエストURLは、次のように構成されています：</th>
    </tr>
    <tr>
        <th style="text-align:center;">wss:&#47;&#47;</th>
        <th style="text-align:center;">c000.</th>
        <th style="text-align:center;">eagleeyenetworks.com</th>
        <th style="text-align:center;">&#47;api&#47;v2</th>
        <th style="text-align:center;">&#47;Device</th>
        <th style="text-align:center;">&#47;00001007</th>
        <th style="text-align:center;">&#47;Events</th>
    </tr>
    <tr>
        <td style="text-align:center;">セキュア <br>websocket <br>プロトコル</td>
        <td style="text-align:center;">ブランド <br>サブドメイン</td>
        <td style="text-align:center;">サーバー</td>
        <td style="text-align:center;">API バージョン</td>
        <td style="text-align:center;">リソース</td>
        <td style="text-align:center;">アカウント ID</td>
        <td style="text-align:center;">'イベント' 接尾辞</td>
    </tr>
</table>

WebSocket URLは、WSSを使用するか、HTTPSと同等の安全な接続にWSSを使用します

パラメータ   | データ形式  | 詳細         | 必須？
--------- | --------- | ----------- | -----------
**A**     | 文字列      | `'auth_key'` クッキーを置き換えるために使われます | false

### サーバー ハンドシェイク応答

`HTTP/1.1 101 Switching Protocols`  
`Server: openresty`  
`Date: Wed, 08 Mar 2018 14:01:06 GMT`  
`Connection: upgrade`  
`upgrade: websocket`  
`sec-websocket-accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=`  
`set-cookie: ee-ws-poll-ses=kjxZXVrDyIkK`  
`x-een-lb-tried-proxies: 209.94.238.21:80`

ハンドシェイクの完了をサーバーが応答します。 成功したサーバーは応答の後にデータ転送を続けます

### エラー状態コード

HTTP 状態コード     | 詳細
---------------- | -----------
400	| ヘッダーが理解不能か、値が正しくありません
101	| プロトコルを切り替えました

### データ交換

クライアントは、JSON形式の文字列のオブジェクトを送信することによってハンドシェイクが成功した後、サーバーと通信します。*message* の送信は、適切なWebSocket *send* 関数を呼び出すことによってクライアントによってトリガーされています（このメソッドはクライアント環境に依存します）

クライアントは、JSON経由でどのデバイスからどのような種類のデータをポーリングするかを指定する必要があります（[Initialize Poll](#initialize-poll), [Resource Type](#poll)、 [Event Objects](#event-objects) を参照）

WebSocketはイベント駆動型APIです。メッセージが受信されると、メッセージイベントが *onmessage* 関数に渡され、メッセージが受信され、解析されます

接続は *close* 関数を使っていつでも切断することができます

<aside class="warning">JSON形式の文字列に不正なデータがセットされていても、正常なハンドシェイクを確立できます</aside>

WebSocketポーリングは、[Errors](#errors) セクションに基づいて発生した個々の問題ごとに *message* 応答エラーコードをさらに返します

### メッセージ エラー状態コード

状態コード     | 詳細
----------- | -----------
400	| 不正なリソース
401	| アクセス拒否
412	| 認証が失われました
200	| OK
