# 使い方とサンプルコード

<!--===================================================================-->
## Curlを使ってAPIコールを作成するには
<!--===================================================================-->

---

### cURL

> 認証リクエスト

```shell
curl --request POST https://login.eagleeyenetworks.com/g/aaa/authenticate --data "username=[USERNAME]&password=[PASSWORD]"
```

このセクションでは、**curl** コマンドラインツールを使用したAPI要求の処理方法を一通り案内します。Eagle Eye APIはプラットフォームに依存せず、Web、AndroidそしてiOS上でのEagle Eyeクライントの作成に利用されています。Curlはサーバーへのデータ転送ツールですが、HTTP/HTTPSを含む、我々が望む幅広いプロトコルをサポートしています。

**cURL** は [このサイト](http://curl.haxx.se) でインストールが可能です

curlがインストールされると次は全てのAPIを自由に使えるように、正規のセッションを使用してログインします ([cURL cheat sheet](https://ec.haxx.se/http-cheatsheet.html#curl-cheat-sheet) のサイトで基本的な HTTP コマンドがマ学べます)。ログインには、認証と認可の2つのステップから構成されます。認証APIは2つのパラメータを必要とします。私達が使用している cURL の一般的にな使用例（認証要求）は右記のコードのようになります

<aside class="notice">The <small>[USERNAME]</small> と <small>[PASSWORD]</small> はAPI要求を成功で返すために必要です</aside>

`'--request'` フラグは要求の形式を *GET*、*POST*、*PUT* 及び *DELETE* のいずれかで指定します

`'--data'` (または `'-d'`) フラグはAPIクエリのパラメータを指定します

---

### トークン

> JSON 応答

```json
{
  "token": "YrZF/8jf7W0rKcqNTugqidq…………4dZWeNOcNsuenTXc9fQVtvp2vI75g=="
}
```

このコマンドが正規の認証情報で実行されている場合、我々は右記の例（JSON 応答）のような キー/バリュー(値) のペアで構成された `'token'` を含むJSONフォーマットの応答を受け取ります

このトークンは認可API要求を実行するために必要なパラメータです
<br>(認可API要求を作成時に必要になるので、トークンの値をコピーしておいてください)

<br><br><br><br>

---

### 認可

> 認可要求

```shell
curl -D - --request POST https://login.eagleeyenetworks.com/g/aaa/authorize --data-urlencode "token=[TOKEN]"
```

例のようなcurlコマンドを利用して認可API要求を実行することができます

出力はAPI要求のヘッダに続いて応答ボディで構成されます。`'-D'` フラグはプロトコル ヘッダを書き出します。以下がmanページ内の詳細です：

引数      | 詳細
-------- | -----------
**-D**, –dump-header <file> | プロトコルヘッダを指定したファイルに書き込みます。このオプションは HTTP サイトから送信されてきたヘッダを保存するときに有用なものです。ヘッダ内のクッキーを後の curl 起動時に -b、--cookie を用いて読み取らせることも可能になります。 クッキーの保存には -c、--cookie-jar の方が適しています

---

> デバイス 要求リストの取得 (認証済み)

```shell
curl --request GET https://login.eagleeyenetworks.com/g/list/devices --cookie "auth_key=[AUTH_KEY]"
```

`'-D'` の後に続く `'-'` は出力する *ファイル* が標準出力であることを示すことに注意してください。ヘッダの要素の一つは `'Set-Cookie: auth_key=[AUTH_KEY]'` です。その他全てのAPI要求で必要となるクッキーとして `'auth_key=[AUTH_KEY]'` をクリップボードにコピーします。デバイスのリストを取得するcurlの要求は右記のようになります

<aside class="notice">‘auth_key’クッキーは正規のセッションを必要とするその他全てのEagle Eye APIで必要になります</aside>

<!--===================================================================-->
## レイアウトを作成する
<!--===================================================================-->

> Get List of Layouts (Request)

```shell
curl --request GET https://login.eagleeyenetworks.com/g/layout/list --cookie "auth_key=[AUTH_KEY]"
```

> Get List of Layouts (Json Response)

```json
[
    [
        "fc7fa3a4-66ea-11e3-8ca8-523445989f37",
        "Default",
        [
            "iphone"
        ],
        "SWRD"
    ],
    [
        "14fbd682-66eb-11e3-8ca8-523445989f37",
        "Ekta 2",
        [
            "iphone"
        ],
        "SWRD"
    ],
    [
        "23535930-66eb-11e3-977b-ca8312ea370c",
        "Ekta 3",
        [
            "desktop"
        ],
        "SWRD"
    ]
]
```

### HTTP Request

`GET /layout/list`
`GET /layout`

When a user logs onto the Eagle Eye system, they are greeted with a grid of cameras, with each cell representing a camera pane. These panes can be of varying size so that the user can customize the layout to their liking. In this tutorial, we will demonstrate how to use the APIs to build these layouts so they are consistent on all platforms

While logged in, we make a request to the GET /layout/list API. This returns an array of Layout objects. Do note that this is not the same model as what is returned by the GET /layout API request. The one returned by the /layout/list API is an abridged version with only the most important attributes. The response of the request will look like this

We take the layout ID attribute for each layout of interest and pass it to the GET /layout API request. This will contain the information we need to construct the layout

> Get Layout (Request)

```shell
curl -G https://login.eagleeyenetworks.com/g/layout -d "id=[LAYOUT_ID]" --cookie "auth_key=[AUTH_KEY]"
```




> Get Layout (Json Response)

```json
{
    "id": "811dbe48-66eb-11e3-8ca8-523445989f37",
    "shares": [
        [
            "ca0c35cb",
            "SWRD"
        ]
    ],
    "name": "mob dev 1",
    "permissions": "SWRD",
    "current_recording_key": null,
    "types": [
        "desktop"
    ],
    "configuration": {
        "settings": {
            "camera_row_limit": 3,
            "automatic_rotation": false,
            "camera_name": false,
            "camera_border": "false",
            "camera_aspect_ratio": "0.75"
        },
        "panes": [
            {
                "type": "preview",
                "pane_id": 0,
                "name": "Conference Room",
                "cameras": [
                    "100f6136"
                ],
                "size": 2
            },
            {
                "type": "preview",
                "pane_id": 1,
                "name": "NW Parking",
                "cameras": [
                    "10003254"
                ],
                "size": 2
            }
        ]
    }
}
```

We get a wealth of good information, but the information specific to setting up the pane layout is in the `'configuration'` Json. Within that Json is an attribute called `'panes'`, which is an array of individual pane objects. Each pane specifies the \<camera_id\> and the size of the pane. The size represents the width and height in number of cells. A size of 2 means that the pane is 2 cells in width and height, so it occupies a total of 4 cells. A size of 3 would occupy 9 cells

The other important factor to know is the size of grid holding the panes, specifically the number of columns. For the Eagle Eye web client a browser can be resized to be a narrow strip or the full width of the screen. The layout will dynamically adjust the number of columns based on the width of the window. Mobile devices have fixed screen sizes, so for the iOS and Android smartphone clients the number of columns is set to three

Now that we have the order of panes, the size of each pane and the size of the grid, we can construct our layout. This proved to be of varying difficulty depending on the platform. The web client uses a robust packing library [Packery](http://metafizzy.co/blog/packery-released), which is based on a bin packing algorithm. This library minimizes empty space while preserving the order as best as possible. Using Packery reduced the development time for this feature significantly

At this time Android does not have a robust library for packing the panes so the algorithm to do so was written from scratch. The goal was to mimic the Packery library as best as possible. The Android algorithm works as such:

  1. Remove the next image from the `'panes'` array and place it in the `'panes_for_analysis'` list
  2. Analyze the panes in `'panes_for_analysis'`. If there is a fully packed block, remove those panes and add them to the layout
  3. If the `'panes'` array is not empty, GOTO 1, else GOTO 4
  4. Add the remaining panes from `'panes_for_analysis'` to the layout

This is the algorithm at a high level, though the specifics can get a little more complex, such as determining whether a fully packed block exists. The state of a fully packed block is also dependent on the number of columns for the grid

The ease of constructing layouts is highly dependent on the robustness of the 3rd party library. In the case that one does not exist, we fall back to our home grown packing algorithm

<!--===================================================================-->
## ライブビデオを再生する
<!--===================================================================-->

動画再生機能は、`'/asset/play/video.{video_format}'` APIを通じてアクセスできます。ここではどのようにこのAPIを使用してライブ動画を再生するか、及び同じAPIを使用して録画された動画を再生するかを説明します

以下はHTML Flash動画再生を使用して、ライブ動画を再生するためのURLを作成するJavascriptコードです。[このサイト](https://js.do) で、URL文字列を生成するためのJavascriptコードを実行することも可能です。

APIの呼び出しには2個のパラメータが必要になります。それらは [DEVICE_ID] と [AUTH_KEY] と呼ばれます。[DEVICE_ID] は対象となるカメラのIDを表します。[AUTH_KEY] は認可のために使用され、`'/aaa/authorization'` APIの応答ヘッダに含まれます

`
eagleEyeLiveVideoApiUrl = "https://login.eagleeyenetworks.com/asset/play/video.flv" +
    "?id=[DEVICE_ID]" +
    "&start_timestamp=stream_"+(new Date().getTime()) +
    "&end_timestamp=+300000" +
    "&A=[AUTH_KEY]";
`

`
htmlFlashVideoPlayerUrl = "https://login.eagleeyenetworks.com/strobe/embed.html?src="+encodeURIComponent(eagleEyeLiveVideoApiUrl)+"&autoPlay=true&bufferingOverlay=false&streamType=live&bufferTime=1&initialBufferTime=1&expandedBufferTime=5&liveBufferTime=2&liveDynamicStreamingBufferTime=4&minContinuousPlaybackTime=5";
`

`
document.write(htmlFlashVideoPlayerUrl);
`

`'eagleEyeLiveVideoApiUrl'` と `'htmlFlashVideoPlayerUrl'` という2つの変数を使用していることに注意してください。`'htmlFlashVideoPlayerUrl'` 変数は、Flash Playerを使用して再生する動画プレイヤーが含まれています。ユーザーはこの好きな動画プレーヤーを自由に使用できます。コードで参照されている動画プレーヤーは、我々が使用している動画プレーヤーの一例です。このJSコードの出力は、次のようなURLです。これを使用してライブビデオをアプリケーションに埋め込みます：

`
https://login.eagleeyenetworks.com/strobe/embed.html?autoPlay=true&src=https%3A%2F%2Flogin.eagleeyenetworks.com%2Fasset%2Fplay%2Fvideo.flv%3Fc%3D[DEVICE_ID]%3Bt%3Dstream_1401291315740%3Be%3D%2B300000%3BA%3D[AUTH_KEY]&bufferingOverlay=false&streamType=live&bufferTime=1&initialBufferTime=1&expandedBufferTime=5&liveBufferTime=2&liveDynamicStreamingBufferTime=4&minContinuousPlaybackTime=5
`

<!--===================================================================-->
## 長期ポーリング
<!--===================================================================-->

> POST /poll の JSON 要求

```json
{
     "cameras": {
         "100c30ea": {
             "resource": [
                 "event",
                 "pre",
                 "thumb",
                 "status"
             ],
             "event": [
                 "ECON",
                 "ECOF",
                 "AELI",
                 "AELO",
                 "EMES",
                 "EMEE",
                 "CECF",
                 "CSAT",
                 "CSDT",
                 "CONN",
                 "COFF",
                 "ESES",
                 "ESEE"
             ]
         },
         "100f6136": {
             "resource": [
                 "event",
                 "pre",
                 "thumb",
                 "status"
             ],
             "event": [
                 "ECON",
                 "ECOF",
                 "AELI",
                 "AELO",
             ]
         },
         "1009c1ab": {
             "resource": [
                 "event",
                 "pre",
                 "thumb",
                 "status"
             ],
             "event": [
                 "EMES",
                 "EMEE",
                 "CECF",
                 "CSAT",
                 "CSDT",
                 "CONN",
                 "COFF",
                 "ESES",
                 "ESEE"
             ]
         }
     }
}
```

Eagle Eyeシステムに入ると、ユーザーにはカメラのグリッドが表示されます。 これらのカメラは、ポーリングストリームを通じてリアルタイムで画像を検索しています。このチュートリアルでは、/poll APIを使用してロングポーリング用のポーリングストリームを設定する手順について説明します。

ロング（長期）ポーリングはモバイルクライアントで使用されます。このプロセスは、最初にPOST /poll APIを使用してポーリングストリームに登録し、続いてGET /poll APIリクエストを一定の間隔で要求します

POST /poll APIは、ポーリングストリームを初期化し、リッスンしたいイベントを登録するために使用されます。モバイルクライアントの場合、プレビュー画像とステータスビットであるリソースタイプ `'pre'` と `'status'` をリッスンします。サーバーに送信するデータはjsonであるため、この要求のコンテンツタイプは `'application/json'` になります。データがどのように見えるかの例を以下に示します

> GET /poll の応答

```json
{
  "cameras": {
    "10003254": {
      "event": {
        "PRFR": {
          "cameraid": "10003254",
          "timestamp": "20180528224954.312",
          "file_offset": 17804500,
          "frame_size": 6152,
          "previewid": 1401314400
        }
      }
    },
    "100a9541": {
      "event": {
        "PRFR": {
          "cameraid": "100a9541",
          "timestamp": "20180528224955.507",
          "file_offset": 12004385,
          "frame_size": 3706,
          "previewid": 1401314400
        }
      },
      "pre": "20180528224955.507"
    }
  }
}
```

一度 POST /poll 要求が成功すると、トークンがユーザーに返されます。このトークンを使用して、その後のすべての GET /poll 要求を正常に作成できます。トークンが変更したい場合は、POST /poll 要求から 'ee-poll-ses'クッキーがあれば、同じリクエストを行うことができます。

新しいデータができるだけ早く到着できるように、GET /poll 要求を頻繁に呼び出す必要があります。応答は空か、右記の例のように表示されます

更新された情報を持つ属性のみが応答ペイロードに返されます。モバイルアプリでは、新しいタイムスタンプの `'pre'` 属性を監視し、新しいタイムスタンプが来たら、適切なAPI呼び出しを行ってカメラ画像を取得します。

このAPIの能力は、どのイベントやリソースタイプをリッスンするかを制御できることにあります。これにより、カメラの更新をリアルタイムで知ることができます
