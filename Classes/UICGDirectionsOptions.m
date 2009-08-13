//
//  UICGDirectionsOptions.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGDirectionsOptions.h"

@implementation UICGDirectionsOptions

@synthesize locale;
@synthesize travelMode;
@synthesize avoidHighways;
@synthesize getPolyline;
@synthesize getSteps;
@synthesize preserveViewport;

- (id)init {
	self = [super init];
	if (self != nil) {
		locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
		travelMode = UICGTravelModeDriving;
		avoidHighways = NO;
		getPolyline = YES;
		getSteps = YES;
		preserveViewport = NO;
	}
	return self;
}

- (void)dealloc {
	[locale release];
	[super dealloc];
}

- (NSString *)JSONRepresentation {
	return [NSString stringWithFormat:
			@"{ 'locale': '%@', travelMode: %@, avoidHighways: %@, getPolyline: %@, getSteps: %@, preserveViewport: %@}", 
			[locale localeIdentifier], 
			travelMode == UICGTravelModeDriving ? @"G_TRAVEL_MODE_DRIVING" : @"G_TRAVEL_MODE_WALKING",
			avoidHighways ? @"true" : @"false",
			getPolyline ? @"true" : @"false",
			getSteps ? @"true" : @"false",	
			preserveViewport ? @"true" : @"false"];
}

@end
