//
//  UICGPolyline.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGPolyline.h"

@implementation UICGPolyline

@synthesize routePoints;
@synthesize vertexCount;
@synthesize length;

+ (UICGPolyline *)polylineWithDictionary:(NSDictionary *)dic {
	UICGPolyline *polyline = [[UICGPolyline alloc] initWithDictionary:dic];
	return [polyline autorelease];
}

- (id)initWithDictionary:(NSDictionary *)dic {
	self = [super init];
	if (self != nil) {
		dictionary = [dic retain];
		
		vertices = [[dictionary objectForKey:@"j"] retain];
		vertexCount = [vertices count];
		routePoints = [NSMutableArray arrayWithCapacity:vertexCount];
		for (NSDictionary *vertex in vertices) {
			CLLocationDegrees latitude  = [[vertex objectForKey:@"y"] doubleValue];
			CLLocationDegrees longitude = [[vertex objectForKey:@"x"] doubleValue];
			CLLocation *location = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
			[routePoints addObject:location];
		}
	}
	return self;
}

- (void)dealloc {
	[dictionary release];
	[vertices release];
	[super dealloc];
}

- (CLLocation *)vertexAtIndex:(NSInteger)index {
	return [routePoints objectAtIndex:index];
}

- (void)insertVertexAtIndex:(NSInteger)index inLocation:(CLLocation *)location {
	//TODO
}

@end
