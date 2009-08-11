//
//  UICGoogleMapsAPI.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UICGPolyline, UICGoogleMapsAPI;

@protocol UICGoogleMapsAPIDelegate<NSObject>
@optional
- (void)goolgeMapsAPI:(UICGoogleMapsAPI *)goolgeMapsAPI didGetObject:(NSObject *)object;
- (void)goolgeMapsAPI:(UICGoogleMapsAPI *)goolgeMapsAPI didFailWithMessage:(NSString *)message;
@end

@interface UICGoogleMapsAPI : UIWebView<UIWebViewDelegate> 
- (void)makeAvailable;
@end
