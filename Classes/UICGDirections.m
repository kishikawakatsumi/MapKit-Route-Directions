//
//  UICGDirections.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGDirections.h"
#import "JSON.h"

static UICGDirections *sharedDirections;

@implementation UICGDirections

@synthesize delegate;
@synthesize polyline;
@synthesize distance;
@synthesize duration;

+ (UICGDirections *)sharedDirections {
	if (!sharedDirections) {
		sharedDirections = [[UICGDirections alloc] init];
	}
	return sharedDirections;
}

- (id)init {
	self = [super init];
	if (self != nil) {
		googleMapsAPI = [[UICGoogleMapsAPI alloc] init];
		googleMapsAPI.delegate =self;
	}
	return self;
}

- (void)dealloc {
	[googleMapsAPI release];
	[super dealloc];
}

- (void)goolgeMapsAPI:(UICGoogleMapsAPI *)goolgeMapsAPI didGetObject:(NSObject *)object {
	NSDictionary *dictionary = (NSDictionary *)object;
	self.polyline = [UICGPolyline polylineWithDictionary:[dictionary objectForKey:@"polyline"]];
	self.distance = [dictionary objectForKey:@"distance"];
	self.duration = [dictionary objectForKey:@"duration"];
	
	
	if ([self.delegate respondsToSelector:@selector(directionsDidUpdateDirections:)]) {
		[self.delegate directionsDidUpdateDirections:self];
	}
}

- (void)goolgeMapsAPI:(UICGoogleMapsAPI *)goolgeMapsAPI didFailWithMessage:(NSString *)message {
	if ([self.delegate respondsToSelector:@selector(directions:didFailWithMessage:)]) {
		[self.delegate directions:self didFailWithMessage:message];
	}
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"UICGDirections/webViewDidFinishLoad:");
	if ([self.delegate respondsToSelector:@selector(directionsDidFinishInitialize:)]) {
		[self.delegate directionsDidFinishInitialize:self];
	}
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	NSLog(@"UICGDirections/webView:didFailLoadWithError:");
}

- (void)loadWithQuery:(NSString *)query options:(UICGDirectionsOptions *)options {
	[googleMapsAPI stringByEvaluatingJavaScriptFromString:
	 [NSString stringWithFormat:@"loadDirections(%@, %@)", query, [options JSONRepresentation]]];
}

- (void)loadWithStartPoint:(NSString *)startPoint endPoint:(NSString *)endPoint options:(UICGDirectionsOptions *)options {
	[googleMapsAPI stringByEvaluatingJavaScriptFromString:
	 [NSString stringWithFormat:@"loadDirections('%@', '%@', 'ja_JP')", startPoint, endPoint, [options JSONRepresentation]]];
}

- (void)loadFromWaypoints:(NSArray *)waypoints options:(UICGDirectionsOptions *)options {
	
}

- (void)clear {
	
}

- (NSDictionary *)status {
	return nil;
}

- (NSInteger)numberOfRoutes {
	return 0;
}

- (UICGRoute *)routeAtIndex:(NSInteger)index {
	return nil;
}

- (NSInteger)numberOfGeocodes {
	return 0;
}

- (NSDictionary *)geocodeAtIndex:(NSInteger)index {
	return nil;
}

- (NSDictionary *)distance {
	return nil;
}

- (NSDictionary *)duration {
	return nil;
}

@end
