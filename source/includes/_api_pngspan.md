# PNGスパン

<!--===================================================================-->
## 概要

このサービスはサポート メトリック可視化機能をネイティブPNGスパンとして描画します。スパンでは、指定したスパンがアクティブな場合は前景色で、非アクティブな場合には背景色で画像を作成します。スパンは最低でも1つ以上のピクセスで描画され、尺度とは独立し、スパンは他のものと重なることもあります。eタグでは、アクティブなイベントごとに1つのピクセルで描画されますが、スパンと共に描画される場合には重なることがあります。


### Response Headers

content-location: resource actually rendered. absolute start/end ts and either table/etag depending on whether an index was used

### Discussion

The pngspan is a very efficient mechanism for visualizing where metrics and spans are active. Scale the image vertically as needed. PNG are extremely compact - a day of spans will be a few hundred bytes.

Tile the PNGs for fast, infinite scrolling. Render a width/timespan that represents a rational chunk of the current screen - say 4 hours in a day view. Fill the screen with tiles, fetch offscreen at the same size in preparation to scroll. Change origin of each entity to accomplish fast smooth scrolling. Fetch successive offscreen buffers as they come on screen.

Hit detection (for rollover) can be done in a browser by rendering opaque colors and reading pixels values from a one pixel high offscreen image. If an active pixel is detected, fetch the window of events around the timestamp estimate (since the pixel resolution is usually much less than the ms resolution needed for a timestamp), and use the response to determine what metric/span to display (ie the closest one…).

### PNG Types

  * setting
  	* table=onoff - "camera_on" setting, the inverse of which represents camera "off"
  * purge
	* fflags=LOST - filter for only purges the lost data (within retention window)
  * span
  	* table=video - video recording on
	  * fflags=STREAM - filter for only streaming video	
	* table=motion - motion detected (overall)
	  * fflags=ALERTS - filter for only motion that triggered alert
	* table=roim - roi motion detected
	  * fflags=ALERTS - filter for only roim that triggered alert
	  * flname=roiid, flval=roiid value
	* table=stream - bridge is streaming from camera, the inverse of which represents camera "offline"
	* table=register - camera is registered with the cloud, the inverse of which represents "internet offline"

<!--===================================================================-->
## PNGスパンの取得

> 要求

```shell
curl -G https://login.eagleeyenetworks.com/pngspan/span.png -d "start_timestamp=[START_TIMESTAMP]&end_timestamp=[END_TIMESTAMP]&width=[WIDTH]&id=[CAMERA_ID]&foreground_color=[FOREGROUND_COLOR]&background_color=[BACKGROUND_COLOR]&table=[TABLE]&A=[AUTH_KEY]"
```

PNG images can be retrieved for supporting metric visualization. PNG types include

  * span
  * etag
  * event
  * setting
  * purge

### HTTP要求

`GET https://login.eagleeyenetworks.com/pngspan/{png_type}.png`

パラメータ          		| データ型式     | 詳細          | 必須？
---------          		| -----------   | -----------   | -----------
**start_timestamp**		| 文字列        | Start Timestamp in EEN format: [YYYYMMDDHHMMSS.NNN](#een-timestamp) | true
**end_timestamp**  		| 文字列        | End Timestamp in EEN format: [YYYYMMDDHHMMSS.NNN](#een-timestamp) | true
**width**         		| 整数        	| Width in pixels of resulting PNG. Must be an integer greater than 0. | true
**id**         			| 文字列        | Camera Id | true
**foreground_color**    | 文字列        | Color of foreground (active). If both fg and bg have 0 for alpha, assumed fully opaque (0xff). 32bit ARGB color. | true
**background_color**    | 文字列        | Color of background (inactive). 32bit ARGB color. | true
table    				| 文字列, enum  | If provided, specifies name of table to be rendered. Required for type 'span' and 'event'. <br><br>enum: stream, onoff, video, register
etag    				| 文字列        | Indentifies etag to be rendered, using the 4 character string identifier ('4CC'). Will utilize matching event tables where possible. Ignored for type 'span' and 'event'.
flval    				| 文字列        | Identified value of the filter field from the starting etag. Only applicable for type 'span'.
flname					| 文字列 		| Name of field within span start etag to match to flval. Interesting fields are roiid in roim table and videoid for video. Only applicable for type 'span'.
flflags    				| 文字列        | Limits span rendering to spans with the flag asserted. ALERTS is asserted for roim and motion spans when an alert is active.

HTTP 状態コード    | データ型式   
------------------- | ----------- 
200 | Request succeeded
401 | Unauthorized due to invalid session
404 | Not found if camera, etag or table cannot be found
408 | Required arguments are missing or invalid
500 | Problem occurred during data processing or rendering