//
//  RouteListViewController.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/12.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "RouteListViewController.h"
#import "UICGRoute.h"
#import "UICGStep.h"

@interface UITextView(HTML)
- (void)setContentToHTMLString:(id)fp8;
@end

@implementation RouteListViewController

@synthesize routes;

- (void)dealloc {
	[routes release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop 
																							target:self 
																							action:@selector(dismiss:)] autorelease];
	self.title = NSLocalizedString(@"Routes", nil);
	self.tableView.rowHeight = 60.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismiss:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [routes count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	UICGRoute *route = [routes objectAtIndex:section];
    return [route numerOfSteps];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	UICGRoute *route = [routes objectAtIndex:section];
    return [route.summaryHtml stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20.0f, 2.0f, 280.0f, 56.0f)];
		textView.editable = NO;
		textView.scrollEnabled = NO;
		textView.opaque = YES;
		textView.backgroundColor = [UIColor whiteColor];
		textView.tag = 1;
		[cell addSubview:textView];
        [textView release];
		
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
	UICGRoute *route = [routes objectAtIndex:indexPath.section];
	UICGStep *step = [route stepAtIndex:indexPath.row];
    
	UITextView *textView = (UITextView *)[cell viewWithTag:1];
	[textView setContentToHTMLString:step.descriptionHtml];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}

@end
