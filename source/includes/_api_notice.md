# 利用規約

The following API endpoints are to facilitate presenting and accepting the **Terms of Service**.
Eagle Eye Networks has their own terms of services which will be presented through the [Get Terms of Service for User](#get-terms-of-service-for-user).
Additionally resellers can add their own **Terms of Service** through the [Get Terms of Service for Account](#create-terms-of-service-for-account), which
will then also be presented with Eagle Eye Network's terms.

Resellers can assign their own terms at the master account level or give each sub account custom terms at the sub account level.

The basic work process is as follows:

1. Resellers create their own terms with the [Get Terms of Service for Account](#create-terms-of-service-for-account)
2. Client UI will display terms if not accepted from a [Get Terms of Service for User](#get-terms-of-service-for-user)
3. Client UI will accept the terms from a [Accept Terms of Service for User](#accept-terms-of-service-for-user)

<!--===================================================================-->
## Get Terms of Service for User

> Request

```shell
curl -X GET https://28888.eagleeyenetworks.com/g/account/terms?id=00009436 --cookie "auth_key=[AUTH_KEY]"
```

> Response List

```list
[['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service2', '2', 1, 0, '20150626191625', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service2~2~20150626191625.txt', 'active'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service', '1', 1, 1, '20150626191617', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~1~20150626191617.txt', 'retired'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service', '2', 0, 1, '20150626191622', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~2~20150626191622.txt', 'active'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'EEN_Terms_of_Service', '1.2', 1, 1, '20150626191610', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00000001/EEN_Terms_of_Service~1.2~20150626191610.txt', 'active']]
```

This is to push important terms of service such as "Terms and Conditions (2015)".
The client software must call **GET** to see if the user needs to agree to any new terms of service.
If the user has a **is_compliant** of False then the client software should popup a message box containing the terms of service.
It is preferred to have this as a single combined message box.

If the user agrees to the terms then a **PUT** call should be placed containing array all of the notices.
A past due user is subject to suspension of services, and may not be allowed to login.

### HTTP Request

`GET https://login.eagleeyenetworks.com/g/user/terms`

Parameter  		| Data Type   | Description   	| Is Required
---------  		| ----------- | -----------   	| -----------
**id**   		| string      | User Id 		| false

### HTTP List Attributes

Parameter 	| Data Type     | Description
---------  	| -----------   | -----------
user_id 	| string 		| Unique identifier for validated user
title       | string 		| Title of the terms of service
url         | string        | Url of a file with the text of the terms of service
version     | string  		| Version string for the title of the terms of service
is_compliant| bool          | If False then the user needs to accept the terms of service

### Error Status Codes

HTTP Status Code    | Data Type
------------------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
406	| Information supplied could not be verified
402	| Account is suspended
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm


<!--===================================================================-->
## Accept Terms of Service for User
  This is called to record acceptance of the notice.
  Account Super Users will not be able to accept for other people.

> Request

```shell
curl -X PUT https://28888.eagleeyenetworks.com/g/user/terms -d '{"id": "cafe81f5", "urls": ["https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service2~2~20150626191625.txt", "https://login.eagleeyenetworks.com/static_assets/terms_of_service/00000001/EEN_Terms_of_Service~1.2~20150626191610.txt"]}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

> Response Json

``` json
{'id': 'cafe81f5'}
```

### HTTP Request

`PUT https://login.eagleeyenetworks.com/g/user/terms`

Parameter  		| Data Type     | Description                     | Is Required
---------  		| -----------   | -----------   	              | -----------
**urls**        | array[string] | Array of urls that are accepted | true

### HTTP Json
Parameter  		| Data Type   | Description
---------  		| ----------- | -----------
**id**          | string      | user id

### Error Status Codes
 Code    | Data Type
-------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404 | Notice Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## Create Terms of Service for Account

Master Accounts (Resellers) may require their own terms of service.
For that case, this api endpoint is to submit the text of the terms of service.

New terms can be submitted with a PUT command, then a GET command can be done to see the state of the terms.
**PUT** will retire **terms of service** of the same title and account.
Notices can be stored in the sub account or the parent account of the user.
Resellers are limited to 5 terms of service titles and each title will only have one active version.

* Only master accounts can **PUT** an account's terms of service


> Request

```shell
curl -X PUT https://28888.eagleeyenetworks.com/g/account/terms -d '{"is_admin_required": 1, "is_user_required": 1, "title": "Test Terms of Service", "text": "This is a test terms and service from resellers", "version": "1", "id": "00009436"}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

> Response Json

``` json
{'status': 'active', 'is_admin_required': 1, 'is_user_required': 1, 'title': 'Test_Terms_of_Service', 'url': 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~1~20150626191617.txt', 'timestamp': '20150626191617', 'version': '1', 'user': 'cafebead', 'account_id': '00009074'}
```

### HTTP Request

`PUT https://login.eagleeyenetworks.com/g/account/terms`

Parameter  		   | Data Type       | Description   	                            | Is Required   | Default                  | Limitation
---------  		   | -----------     | -----------                  	            | -----------   | -------                  | ----------
text               | string          | Text of the terms to accept                  | true          |                          |  use single LF character for line break
id                 | string          | Unique id of the Account                     | false         | requester's account      |
title              | string          | Title of the terms to accept                 | false         | "Terms and Conditions"   | 32 bytes of alpha numeric characters
version            | string          | Version of the title, which should be unique | false         | auto incrementing number | 32 bytes of alpha numeric characters
is_admin_required  | bool            | If admins have to accept                     | false         | not updating             |
is_user_required   | bool            | If users have to accept                      | false         | not updating             |
timestamp          | string          | Date the terms goes into affect              | false         | now                      |

### HTTP JSON Attributes
Parameter 	           | Data Type     | Description
---------  	           | -----------   | -----------
title                  | string        | Title of the notice
version                | int           | Version number for the notice title, a larger version number will retire other versions
is_admin_required      | bool          | If admins have to accept
is_user_required       | bool          | If users have to accept
timestamp              | string        | date of the  term of service
url                    | string        | URL of the file containing the text for the notice
status                 | string        | Status of the term of service (active, retired)

### Error Status Codes
 Code    | Data Type
-------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404 | Terms Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->
## Update Terms of Service for Account

Updates an account terms of service as specified by Put Terms of Service for Account.
Users are not required to accept terms of the same version again, so if users should be forced to accept again then PUT should be done

* Only master account can **Post** an account's terms of service

> Request

```shell
curl -X POST https://28888.eagleeyenetworks.com/g/account/terms -d '{"is_admin_required": 0, "is_user_required": 1, "title": "Test Terms of Service", "text": "This is a test terms and service from resellers", "version": "2", "id": "00009436"}' -H "content-type: application/json" --cookie "auth_key=[AUTH_KEY]"
```

> Response Json

``` json
{'status': 'active', 'is_admin_required': 0, 'is_user_required': 1, 'title': 'Test_Terms_of_Service', 'url': 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~2~20150626191622.txt', 'timestamp': '20150626191622', 'version': '1', 'user': 'cafebead', 'account_id': '00009074'}
```

### HTTP Request

`POST https://login.eagleeyenetworks.com/g/account/terms`

Parameter  		   | Data Type       | Description   	                            | Is Required   | Default                  | Limitation
---------  		   | -----------     | -----------                  	            | -----------   | -------                  | ----------
text               | string          | Text of the terms to accept                  | false         |                          |  use single LF character for line break
id                 | string          | Unique id of the Account                     | false         | requester's account      |
title              | string          | Title of the terms to accept                 | false         | "Terms and Conditions"   | 32 bytes of alpha numeric characters
version            | string          | Version of the title, which should be unique | false         | auto incrementing number | 32 bytes of alpha numeric characters
is_admin_required  | bool            | If admins have to accept                     | false         | not updating             |
is_user_required   | bool            | If users have to accept                      | false         | not updating             |
timestamp          | string          | Date the term of service goes into affect    | false         | now                      |


### HTTP JSON Attributes
Parameter 	           | Data Type     | Description
---------  	           | -----------   | -----------
title                  | string        | Title of the notice
version                | int           | Version number for the notice title, a larger version number will retire other versions
is_admin_required      | bool          | If admins have to accept
is_user_required       | bool          | If users have to accept
timestamp              | string        | date of the  term of service
url                    | string        | URL of the file containing the text for the notice
status                 | string        | Status of the term of service (active, retired)

### Error Status Codes
 Code    | Data Type
-------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404 | Notice Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm


<!--===================================================================-->
## Delete Terms of Service for Account

This will **retire** a term of service.
* Only master accounts can **DELETE** an account's terms of service

```shell
curl -X DELETE https://28888.eagleeyenetworks.com/g/user/terms?id=cafe81f5 --cookie "auth_key=[AUTH_KEY]"
```

> Response Json

``` json
{ 'cafe81f5': { 'EEN_Terms_of_Service': { '1.2': '20150626193818.274'},
                 'Test_Terms_of_Service': { '2': '20150626193626.502'}}}
```



`DELETE https://login.eagleeyenetworks.com/g/account/terms`

Parameter  		| Data Type   | Description      	| Is Required
---------  		| ----------- | -----------      	| -----------
id   		    | string      | Account Id 		    | false
title           | string      | Title of the terms  | false

### HTTP List Attributes
Parameter 	       | Data Type     | Description
---------  	       | -----------   | -----------
account_id         | string        | Unique Id of the account that is requesting this term of service
account_name       | string        | Name of the account that is requesting this term of service
title              | string        | Title of the term of service
version            | int           | Version number for the term title
is_admin_required  | bool          | If admins have to accept
is_user_required   | bool          | If users have to accept
timestamp          | string        | date of the term of service
url                | string        | URL of the file containing the text for the term of service
status             | string        | This will be **retired**

### Error Status Codes
 Code    | Data Type
-------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
402	| Account is suspended
404 | Notice Title was not found
406	| Information supplied could not be verified
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

<!--===================================================================-->


## Get Terms of Service for Account

> Request

```shell
curl -X GET https://28888.eagleeyenetworks.com/g/account/terms?id=00009436 --cookie "auth_key=[AUTH_KEY]"
```

> Response List

```list
[['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service2', '2', 1, 0, '20150626191625', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service2~2~20150626191625.txt', 'active'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service', '1', 1, 1, '20150626191617', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~1~20150626191617.txt', 'retired'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'Test_Terms_of_Service', '2', 0, 1, '20150626191622', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00009074/Test_Terms_of_Service~2~20150626191622.txt', 'active'], ['00009436', 'UNIT_TEST_SUB_ACCOUNT', 'EEN_Terms_of_Service', '1.2', 1, 1, '20150626191610', 'https://login.eagleeyenetworks.com/static_assets/terms_of_service/00000001/EEN_Terms_of_Service~1.2~20150626191610.txt', 'active']]
```

### HTTP Request

`GET https://login.eagleeyenetworks.com/g/account/terms`

Parameter  		| Data Type   | Description   	| Is Required
---------  		| ----------- | -----------   	| -----------
**id**   		| string      | Account Id 		| false

### HTTP List Attributes
Parameter 	           | Data Type     | Description
---------  	           | -----------   | -----------
account_id             | string        | Unique Id of the account that is requesting this notice
account_name           | string        | Name of the account that is requesting this notice
title                  | string        | Title of the notice
version                | int           | Version number for the notice title, a larger version number will retire other versions
is_admin_required      | bool          | If admins have to accept
is_user_required       | bool          | If users have to accept
timestamp              | string        | date of the term of service
url                    | string        | URL of the file containing the text for the notice
status                 | string        | Status of the term of service (active, retired)

### Error Status Codes

HTTP Status Code    | Data Type
------------------- | -----------
400 | Unexpected or non-identifiable arguments are supplied
406	| Information supplied could not be verified
402	| Account is suspended
460	| Account is inactive
409	| Account has already been activated
412	| User is disabled
200	| User has been authorized for access to the realm

