//
//  UICGRoute.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UICGStep.h"

@interface UICGRoute : NSObject {
	NSDictionary *dictionaryRepresentation;
	NSInteger numerOfSteps;
	NSArray *steps;
	NSDictionary *distance;
	NSDictionary *duration;
	NSString *summaryHtml;
	NSDictionary *startGeocode;
	NSDictionary *endGeocode;
	CLLocation *endLocation;
	NSInteger polylineEndIndex;
}

@property (nonatomic, retain, readonly) NSDictionary *dictionaryRepresentation;
@property (nonatomic, readonly) NSInteger numerOfSteps;
@property (nonatomic, retain, readonly) NSArray *steps;
@property (nonatomic, retain, readonly) NSDictionary *distance;
@property (nonatomic, retain, readonly) NSDictionary *duration;
@property (nonatomic, retain, readonly) NSString *summaryHtml;
@property (nonatomic, retain, readonly) NSDictionary *startGeocode;
@property (nonatomic, retain, readonly) NSDictionary *endGeocode;
@property (nonatomic, retain, readonly) CLLocation *endLocation;
@property (nonatomic, assign, readonly) NSInteger polylineEndIndex;

+ (UICGRoute *)routeWithDictionaryRepresentation:(NSDictionary *)dictionary;
- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary;
- (UICGStep *)stepAtIndex:(NSInteger)index;

@end
