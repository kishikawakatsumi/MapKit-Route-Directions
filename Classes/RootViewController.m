//
//  RootViewController.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//

#import "RootViewController.h"
#import "MapDirectionsViewController.h"

@implementation RootViewController

- (void)dealloc {
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	
}

- (void)done:(id)sender {
	if ([startField canResignFirstResponder]) {
		[startField resignFirstResponder];
	}
	if ([endField canResignFirstResponder]) {
		[endField resignFirstResponder];
	}
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}

#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] 
									initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)] autorelease];
	[self.navigationItem setRightBarButtonItem:doneButton animated:YES];
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([textField resignFirstResponder] && textField == startField) {
		[endField becomeFirstResponder];
	}
	return YES;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 2;
	} else if (section == 1) {
		return 1;
	} else {
		return 1;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return NSLocalizedString(@"Directions", nil);
	} else if (section == 1) {
		return NSLocalizedString(@"Travel Mode", nil);
	} else {
		return nil;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", indexPath.section, indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if (indexPath.section == 0 && indexPath.row == 0) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 13.0f, 40.0f, 20.0f)];
		[cell addSubview:textLabel];
		[textLabel release];
		textLabel.text = NSLocalizedString(@"Start:", nil);
		textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		textLabel.textAlignment = UITextAlignmentRight;
		textLabel.textColor = [UIColor lightGrayColor];
		
		UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(66.0, 0.0, 236.0, 44.0)];
		inputField.delegate = self;
		[cell addSubview:inputField];
		[inputField release];
		
		[inputField setBorderStyle:UITextBorderStyleNone];
		[inputField setAdjustsFontSizeToFitWidth:NO];
		[inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
		[inputField setClearsOnBeginEditing:NO];
		[inputField setPlaceholder:nil];
		[inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
		[inputField setAutocorrectionType:UITextAutocorrectionTypeNo];
		[inputField setEnablesReturnKeyAutomatically:YES];
		[inputField setKeyboardType:UIKeyboardTypeDefault];
		[inputField setReturnKeyType:UIReturnKeyNext];
		[inputField setEnablesReturnKeyAutomatically:YES];
		
		[inputField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[inputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
		
		[inputField setText:[NSString stringWithUTF8String:"新宿西口"]];
		
		startField = inputField;
	} else if (indexPath.section == 0 && indexPath.row == 1) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 13.0f, 40.0f, 20.0f)];
		[cell addSubview:textLabel];
		[textLabel release];
		textLabel.text = NSLocalizedString(@"End:", nil);
		textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		textLabel.textAlignment = UITextAlignmentRight;
		textLabel.textColor = [UIColor lightGrayColor];
		
		UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(66.0, 0.0, 236.0, 44.0)];
		inputField.delegate = self;
		[cell addSubview:inputField];
		[inputField release];
		
		[inputField setBorderStyle:UITextBorderStyleNone];
		[inputField setAdjustsFontSizeToFitWidth:NO];
		[inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
		[inputField setClearsOnBeginEditing:NO];
		[inputField setPlaceholder:nil];
		[inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
		[inputField setAutocorrectionType:UITextAutocorrectionTypeNo];
		[inputField setEnablesReturnKeyAutomatically:YES];
		[inputField setKeyboardType:UIKeyboardTypeDefault];
		[inputField setReturnKeyType:UIReturnKeyDone];
		[inputField setEnablesReturnKeyAutomatically:YES];
		
		[inputField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[inputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
		
		[inputField setText:[NSString stringWithUTF8String:"東京ディズニーランド"]];
		
		endField = inputField;
	} else if (indexPath.section == 1 && indexPath.row == 0) {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		travelModeSegment = [[UISegmentedControl alloc] initWithItems:
							 [NSArray arrayWithObjects:NSLocalizedString(@"Driving", nil), 
							  NSLocalizedString(@"Train", nil), 
							  NSLocalizedString(@"Walking", nil), nil]];
		[travelModeSegment setFrame:CGRectMake(9.0f, 0.0f, 302.0f, 45.0f)];
		[travelModeSegment setSelectedSegmentIndex:0];
		[cell addSubview:travelModeSegment];
		[travelModeSegment release];
	} else {
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.textLabel.text = NSLocalizedString(@"Search", nil);
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.textColor = [UIColor blueColor];
	}

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MapDirectionsViewController *controller = [[MapDirectionsViewController alloc] init];
	controller.startPoint = startField.text;
	controller.endPoint = endField.text;
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
