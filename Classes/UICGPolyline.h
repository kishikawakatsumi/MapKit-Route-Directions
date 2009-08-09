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
	NSDictionary *dictionary;
	NSArray *vertices;
	NSMutableArray *routePoints;
	NSInteger vertexCount;
	NSInteger length;
}

@property (nonatomic, readonly) NSMutableArray *routePoints;
@property (nonatomic, readonly) NSInteger vertexCount;
@property (nonatomic, readonly) NSInteger length;

+ (UICGPolyline *)polylineWithDictionary:(NSDictionary *)dic;
- (id)initWithDictionary:(NSDictionary *)dic;
- (CLLocation *)vertexAtIndex:(NSInteger)index;
- (void)insertVertexAtIndex:(NSInteger)index inLocation:(CLLocation *)location;

@end
