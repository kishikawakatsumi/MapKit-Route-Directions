//
//  UICGRoute.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICGStep.h"

@interface UICGRoute : NSObject {
	NSArray *array;
	NSInteger numerOfSteps;
	NSMutableArray *steps;
	NSDictionary *distance;
	NSDictionary *duration;
}

- (UICGStep *)stepAtIndex:(NSInteger)index;
- (id)startGeocode;
- (id)endGeocode;

@end
