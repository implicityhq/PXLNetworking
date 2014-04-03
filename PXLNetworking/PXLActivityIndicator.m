//
//  PXLActivityIndicator.m
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

#import "PXLActivityIndicator.h"

@interface PXLActivityIndicator ()

@property (nonatomic, assign) unsigned int activityCounter;

@end

@implementation PXLActivityIndicator

+ (instancetype)sharedManager {
    static PXLActivityIndicator *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.activityCounter = 0;
    }
    return self;
}

- (void)increaseActivity {
	
	@synchronized (self) {
		self.activityCounter++;
	}
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self updateActivity];
	});
}

- (void)decreaseActivity {
	
    @synchronized (self) {
		if (self.activityCounter > 0) {
			 self.activityCounter--;
		}
    }
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self updateActivity];
	});
}

- (void)stopActivity {
    self.activityCounter = 0;
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self updateActivity];
	});
}

- (void)setEnabled:(BOOL)enabled {
	_enabled = enabled;
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self updateActivity];
	});
}

#pragma mark - Private

- (void)updateActivity {
	UIApplication *application = [UIApplication sharedApplication];
	if (self.enabled) {
		application.networkActivityIndicatorVisible = (self.activityCounter > 0);
		_isVisible = (self.activityCounter > 0);
	} else {
		application.networkActivityIndicatorVisible = NO;
		_isVisible = NO;
	}
}

@end
