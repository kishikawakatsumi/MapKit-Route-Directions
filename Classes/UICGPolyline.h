//
//  UICGPolyline.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UICGPolyline : NSObject {
	NSDictionary *dictionaryRepresentation;
	NSArray *vertices;
	NSMutableArray *routePoints;
	NSInteger vertexCount;
	NSInteger length;
}

@property (nonatomic, retain, readonly) NSDictionary *dictionaryRepresentation;
@property (nonatomic, retain, readonly) NSMutableArray *routePoints;
@property (nonatomic, readonly) NSInteger vertexCount;
@property (nonatomic, readonly) NSInteger length;

+ (UICGPolyline *)polylineWithDictionaryRepresentation:(NSDictionary *)dictionary;
- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary;
- (CLLocation *)vertexAtIndex:(NSInteger)index;
- (void)insertVertexAtIndex:(NSInteger)index inLocation:(CLLocation *)location;

@end
