//
//  UICGStep.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGStep.h"

@implementation UICGStep

@synthesize dictionaryRepresentation;
@synthesize location;
@synthesize polylineIndex;
@synthesize descriptionHtml;
@synthesize distance;
@synthesize duration;

+ (UICGStep *)stepWithDictionaryRepresentation:(NSDictionary *)dictionary {
	UICGStep *step = [[UICGStep alloc] initWithDictionaryRepresentation:dictionary];
	return [step autorelease];
}

- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary {
	self = [super init];
	if (self != nil) {
		dictionaryRepresentation = [dictionary retain];
		
		NSDictionary *point = [dictionaryRepresentation objectForKey:@"Point"];
		NSArray *coordinates = [point objectForKey:@"coordinates"];
		CLLocationDegrees latitude  = [[coordinates objectAtIndex:0] doubleValue];
		CLLocationDegrees longitude = [[coordinates objectAtIndex:1] doubleValue];
		location = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
		
		id index = [dictionaryRepresentation objectForKey:@"polylineIndex"];
		if (index == [NSNull null]) {
			polylineIndex = -1;
		} else {
			polylineIndex = [index integerValue];
		}
		descriptionHtml = [dictionaryRepresentation objectForKey:@"descriptionHtml"];
		distance = [dictionaryRepresentation objectForKey:@"Distance"];
		duration = [dictionaryRepresentation objectForKey:@"Duration"];
	}
	return self;
}

- (void)dealloc {
	[dictionaryRepresentation release];
	[location release];
	[descriptionHtml release];
	[distance release];
	[duration release];
	[super dealloc];
}

@end
