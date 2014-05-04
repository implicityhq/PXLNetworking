//
//  PXLURLSession.m
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

#import "PXLURLSession.h"

#import "PXLActivityIndicator.h"
#import "PXLHTTPOperation.h"
#import "PXLResponseSerializer.h"

@implementation PXLURLSession
@synthesize urlSession = _urlSession;

- (instancetype)init {
	self = [super init];
	if (self) {
		_urlSession = [NSURLSession sharedSession];
	}
	return self;
}

+ (instancetype)sharedSession {
    static PXLURLSession *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)shoveRequest:(NSURLRequest *)request withCompletion:(void (^)(PXLHTTPOperation *response, id responeObject, NSError *error))completion {
	[[PXLActivityIndicator sharedManager] increaseActivity];
	NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		[[PXLActivityIndicator sharedManager] decreaseActivity];
		
		PXLResponseSerializer *responseSerializer = [PXLResponseSerializer new];
		PXLHTTPOperation *httpOperation = [responseSerializer serialzeURLResponse:response responseData:data andError:error];
		
		httpOperation.URL = [request URL];
		httpOperation.operationDescription = [NSString stringWithFormat:@"%@ %@", request.HTTPMethod, httpOperation.URL];
		
		if (completion) {
			completion(httpOperation, httpOperation.serializedResponseObject, httpOperation.error);
		}
	}];
	[task resume];
}

@end