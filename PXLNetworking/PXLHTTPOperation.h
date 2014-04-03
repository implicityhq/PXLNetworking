//
//  PXLHTTPResponse.h
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

#import <Foundation/Foundation.h>

@interface PXLHTTPOperation : NSObject

///-----------------
/// @name Properties
///-----------------

/**
 The response object created by the request.
 
 If the request returns `application/json`, it will be an NSDictionary.
 */
@property (nonatomic) id responseObject;

/**
 The raw response data returned by the NSURLSessionDataTask.
 */
@property (nonatomic) id rawResponseData;

/**
 The headers returned by the NSURLSessionDataTask.
 */
@property (nonatomic) NSDictionary *responseHeaders;

/**
 The error returned by the NSURLSessionDataTask, nil if successful.
 */
@property (nonatomic) NSError *error;

/**
 The URL used for making the request.
 */
@property (nonatomic) NSURL *URL;

/**
 The operation descrption.
 
 Example: GET http://example.com
 */
@property (nonatomic) NSString *operationDescription;

@end
