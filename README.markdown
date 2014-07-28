PXLNetworking
=============

A simple way to network on iOS without a bunch of fuss.

*PXLNetworking is a super simple class. If you need something more complex I strongly suggest using [AFNetworking](https://github.com/afnetworking/afnetworking).*

## Documentation
You can continue to read this to get a brief overview of PXLNetworking, or you can read the [documentation](http://cocoadocs.org/docsets/PXLNetworking/).

### Migration From v0.1.0 to v1.0.0
There is no difference if you are only using `PXLHTTPClient`. All changes have been made to how response objects are serialized.

## Adding to Your Project
Getting started using PXLNetworking is really easy! You can use Cocoapods or you can do it manually.

### Using CocoaPods
Add the following to your `Podfile`.

```ruby
pod 'PXLNetworking'
```

### Manually
To manually add to your project:

1. Add the files in `PXLNetworking/` to your project.

PXLNetworking requires ARC.

## Usage
Using PXLNetworking is really simple. All you have to do is include `PXLNetworking.h` to the files where you want to use it.

### PXLHTTPClient
PXLNetworking has one main class, `PXLHTTPClient`.

PXLHTTPClient has the following methods:

```objc

+ (instancetype)sharedClient; // Use this to get the global PXLHTTPClient instance

- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;
- (void)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;
- (void)PATCH:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;
- (void)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;
- (void)ANY:(NSString *)URLString parameters:(NSDictionary *)parameters requestType:(PXLHTTPRequestType)requestType headers:(NSDictionary *)headers success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;

- (void)sendHTTPRequest:(NSURLRequest *)request success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;
```

Using PXLHTTPClient is pretty straight forward, although some of the methods may look complicated.

To get the global PXLHTTPClient instance, call the `+sharedClient` method.

#### `GET` Request
To send a simple `GET` HTTP request do this:

```objc

PXLHTTPClient *client = [PXLHTTPClient sharedClient];
[client GET:@"http://example.com/things.json" parameters:nil success:^(PXLHTTPOperation *response, id responseObject) {
	NSLog(@"[Success] %@ %@", response.operationDescription, responseObject);
} failure:^(PXLHTTPOperation *response, NSError *error) {
	NSLog(@"[Error] %@", error);
}];
```

#### `POST` Encoded Request
To send a `POST` HTTP request with parameters do this:

```objc

PXLHTTPClient *client = [PXLHTTPClient sharedClient];
NSDictionary *params = @{@"bar": @"foo"};
[client POST:@"http://example.com/things.json" parameters:params success:^(PXLHTTPOperation *response, id responseObject) {
	NSLog(@"[Success] %@ %@", response.operationDescription, responseObject);
} failure:^(PXLHTTPOperation *response, NSError *error) {
	NSLog(@"[Error] %@", error);
}];
```

#### `POST` Request With Headers
To send a `POST` HTTP request with headers and/or parameters do this:

```objc

PXLHTTPClient *client = [PXLHTTPClient sharedClient];
NSDictionary *headers = @{@"Content-Type" : @"application/json"};
[client ANY:@"http://example.com/things.json" parameters:nil requestType:PXLHTTPRequestTypePOST headers:headers success:^(PXLHTTPOperation *response, id responseObject) {
	NSLog(@"[Success] %@ %@", response.operationDescription, responseObject);
} failure:^(PXLHTTPOperation *response, NSError *error) {
	NSLog(@"[Error] %@", error);
}];
```

The `requestType:` can be any of the following: `PXLHTTPRequestTypePOST` to send `POST` requests, `PXLHTTPRequestTypeGET` to send `GET` requests, `PXLHTTPRequestTypePUT` to send `PUT` requests, `PXLHTTPRequestTypePATCH` to send `PATCH` requests, or `PXLHTTPRequestTypeDELETE` to send `DELETE` requests.

#### Response
In all the above methods, in both the success block a `PXLHTTPOperation` and its `.serializedResponseObject` property, and in the failure block a `PXLHTTPOperation` and its `.error` property.

### PXLHTTPOperation
In all of the callback blocks, a `PXLHTTPOperation` is returned.

PXLHTTPOperation employs the following properties:

```objc

(id) serializedResponseObject
// The serialized response object.

(id) rawResponseData
// The raw response data returned by the NSURLSessionDataTask.

(NSDictionary) responseHeaders
// The headers returned by the NSURLSessionDataTask.

(NSError) error
// The error returned by the NSURLSessionDataTask, nil if successful.

(NSURL) URL
// The URL used for making the request.

(NSString) operationDescription;
// The operation description. Example: GET http://example.com
```

### PXLActivityIndicator
PXLNetworking also comes with a network activity indicator. You should enable the shared instance of `PXLActivityIndicator` in your `-[AppDelegate application:didFinishLaunchingWithOptions:]` by doing this:

```objc

[PXLActivityIndicator sharedManager].enabled = YES;
```

## Credits
PXLNetworking is partially based off of the amazing [AFNetworking](https://github.com/afnetworking/afnetworking) by [Mattt Thompson](https://github.com/mattt/) and [Scott Raymond](https://github.com/sco/).

## License
PXLNetworking is available under the MIT license. See the LICENSE file for more info.
