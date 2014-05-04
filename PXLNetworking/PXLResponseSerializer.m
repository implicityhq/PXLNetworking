//
//  PXLResponseSerializer.m
//  Example
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


#import "PXLResponseSerializer.h"
#import "PXLHTTPOperation.h"

@implementation PXLResponseSerializer

#pragma mark - API

- (PXLHTTPOperation *)serialzeURLResponse:(NSURLResponse *)response responseData:(NSData *)responseData andError:(NSError *)error {
	PXLHTTPOperation *operation = [PXLHTTPOperation new];
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	
	if (error) {
		operation.error = error;
		return operation;
	}
	
	operation.rawResponseData = responseData;
	operation.responseHeaders = [httpResponse allHeaderFields];
	operation.serializedResponseObject = [self serializeResponseObject:responseData withContentType:[self responseTypeForHTTPResponse:httpResponse]];
	
	return operation;
}

- (id)serializeResponseObject:(NSData *)responseObject withContentType:(PXLResponseContentType)contentType {
	id serialzedObject;
	switch (contentType) {
		case PXLResponseContentTypeJSON:
			serialzedObject = [self serializeJSONResponseObject:responseObject];
			break;
		case PXLResponseContentTypeTextHtml:
			serialzedObject = [self serializeTextResponseObject:responseObject];
			break;
		case PXLResponseContentTypeTextPlain:
			serialzedObject = [self serializeTextResponseObject:responseObject];
			break;
		default:
			serialzedObject = nil;
			break;
	}
	return serialzedObject;
}

#pragma mark - Serializers

- (NSDictionary *)serializeJSONResponseObject:(NSData *)responseObject {
	return [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
}

- (NSString *)serializeTextResponseObject:(NSData *)responseObject {
	return [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
}

#pragma mark - Private

- (PXLResponseContentType)responseTypeForHTTPResponse:(NSHTTPURLResponse *)response {
	NSArray *parts = [[[response allHeaderFields] objectForKey:@"Content-Type"] componentsSeparatedByString:@";"];
	
	if ([parts[0]  isEqualToString:@"application/json"]) {
		return PXLResponseContentTypeJSON;
	} else if ([parts[0]  isEqualToString:@"text/plain"]) {
		return PXLResponseContentTypeTextPlain;
	} else if ([parts[0]  isEqualToString:@"text/html"]) {
		return PXLResponseContentTypeTextHtml;
	}
	
	return PXLResponseContentTypeWildcard;
}

@end
