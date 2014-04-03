//
//  PXLHTTPClient.m
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

#import "PXLHTTPClient.h"

#import "PXLURLSession.h"
#import "PXLHTTPOperation.h"
#import "NSDictionary+PXLNetworkingAdditions.h"
#import "NSString+PXLNetworkingAdditions.h"

@implementation PXLHTTPClient

+ (instancetype)sharedClient {
    static PXLHTTPClient *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure {
	[self callRequestWithURLString:URLString requestType:PXLHTTPRequestTypePOST parameters:parameters headers:nil success:success failure:failure];
}

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure {
	[self callRequestWithURLString:URLString requestType:PXLHTTPRequestTypeGET parameters:parameters headers:nil success:success failure:failure];
}

- (void)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure {
	[self callRequestWithURLString:URLString requestType:PXLHTTPRequestTypePUT parameters:parameters headers:nil success:success failure:failure];
}

- (void)PATCH:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure {
	[self callRequestWithURLString:URLString requestType:PXLHTTPRequestTypePATCH parameters:parameters headers:nil success:success failure:failure];
}

- (void)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure {
	[self callRequestWithURLString:URLString requestType:PXLHTTPRequestTypeDELETE parameters:parameters headers:nil success:success failure:failure];
}

- (void)ANY:(NSString *)URLString parameters:(NSDictionary *)parameters requestType:(PXLHTTPRequestType)requestType headers:(NSDictionary *)headers success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure {
	[self callRequestWithURLString:URLString requestType:requestType parameters:parameters headers:headers success:success failure:failure];
}

- (void)sendHTTPRequest:(NSURLRequest *)request success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure {
	[self createHTTPRequest:request withCompletion:^(PXLHTTPOperation *response, id responseObject, NSError *error) {
		if (! error) {
			if (success) {
				success(response, responseObject);
			}
		} else {
			if (failure) {
				failure(response, error);
			}
		}
	}];
}

- (void)callRequestWithURLString:(NSString *)URLString requestType:(PXLHTTPRequestType)requestType parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers success:(void (^)(PXLHTTPOperation *response, id responseObject))success failure:(void (^)(PXLHTTPOperation *response, NSError *error))failure {
	
	
	NSMutableURLRequest *request = [NSMutableURLRequest new];
	request.HTTPMethod = @"GET";
	
	switch (requestType) {
		case PXLHTTPRequestTypePOST:
			request.HTTPMethod = @"POST";
			break;
		case PXLHTTPRequestTypePUT:
			request.HTTPMethod = @"PUT";
			break;
		case PXLHTTPRequestTypeDELETE:
			request.HTTPMethod = @"DELETE";
			break;
		case PXLHTTPRequestTypePATCH:
			request.HTTPMethod = @"PATCH";
			break;
		default:
			request.HTTPMethod = @"GET";
			break;
	}
	
	if (requestType == PXLHTTPRequestTypeGET) {
		NSURLComponents *components = [NSURLComponents componentsWithString:URLString];
		[components setQuery:[NSString stringWithFormat:@"%@%@%@", pxl_safeString(components.query), components.query ? @"&" : @"", [parameters queryStringValue]]];
		
		[request setURL:[components URL]];
	} else {
		[request setURL:[NSURL URLWithString:URLString]];
		if (parameters) {
			NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
			[request setHTTPBody:postData];
		}
	}
	
	if ([headers count] > 0) {
		for (NSString *key in headers) {
			NSString *value = [headers objectForKey:key];
			[request setValue:value forHTTPHeaderField:key];
		}
	}
	
	[self createHTTPRequest:request withCompletion:^(PXLHTTPOperation *response, id responseObject, NSError *error) {
		if (! error) {
			if (success) {
				success(response, responseObject);
			}
		} else {
			if (failure) {
				failure(response, error);
			}
		}
	}];
}

- (void)createHTTPRequest:(NSURLRequest *)request withCompletion:(void (^)(PXLHTTPOperation *response, id responseObject, NSError *error))completion {
	PXLURLSession *session = [PXLURLSession sharedSession];
	[session shoveRequest:request withCompletion:completion];
}

@end