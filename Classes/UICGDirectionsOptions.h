//
//  UICGDirectionsOptions.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum UICGTravelModes {
	G_TRAVEL_MODE_DRIVING,
	G_TRAVEL_MODE_WALKING
} UICGTravelModes;

@interface UICGDirectionsOptions : NSObject {
	NSLocale *locale;
	UICGTravelModes travelMode;
	BOOL avoidHighways;
	BOOL getPolyline;
	BOOL getSteps;
	BOOL preserveViewport;
}

@end
