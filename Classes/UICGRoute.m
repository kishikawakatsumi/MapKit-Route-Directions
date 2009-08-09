//
//  UICGRoute.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGRoute.h"

@implementation UICGRoute

- (id)initWithSteps:(NSArray *)arr {
	self = [super init];
	if (self != nil) {
		array = [arr retain];
		numerOfSteps = [array count];
		steps = [NSMutableArray arrayWithCapacity:numerOfSteps];
		for (NSDictionary *dic in array) {
			UICGStep *step = [UICGStep stepWithDictionary:dic];
			[steps addObject:step];
		}
	}
	return self;
}

- (void)dealloc {
	[array release];
	[steps release];
	[super dealloc];
}

- (UICGStep *)stepAtIndex:(NSInteger)index {
	return nil;
}

- (id)startGeocode {
	return nil;
}

- (id)endGeocode {
	return nil;
}

@end
