//
//  PXLViewController.m
//  PXLNetworking Example
//
//  Created by Jason Silberman on 3/27/14.
//
//

#import "PXLViewController.h"

#import "PXLNetworking.h"

@interface PXLViewController ()

@end

@implementation PXLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[PXLActivityIndicator sharedManager].enabled = YES;
	
	self.title = @"PXLNetworking";
	
	static NSString *url = @"http://httpTests.dev";
	
	NSDictionary *params = @{@"name":@"Bob", @"age" : @15};
	
	[[PXLHTTPClient sharedClient] ANY:url parameters:params requestType:PXLHTTPRequestTypePOST headers:nil success:^(PXLHTTPOperation *response, id responseObject) {
		NSLog(@"%@ %@", response.operationDescription, responseObject);
	} failure:^(PXLHTTPOperation *response, NSError *error) {
		NSLog(@"[%@] %@", response.operationDescription, error);
	}];
	
	[[PXLHTTPClient sharedClient] GET:url parameters:params success:^(PXLHTTPOperation *response, id responseObject) {
		NSLog(@"%@ %@", response.operationDescription, responseObject);
	} failure:^(PXLHTTPOperation *response, NSError *error) {
		NSLog(@"[%@] %@", response.operationDescription, error);
	}];
}

@end
