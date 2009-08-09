//
//  MapDirectionsViewController.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "MapDirectionsViewController.h"
#import "UICRouteOverlayMapView.h"
#import "UICGDirections.h"
#import "UICRouteAnnotation.h"

@implementation MapDirectionsViewController

@synthesize startPoint;
@synthesize endPoint;

- (void)dealloc {
	[routeOverlayView release];
	[startPoint release];
	[endPoint release];
    [super dealloc];
}

- (void)loadView {
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f)];
	self.view = contentView;
	[contentView release];
	routeMapView = [[MKMapView alloc] initWithFrame:contentView.frame];
	routeMapView.delegate = self;
	[contentView addSubview:routeMapView];
	[routeMapView release];
	
	routeOverlayView = [[UICRouteOverlayMapView alloc] initWithMapView:routeMapView];
	
	diretions = [UICGDirections sharedDirections];
	diretions.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self update];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)update {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[diretions loadWithStartPoint:startPoint endPoint:endPoint options:nil];
}

- (void)directionsDidFinishInitialize:(UICGDirections *)directions {
	[self update];
}

- (void)directionsDidUpdateDirections:(UICGDirections *)directions {
	UICGPolyline *polyline = [directions polyline];
	NSArray *routePoints = [polyline routePoints];
	[routeOverlayView setRoutes:routePoints];
	
	UICRouteAnnotation *startAnnotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints objectAtIndex:0] coordinate]
																					title:startPoint
																		   annotationType:UICRouteAnnotationTypeStart] autorelease];
	
	[routeMapView addAnnotation:startAnnotation];
	
	UICRouteAnnotation *endAnnotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints lastObject] coordinate]
																					title:endPoint
																		   annotationType:UICRouteAnnotationTypeEnd] autorelease];
	[routeMapView addAnnotation:endAnnotation];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)directions:(UICGDirections *)directions didFailWithMessage:(NSString *)message {
	NSLog(@"%@", message);
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark <MKMapViewDelegate> Methods

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
	routeOverlayView.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
	routeOverlayView.hidden = NO;
	[routeOverlayView setNeedsDisplay];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	static NSString *identifier = @"Annotation";
	MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	
	if(!pinAnnotation) {
		pinAnnotation = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
	}
	
	pinAnnotation.pinColor = [(UICRouteAnnotation *)annotation annotationType] == UICRouteAnnotationTypeStart ? MKPinAnnotationColorGreen : MKPinAnnotationColorRed;
	pinAnnotation.enabled = YES;
	pinAnnotation.canShowCallout = YES;
	
	return pinAnnotation;
}

@end
