//
//  PXLActivityIndicator.h
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

@interface PXLActivityIndicator : NSObject

/**
 A Boolean indicating whether the manager is enabled.
 
 The default is NO.
 */
@property (nonatomic, assign, getter = isEnabled) BOOL enabled;

/**
 A Boolean indicating whether the network activity indicator is currently displaying.
 */
@property (readonly, nonatomic, assign) BOOL isVisible;

/**
 Returns the shared network activity indicator.
 
 @return the network activity indicator manager used in PXLNetworking.
 */
+ (instancetype)sharedManager;

/**
 Increases the number of active network requests.
 */
-(void)increaseActivity;

/**
 Decreases the number of active network requests.
 */
-(void)decreaseActivity;

/**
 Stops the activity indicator, and sets the number of active requests to zero.
 */
-(void)stopActivity;

@end
