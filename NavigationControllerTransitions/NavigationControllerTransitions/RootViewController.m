//
//  RootViewController.m
//  NavigationControllerTransitions
//
//  Created by Kirby Turner on 4/14/11.
//  Copyright 2011 White Peak Software Inc. All rights reserved.
//

#import "RootViewController.h"

NSString * const kDictKeyText = @"text";
NSString * const kDictKeySelectorName = @"selectorName";

@interface RootViewController ()
@property (nonatomic, retain) NSArray *data;
@end

@implementation RootViewController

@synthesize data = data_;

- (void)dealloc
{
   [data_ release], data_ = nil;
   [super dealloc];
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   [self setTitle:@"Transitions"];
   
   // Setup menu.
   NSMutableArray *newArray = [[NSMutableArray alloc] init];
   [newArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Explode", kDictKeyText, @"explode", kDictKeySelectorName, nil]];
   [self setData:newArray];
   [newArray release];
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
   // Releases the view if it doesn't have a superview.
   [super didReceiveMemoryWarning];
   
   // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
   [super viewDidUnload];
   
   // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
   // For example: self.myOutlet = nil;
}


#pragma mark -
#pragma mark Menu Actions

- (void)explode
{
   NSLog(@"%s", __PRETTY_FUNCTION__);
   /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
   
}

#pragma mark -
#pragma mark UITableViewDataSource and UITableViewDelegate Methods

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [[self data] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"RootViewControllerCell";
   
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
   }
   
   NSDictionary *item = [[self data] objectAtIndex:[indexPath row]];
   [[cell textLabel] setText:[item objectForKey:kDictKeyText]];
   
   // Configure the cell.
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSDictionary *item = [[self data] objectAtIndex:[indexPath row]];
   SEL selector = NSSelectorFromString([item objectForKey:kDictKeySelectorName]);
   [self performSelector:selector];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
