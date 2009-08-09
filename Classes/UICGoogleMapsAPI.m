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
- (void)webView:(id)fp8 runJavaScriptAlertPanelWithMessage:(id)fp12 initiatedByFrame:(id)fp16;
@end

@implementation UICGoogleMapsAPI

- (id)init {
    if (self = [super initWithFrame:CGRectZero]) {
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"api" ofType:@"html"];
		NSString *fileContents = [NSString stringWithContentsOfFile:filePath];
		self.delegate = self;
		[self loadHTMLString:fileContents baseURL:[NSURL URLWithString:@"http://iphone.local/"]];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    // Nothing to do;
}

- (void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
	if ([message hasPrefix:@"ERROR:"]) {
		if ([self.delegate respondsToSelector:@selector(goolgeMapsAPI:didFailWithMessage:)]) {
			[self.delegate goolgeMapsAPI:self didFailWithMessage:message];
		}
		return;
	}
	if ([self.delegate respondsToSelector:@selector(goolgeMapsAPI:didGetObject:)]) {
		[self.delegate goolgeMapsAPI:self didGetObject:[message JSONValue]];
	}
}

@end
