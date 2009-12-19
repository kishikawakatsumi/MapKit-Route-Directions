//
//  MapDirectionsViewController.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "MapDirectionsViewController.h"
#import "UICRouteOverlayMapView.h"
#import "UICRouteAnnotation.h"
#import "RouteListViewController.h"

@implementation MapDirectionsViewController

@synthesize startPoint;
@synthesize endPoint;
@synthesize wayPoints;
@synthesize travelMode;

- (void)dealloc {
	[routeOverlayView release];
	[startPoint release];
	[endPoint release];
    [wayPoints release];
    [super dealloc];
}

- (void)loadView {
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 372.0f)];
	self.view = contentView;
	[contentView release];
	
	routeMapView = [[MKMapView alloc] initWithFrame:contentView.frame];
	routeMapView.delegate = self;
	routeMapView.showsUserLocation = YES;
	[contentView addSubview:routeMapView];
	[routeMapView release];
	
	routeOverlayView = [[UICRouteOverlayMapView alloc] initWithMapView:routeMapView];
	
	UIBarButtonItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	UIBarButtonItem *currentLocationButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reticle.png"] style:UIBarButtonItemStylePlain target:self action:@selector(moveToCurrentLocation:)] autorelease];
	UIBarButtonItem *mapPinButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"map_pin.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addPinAnnotation:)] autorelease];
	UIBarButtonItem *routesButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showRouteListView:)] autorelease];
	self.toolbarItems = [NSArray arrayWithObjects:currentLocationButton, space, mapPinButton, routesButton, nil];
	[self.navigationController setToolbarHidden:NO animated:NO];
	
	diretions = [UICGDirections sharedDirections];
	diretions.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	if (diretions.isInitialized) {
		[self update];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)update {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	UICGDirectionsOptions *options = [[[UICGDirectionsOptions alloc] init] autorelease];
	options.travelMode = travelMode;
	if ([wayPoints count] > 0) {
		NSArray *routePoints = [NSArray arrayWithObject:startPoint];
		routePoints = [routePoints arrayByAddingObjectsFromArray:wayPoints];
		routePoints = [routePoints arrayByAddingObject:endPoint];
		[diretions loadFromWaypoints:routePoints options:options];
	} else {
		[diretions loadWithStartPoint:startPoint endPoint:endPoint options:options];
	}
}

- (void)moveToCurrentLocation:(id)sender {
	[routeMapView setCenterCoordinate:[routeMapView.userLocation coordinate] animated:YES];
}

- (void)addPinAnnotation:(id)sender {
	UICRouteAnnotation *pinAnnotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[routeMapView centerCoordinate]
																				  title:nil
																		 annotationType:UICRouteAnnotationTypeWayPoint] autorelease];
	[routeMapView addAnnotation:pinAnnotation];
}

- (void)showRouteListView:(id)sender {
	RouteListViewController *controller = [[RouteListViewController alloc] initWithStyle:UITableViewStyleGrouped];
	controller.routes = diretions.routes;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
	[self presentModalViewController:navigationController animated:YES];
	[controller release];
	[navigationController release];
}

#pragma mark <UICGDirectionsDelegate> Methods

- (void)directionsDidFinishInitialize:(UICGDirections *)directions {
	[self update];
}

- (void)directions:(UICGDirections *)directions didFailInitializeWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:[error localizedFailureReason] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
	[alertView release];
}

- (void)directionsDidUpdateDirections:(UICGDirections *)directions {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	// Overlay polylines
	UICGPolyline *polyline = [directions polyline];
	NSArray *routePoints = [polyline routePoints];
	[routeOverlayView setRoutes:routePoints];
	
	// Add annotations
	UICRouteAnnotation *startAnnotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints objectAtIndex:0] coordinate]
																					title:startPoint
																		   annotationType:UICRouteAnnotationTypeStart] autorelease];
	UICRouteAnnotation *endAnnotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints lastObject] coordinate]
																					title:endPoint
																		   annotationType:UICRouteAnnotationTypeEnd] autorelease];
	if ([wayPoints count] > 0) {
		NSInteger numberOfRoutes = [directions numberOfRoutes];
		for (NSInteger index = 0; index < numberOfRoutes; index++) {
			UICGRoute *route = [directions routeAtIndex:index];
			CLLocation *location = [route endLocation];
			UICRouteAnnotation *annotation = [[[UICRouteAnnotation alloc] initWithCoordinate:[location coordinate]
																					   title:[[route endGeocode] objectForKey:@"address"]
																			  annotationType:UICRouteAnnotationTypeWayPoint] autorelease];
			[routeMapView addAnnotation:annotation];
		}
	}
		
	[routeMapView addAnnotations:[NSArray arrayWithObjects:startAnnotation, endAnnotation, nil]];
}

- (void)directions:(UICGDirections *)directions didFailWithMessage:(NSString *)message {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
	[alertView release];
}

#pragma mark <MKMapViewDelegate> Methods

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
	routeOverlayView.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
	routeOverlayView.hidden = NO;
	[routeOverlayView setNeedsDisplay];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
	static NSString *identifier = @"RoutePinAnnotation";
	
	if ([annotation isKindOfClass:[UICRouteAnnotation class]]) {
		MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		if(!pinAnnotation) {
			pinAnnotation = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
		}
		
		if ([(UICRouteAnnotation *)annotation annotationType] == UICRouteAnnotationTypeStart) {
			pinAnnotation.pinColor = MKPinAnnotationColorGreen;
		} else if ([(UICRouteAnnotation *)annotation annotationType] == UICRouteAnnotationTypeEnd) {
			pinAnnotation.pinColor = MKPinAnnotationColorRed;
		} else {
			pinAnnotation.pinColor = MKPinAnnotationColorPurple;
		}
		
		pinAnnotation.animatesDrop = YES;
		pinAnnotation.enabled = YES;
		pinAnnotation.canShowCallout = YES;
		return pinAnnotation;
	} else {
		return [routeMapView viewForAnnotation:routeMapView.userLocation];
	}
}

@end
