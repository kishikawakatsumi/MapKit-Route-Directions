//
//  UICRouteOverlayMapView.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface UICRouteOverlayMapView : UIView {
	MKMapView *inMapView;
	NSArray *routes;
	UIColor *lineColor;
}

- (id)initWithMapView:(MKMapView *)mapView;

@property (nonatomic, retain) MKMapView *inMapView;
@property (nonatomic, retain) NSArray *routes;
@property (nonatomic, retain) UIColor *lineColor; 
@end
