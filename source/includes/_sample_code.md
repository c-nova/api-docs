# 使い方とサンプルコード

<!--===================================================================-->
## Curlを使ってAPIコールを作成するには
In this section, we will walk you through the process of making API requests using the ‘curl’ command line tool. The Eagle Eye APIs are platform agnostic and we use them to create the web, Android, and iOS Eagle Eye clients. Curl is a tool for transferring data to and from a server, using a wide range of supported protocols, including HTTP/HTTPS, which is what we are interested in. Curl can be installed by going to this site. http://curl.haxx.se/.

With curl installed, the next step is to log in and have a valid session, so that we can freely use any of the APIs. Logging in, is a two step process consisting of authentication and authorization. The authentication API takes in 2 parameters. Our curl common will look like this. The [USERNAME] and [PASSWORD] need to be valid for the API request to return successfully.

`
curl --request POST https://login.eagleeyenetworks.com/g/aaa/authenticate --data 'username=[USERNAME]&password=[PASSWORD]'
`

The ‘–request’ flag specifies the type of request and can be set to GET, POST, PUT, and DELETE. The ‘data’ flag species the parameters of the API query. Upon running this command with valid credentials, we receive a Json formatted response, containing a key/value pair for ‘token’, which will look something like this.

`
{ “token”: “YrZF/8jf7W0rKcqNTugqidq…………4dZWeNOcNsuenTXc9fQVtvp2vI75g==” }
`

This token is a required parameter for making the Authorize API request. Copy the value of the token in order to have it on hand when creating the Authorize API request. Now we make the authorization API request using this curl command.

`
curl -D - --request POST https://login.eagleeyenetworks.com/g/aaa/authorize --data-urlencode token=[TOKEN]
`

The output are the headers of the API request followed by the response body. The ‘-D’ flag is used to write the protocol headers. Here is the description from the man pages.

`
-D, –dump-header <file> Write the protocol headers to the specified file. This option is handy to use when you want to store the headers that a HTTP site sends to you. Cookies from the headers could then be read in a second curl invocation by using the -b, –cookie option! The -c, –cookie-jar option is however a better way to store cookies.
`

Note that the ‘-‘ after the ‘-D’ indicates that the output “file” is stdout. One of the header elements will be “Set-Cookie: auth_key=[AUTH_KEY]“. Copy ‘auth_key=[AUTH_KEY]‘ into the clipboard as this cookie will need to be set for all other API requests. The curl request for getting a list of devices will look as such.

`
curl --cookie "auth_key=[AUTH_KEY]" --request GET https://login.eagleeyenetworks.com/g/list/devices
`

The ‘auth_key’ cookie will need to be set for any other Eagle Eye API that requires a valid session.

<!--===================================================================-->
## レイアウトを作成する

> Get /layout/list

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

When a user logs onto the Eagle Eye system, they are greeted with a grid of cameras, with each cell representing a camera pane. These panes can be of varying size so that the user can customize the layout to their liking. In this tutorial, we will demonstrate how to use the APIs to build these layouts so they are consistent on all platforms.

Upon being logged in, we make a request to the GET /layout/list API. This returns an array of Layout objects. Do note that this is not the same model as what is returned by the GET /layout API request. The one returned by the /layout/list API is an abridged version with only the most important attributes. The response of the request will look like this.

`
Get /layout/list
`

We take the layout id attribute for each layout of interest and pass it to the Get /layout API request. This will contain the information we need to construct the layout.

`
Get /layout
`

> Get /layout

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

We get a wealth of good information, but the information specific to setting up the pane layout is in the ‘configuration’ json. Within that json, there is an attribute called ‘panes’ which is an array of individual pane objects. Each pane specifies the camera_id and the size of the pane. The size represents the width and height in number of cells. A size of 2 means that the pane is 2 cells in width and height, so it occupies a total of 4 cells. A size of 3 would occupy 9 cells.

The other important factor to know is the size of grid holding the panes, specifically the number of columns. For the Eagle Eye web client, a browser can be resized to be a narrow strip or the full width of the screen. The layout will dynamically adjust the number of columns based on the width of the window. Mobile devices have fixed screen sizes, so for the iOS and Android smartphone clients, we set the number of columns to three.

Now that we have the order of the panes, the size of each pane, and the size of the grid, we can construct our layout. This proved to be of varying difficulty depending on the platform. The web client uses a robust packing library, Packery, which is based on a bin packing algorithm. http://metafizzy.co/blog/packery-released/. This library minimizes empty space while preserving the order as best as possible. Using Packery reduced the development time for this feature significantly.

