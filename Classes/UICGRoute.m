//
//  UICGRoute.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGRoute.h"

@implementation UICGRoute

@synthesize numerOfSteps;
@synthesize steps;
@synthesize distance;
@synthesize duration;
@synthesize summaryHtml;
@synthesize startGeocode;
@synthesize endGeocode;
@synthesize endLocation;
@synthesize polylineEndIndex;

+ (UICGRoute *)routeWithDictionary:(NSDictionary *)dic {
	UICGRoute *route = [[UICGRoute alloc] initWithDictionary:dic];
	return [route autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dic {
	self = [super init];
	if (self != nil) {
		dictionary = [dic retain];
		NSDictionary *k = [dictionary objectForKey:@"k"];
		NSArray *stepDics = [k objectForKey:@"Steps"];
		numerOfSteps = [stepDics count];
		steps = [[NSMutableArray alloc] initWithCapacity:numerOfSteps];
		for (NSDictionary *stepDic in stepDics) {
			[(NSMutableArray *)steps addObject:[UICGStep stepWithDictionary:stepDic]];
		}
		
		endGeocode = [dictionary objectForKey:@"MJ"];
		startGeocode = [dictionary objectForKey:@"dT"];
		
		distance = [k objectForKey:@"Distance"];
		duration = [k objectForKey:@"Duration"];
		NSDictionary *endLocationDic = [k objectForKey:@"End"];
		NSArray *coordinates = [endLocationDic objectForKey:@"coordinates"];
		CLLocationDegrees longitude = [[coordinates objectAtIndex:0] doubleValue];
		CLLocationDegrees latitude  = [[coordinates objectAtIndex:1] doubleValue];
		endLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		summaryHtml = [k objectForKey:@"summaryHtml"];
		polylineEndIndex = [[k objectForKey:@"polylineEndIndex"] integerValue];
	}
	return self;
}

- (void)dealloc {
	[dictionary release];
	[steps release];
	[distance release];
	[duration release];
	[summaryHtml release];
	[startGeocode release];
	[endGeocode release];
	[endLocation release];
	[super dealloc];
}

- (UICGStep *)stepAtIndex:(NSInteger)index {
	return [steps objectAtIndex:index];;
}

@end
