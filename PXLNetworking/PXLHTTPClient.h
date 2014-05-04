//
//  PXLHTTPClient.h
//  PXLNetworking
//
// Copyright (c) 2014 Jason Silberman
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

@import Foundation;

@class PXLHTTPOperation;

typedef enum {
	PXLHTTPRequestTypePOST,
	PXLHTTPRequestTypeGET,
	PXLHTTPRequestTypePUT,
	PXLHTTPRequestTypePATCH,
	PXLHTTPRequestTypeDELETE
} PXLHTTPRequestType;

@interface PXLHTTPClient : NSObject

///---------------------
/// @name Initialization
///---------------------

/**
 Returns the shared `PXLHTTPClient` object.
 */
+ (instancetype)sharedClient;

///---------------------------
/// @name Making HTTP Requests
///---------------------------

/**
 Creates and runs a `-sendHTTPRequest:success:failure` with a POST request.
 
 @param URLString The URL string used to make the request URL.
 @param parameters The parameters to be sent with the request.
 @param success A block object to be called with the request finishes successfully. This block has no return value and takes a two arguments: the HTTP operation and the response object.
 @param failure A block object to be called with the request finishes unsuccessfully. This block has no return value and takes a three arguments: the HTTP operation and the error describing the network or parsing error that occurred.
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;

/**
 Creates and runs a `-sendHTTPRequest:success:failure` with a GET request.
 
 @param URLString The URL string used to make the request URL.
 @param parameters The parameters to be sent with the request.
 @param success A block object to be called with the request finishes successfully. This block has no return value and takes a two arguments: the HTTP operation and the response object.
 @param failure A block object to be called with the request finishes unsuccessfully. This block has no return value and takes a three arguments: the HTTP operation and the error describing the network or parsing error that occurred.
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;

/**
 Creates and runs a `-sendHTTPRequest:success:failure` with a PUT request.
 
 @param URLString The URL string used to make the request URL.
 @param parameters The parameters to be sent with the request.
 @param success A block object to be called with the request finishes successfully. This block has no return value and takes a two arguments: the HTTP operation and the response object.
 @param failure A block object to be called with the request finishes unsuccessfully. This block has no return value and takes a three arguments: the HTTP operation and the error describing the network or parsing error that occurred.
 */
- (void)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;

/**
 Creates and runs a `-sendHTTPRequest:success:failure` with a PATCH request.
 
 @param URLString The URL string used to make the request URL.
 @param parameters The parameters to be sent with the request.
 @param success A block object to be called with the request finishes successfully. This block has no return value and takes a two arguments: the HTTP operation and the response object.
 @param failure A block object to be called with the request finishes unsuccessfully. This block has no return value and takes a three arguments: the HTTP operation and the error describing the network or parsing error that occurred.
 */
- (void)PATCH:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;

/**
 Creates and runs a `-sendHTTPRequest:success:failure` with a DELETE request.
 
 @param URLString The URL string used to make the request URL.
 @param parameters The parameters to be sent with the request.
 @param success A block object to be called with the request finishes successfully. This block has no return value and takes a two arguments: the HTTP operation and the response object.
 @param failure A block object to be called with the request finishes unsuccessfully. This block has no return value and takes a three arguments: the HTTP operation and the error describing the network or parsing error that occurred.
 */
- (void)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;

/**
 Creates and runs a `-sendHTTPRequest:success:failure`.
 
 @param URLString The URL string used to make the request URL.
 @param parameters The parameters to be sent with the request.
 @param requestType The PXLHTTPRequestType used to make the request. Either POST, GET, PUT, PATCH, or DELETE.
 @param headers The headers to be sent with the request.
 @param success A block object to be called with the request finishes successfully. This block has no return value and takes a two arguments: the HTTP operation and the response object.
 @param failure A block object to be called with the request finishes unsuccessfully. This block has no return value and takes a three arguments: the HTTP operation and the error describing the network or parsing error that occurred.
 */
- (void)ANY:(NSString *)URLString parameters:(NSDictionary *)parameters requestType:(PXLHTTPRequestType)requestType headers:(NSDictionary *)headers success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;

/**
 Creates and runs a `-shoveRequest:withCompletion` on `PXLURLSession`.
 
 @param request The NSURLRequest used to make the request.
 @param success A block object to be called with the request finishes successfully. This block has no return value and takes a two arguments: the HTTP operation and the response object.
 @param failure A block object to be called with the request finishes unsuccessfully. This block has no return value and takes a three arguments: the HTTP operation and the error describing the network or parsing error that occurred.
 */
- (void)sendHTTPRequest:(NSURLRequest *)request success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure;

@end
