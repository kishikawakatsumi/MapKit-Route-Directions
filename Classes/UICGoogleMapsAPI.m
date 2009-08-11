//
//  UICGoogleMapsAPI.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGoogleMapsAPI.h"
#import "JSON.h"

@interface UIWebView(JavaScriptEvaluator)
- (void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;
@end

@implementation UICGoogleMapsAPI

- (id)init {
    if (self = [super initWithFrame:CGRectZero]) {
		self.delegate = self;
		[self makeAvailable];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    // Nothing to do.
}

- (void)makeAvailable {
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"api" ofType:@"html"];
	NSString *fileContents = [NSString stringWithContentsOfFile:filePath];
	[self loadHTMLString:fileContents baseURL:[NSURL URLWithString:@"http://iphone.local/"]];
}

- (void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
//	NSLog(@"%@", message);
	id JSONValue = [message JSONValue];
	if (!JSONValue) {
		if ([self.delegate respondsToSelector:@selector(goolgeMapsAPI:didFailWithMessage:)]) {
			[(id<UICGoogleMapsAPIDelegate>)self.delegate goolgeMapsAPI:self didFailWithMessage:message];
		}
		return;
	}
	if ([self.delegate respondsToSelector:@selector(goolgeMapsAPI:didGetObject:)]) {
		[(id<UICGoogleMapsAPIDelegate>)self.delegate goolgeMapsAPI:self didGetObject:JSONValue];
	}
}

@end
