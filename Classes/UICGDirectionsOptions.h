//
//  UICGDirectionsOptions.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum UICGTravelModes {
	UICGTravelModeDriving, // G_TRAVEL_MODE_DRIVING
	UICGTravelModeWalking  // G_TRAVEL_MODE_WALKING
} UICGTravelModes;

@interface UICGDirectionsOptions : NSObject {
	NSLocale *locale;
	UICGTravelModes travelMode;
	BOOL avoidHighways;
	BOOL getPolyline;
	BOOL getSteps;
	BOOL preserveViewport;
}

@property (nonatomic, retain) NSLocale *locale;
@property (nonatomic) UICGTravelModes travelMode;
@property (nonatomic) BOOL avoidHighways;
@property (nonatomic) BOOL getPolyline;
@property (nonatomic) BOOL getSteps;
@property (nonatomic) BOOL preserveViewport;

@end
