//
//  RootViewController.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//

@interface RootViewController : UITableViewController<UITextFieldDelegate> {
	UITextField *startField;
	UITextField *endField;
	NSMutableArray *wayPointFields;
	UISegmentedControl *travelModeSegment;
    UIBarButtonItem *addButton;
    UIBarButtonItem *removeButton;
}

@end
