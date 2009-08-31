//
//  MapDirectionsViewController.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UICGDirections.h"

@class UICRouteOverlayMapView;

@interface MapDirectionsViewController : UIViewController<MKMapViewDelegate, UICGDirectionsDelegate> {
	MKMapView *routeMapView;
	UICRouteOverlayMapView *routeOverlayView;
	UICGDirections *diretions;
	NSString *startPoint;
	NSString *endPoint;
	NSArray *wayPoints;
	UICGTravelModes travelMode;
}

@property (nonatomic, retain) NSString *startPoint;
@property (nonatomic, retain) NSString *endPoint;
@property (nonatomic, retain) NSArray *wayPoints;
@property (nonatomic) UICGTravelModes travelMode;

- (void)update;

@end
