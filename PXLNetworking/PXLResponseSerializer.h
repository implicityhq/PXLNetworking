//
//  PXLResponseSerializer.h
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


@import Foundation;

@class PXLHTTPOperation;

typedef enum {
	PXLResponseContentTypeJSON,
	PXLResponseContentTypeTextPlain,
	PXLResponseContentTypeTextHtml,
	PXLResponseContentTypeWildcard
} PXLResponseContentType;

@interface PXLResponseSerializer : NSObject

///---------------------------
/// @name Serialization
///---------------------------

/**
 Creates and returns a serialized PXLHTTPOperation object.
 
 @param response The NSURLResponse returned by the request.
 @param responseData The NSData returned by the request.
 @param error The NSError, if any, returned by the request.
 @return PXLHTTPOperation The serialized PXLHTTPOperation object.
 */
- (PXLHTTPOperation *)serialzeURLResponse:(NSURLResponse *)response responseData:(NSData *)responseData andError:(NSError *)error;

/**
 Serializes the response data returned by the request.
 
 If the contentType is PXLResponseContentTypeJSON it returns an NSDictionary. If it is PXLResponseContentTypeTextPlain or PXLResponseContentTypeTextHtml then it returns a string. If it is PXLResponseContentTypeWildcard, it returns an id.
 
 @param responseObject The NSData returned by the request.
 @param contentType The PXLResponseContentType.
 @return id The serialized data.
 */
- (id)serializeResponseObject:(NSData *)responseObject withContentType:(PXLResponseContentType)contentType;

@end
