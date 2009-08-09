//
//  UICGDirections.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICGDirectionsOptions.h"
#import "UICGRoute.h"
#import "UICGPolyline.h"
#import "UICGoogleMapsAPI.h"

@class UICGDirections;

@protocol UICGDirectionsDelegate<NSObject>
@optional
- (void)directionsDidFinishInitialize:(UICGDirections *)directions;
- (void)directionsDidUpdateDirections:(UICGDirections *)directions;
- (void)directions:(UICGDirections *)directions didFailWithMessage:(NSString *)message;
@end

@interface UICGDirections : NSObject<UIWebViewDelegate> {
	id<UICGDirectionsDelegate> delegate;
	UICGoogleMapsAPI *googleMapsAPI;
	UICGPolyline *polyline;
	NSDictionary *distance;
	NSDictionary *duration;
}

@property (nonatomic, assign) id<UICGDirectionsDelegate> delegate;
@property (nonatomic, retain) UICGPolyline *polyline;
@property (nonatomic, retain) NSDictionary *distance;
@property (nonatomic, retain) NSDictionary *duration;

+ (UICGDirections *)sharedDirections;
- (id)init;
- (void)loadWithQuery:(NSString *)query options:(UICGDirectionsOptions *)options;
- (void)loadWithStartPoint:(NSString *)startPoint endPoint:(NSString *)endPoint options:(UICGDirectionsOptions *)options;
- (void)loadFromWaypoints:(NSArray *)waypoints options:(UICGDirectionsOptions *)options;
- (void)clear;
- (NSDictionary *)status;
- (NSInteger)numberOfRoutes;
- (UICGRoute *)routeAtIndex:(NSInteger)index;
- (NSInteger)numberOfGeocodes;
- (NSDictionary *)geocodeAtIndex:(NSInteger)index;
- (NSDictionary *)distance;
- (NSDictionary *)duration;
- (UICGPolyline *)polyline;

@end
