//
//  RouteListViewController.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/12.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteListViewController : UITableViewController {
	NSArray *routes;
}

@property (nonatomic, retain) NSArray *routes;

@end
