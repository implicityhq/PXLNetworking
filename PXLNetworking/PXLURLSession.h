//
//  PXLURLSession.h
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

@interface PXLURLSession : NSObject

///-----------------
/// @name Properties
///-----------------

/**
 The NSURLSession used in all requests.
 */
@property (nonatomic) NSURLSession *urlSession;

///---------------------
/// @name Initialization
///---------------------

/**
 Returns the shared `PXLURLSession` object.
 */
+ (instancetype)sharedSession;

///---------------------------
/// @name Making HTTP Requests
///---------------------------

/**
 Creates and runs an `NSURLSessionDataTask` with the request.
 
 @param request The NSURLRequest used to make the request.
 @param completion A block object to be executed when the task finishes. This block has no return value and takes a three arguments: the HTTP operation, the response object and the error describing the network or parsing error that occurred.
 */
- (void)shoveRequest:(NSURLRequest *)request withCompletion:(void (^)(PXLHTTPOperation *response, id responeObject, NSError *error))completion;

@end