At the time of this writing, Android does not have a robust library for packing the panes so the algorithm to do so was written from scratch. The goal was to mimic the Packery library as best as possible. The Android algorithm works as such:


 1. Remove the next image from the ‘panes’ array and place it in the ‘panes_for_analysis’ list.
 2. Analyze the panes in ‘panes_for_analysis’. If there is a fully packed block, remove those panes and add them to the layout
 3. If the ‘panes’ array is not empty, GOTO 1, else GOTO 4
 4. Add the remaining panes from ‘panes_for_analysis’ to the layout.

This is the algorithm at a high level, though the specifics can get a little more complex, such as determining whether a fully packed block exists. The state of a fully packed block is also dependent on the number of columns for the grid.

The ease of constructing layouts is highly dependent on the robustness of the 3rd party library. In the case that one does not exist, we fall back to our home grown packing algorithm.

<!--===================================================================-->
## ライブビデオを再生する
Video playback functionality can be accessed through the ‘/asset/play/video.{video_format}’ API. We will show you how to use this API to play live video, though the same API can also be used to play historic video.

Below is the Javascript code that creates the URL for playing live video footage with a HTML flash video player. You can run the javascript code on this site to generate the URL string. http://writecodeonline.com/javascript/.

The caller of the API need to supply 2 parameters. which are [DEVICE_ID] and [AUTH_KEY]. The [DEVICE_ID] represents the id of the camera of interest. The [AUTH_KEY] is used for authentication and can be found in the response header of the /aaa/authorization API.

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

Notice that we have 2 variables; ‘eagleEyeLiveVideoApiUrl’ and ‘htmlFlashVideoPlayerUrl’. The ‘htmlFlashVideoPlayerUrl’ variable contains the video player being used to play the Flash Player. Users are free to use any video player of this liking, and the one referenced in the code is just an example video player we are using. The output of this JS code is a URL that looks like this. Use this to embed live video into your application.

`
https://login.eagleeyenetworks.com/strobe/embed.html?autoPlay=true&src=https%3A%2F%2Flogin.eagleeyenetworks.com%2Fasset%2Fplay%2Fvideo.flv%3Fc%3D[DEVICE_ID]%3Bt%3Dstream_1401291315740%3Be%3D%2B300000%3BA%3D[AUTH_KEY]&bufferingOverlay=false&streamType=live&bufferTime=1&initialBufferTime=1&expandedBufferTime=5&liveBufferTime=2&liveDynamicStreamingBufferTime=4&minContinuousPlaybackTime=5
`

<!--===================================================================-->
## 長期ポーリング

> Json Request for Post /poll

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
```

Upon entering the Eagle Eye system, the user is presented with a grid of cameras. These cameras are retrieving images in real time through a poll stream. In this tutorial, we will walk you through the steps to set up the poll stream for long polling using the /poll API.

Long polling is used in the mobile clients. The process is to first register to the poll stream using the POST /poll API followed by constant API requests for GET /poll.

The POST /poll API is used to initialize the poll stream and to register the events we want to listen for. For the mobile clients, we are listening to resource type ‘pre’ and ‘status’, which are the preview images and status bits. Since the data we are sending to the server is a json, the content-type of this request will be application/json. Here is an example of what the the data may look like.

Once the POST /poll request has been made successfully, a token is returned to the user. This token can be used to successfully make all subsequent GET /poll requests. If the token is not desired, the same requests can be made if you have the ‘ee-poll-ses’ cookie from the POST /poll request.

The GET /poll request should be called frequently so that new data can arrive as soon as possible. The response may be empty or it may look something like this.

> Response for Get /poll

```json

{
    "cameras": {
        "10003254": {
            "event": {
                "PRFR": {
                    "cameraid": "10003254",
                    "timestamp": "20140528224954.312",
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
                    "timestamp": "20140528224955.507",
                    "file_offset": 12004385,
                    "frame_size": 3706,
                    "previewid": 1401314400
                }
            },
            "pre": "20140528224955.507"
        }
    }
}
```

Only attributes with updated information will be returned in the response payload. For the mobile apps, we monitor the ‘pre’ attribute for new timestamps, and when a new timestamp does come in, we make the appropriate API call to retrieve the camera image.

The power of this API lies in the ability of being able to control what events and resource types to listen to. This allows updates to the camera to be known in real time.


