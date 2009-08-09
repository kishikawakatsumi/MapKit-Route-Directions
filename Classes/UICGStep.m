//
//  UICGStep.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGStep.h"

@implementation UICGStep

@synthesize location;
@synthesize polylineIndex;
@synthesize descriptionHtml;
@synthesize distance;
@synthesize duration;

+ (UICGStep *)stepWithDictionary:(NSDictionary *)dic {
	UICGStep *step = [[UICGStep alloc] initWithDictionary:dic];
	return [step autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dic {
	self = [super init];
	if (self != nil) {
		dictionary = [dic retain];
		
		NSDictionary *point = [dictionary objectForKey:@"Point"];
		NSArray *coordinates = [point objectForKey:@"coordinates"];
		CLLocationDegrees latitude  = [[coordinates objectAtIndex:0] doubleValue];
		CLLocationDegrees longitude = [[coordinates objectAtIndex:1] doubleValue];
		location = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
		
		polylineIndex = [[dictionary objectForKey:@"polylineIndex"] integerValue];
		descriptionHtml = [dictionary objectForKey:@"descriptionHtml"];
		distance = [dictionary objectForKey:@"Distance"];
		duration = [dictionary objectForKey:@"Duration"];
	}
	return self;
}

- (void)dealloc {
	[dictionary release];
	[location release];
	[descriptionHtml release];
	[distance release];
	[duration release];
	[super dealloc];
}

@end
