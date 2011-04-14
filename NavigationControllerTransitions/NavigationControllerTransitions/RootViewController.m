//
//  RootViewController.m
//  NavigationControllerTransitions
//
//  Created by Kirby Turner on 4/14/11.
//  Copyright 2011 White Peak Software Inc. All rights reserved.
//

#import "RootViewController.h"
#import "UINavigationController+KTTransitions.h"

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
   
   [[self navigationController] setNavigationBarHidden:YES];
   
   BOOL isRootViewController = ([[[self navigationController] viewControllers] count] == 1);
   
   // Setup menu.
   NSMutableArray *newArray = [[NSMutableArray alloc] init];
   if (isRootViewController) {
      [newArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Push Explode", kDictKeyText, @"pushExplode", kDictKeySelectorName, nil]];
      [newArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Push Slide Up", kDictKeyText, @"pushSlideUp", kDictKeySelectorName, nil]];
      [newArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Push Fade In", kDictKeyText, @"pushFadeIn", kDictKeySelectorName, nil]];
      
   } else {
      [newArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Pop Implode", kDictKeyText, @"popImplode", kDictKeySelectorName, nil]];
      [newArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Pop Slide Down", kDictKeyText, @"popSlideDown", kDictKeySelectorName, nil]];
      [newArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Pop Fade Out", kDictKeyText, @"popFadeOut", kDictKeySelectorName, nil]];
      
   }
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

- (void)pushExplode
{
   NSInteger c = (arc4random() % 10) + 1;
   UIColor *color = [UIColor colorWithRed:(c&4) ? 1.0 : 0.0 green:(c&2) ? 1.0 : 0.0 blue:(c&1) ? 1.0 : 0.0 alpha:1.0];
   
   CGPoint point = CGPointMake(320/2, 480/2);
   UIViewController *newController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
   [[newController view] setBackgroundColor:color];
   [[self navigationController] kt_pushViewController:newController explodeFromPoint:point];
   [newController release];
}

- (void)popImplode
{
   CGPoint point = CGPointMake(320/2, 480/2);
   UIViewController *newController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
   [[self navigationController] kt_popViewControllerImplodeToPoint:point];
   [newController release];
}

- (void)pushSlideUp
{
   NSInteger c = (arc4random() % 10) + 1;
   UIColor *color = [UIColor colorWithRed:(c&4) ? 1.0 : 0.0 green:(c&2) ? 1.0 : 0.0 blue:(c&1) ? 1.0 : 0.0 alpha:1.0];
   
   UIViewController *newController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
   [[newController view] setBackgroundColor:color];
   [[self navigationController] kt_pushViewController:newController slideUpWithDuration:0.6];
   [newController release];
}

- (void)popSlideDown
{
   UIViewController *newController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
   [[self navigationController] kt_popViewController:newController slideDownWithDuration:0.6];
   [newController release];
}

- (void)pushFadeIn
{
   NSInteger c = (arc4random() % 10) + 1;
   UIColor *color = [UIColor colorWithRed:(c&4) ? 1.0 : 0.0 green:(c&2) ? 1.0 : 0.0 blue:(c&1) ? 1.0 : 0.0 alpha:1.0];
   
   UIViewController *newController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
   [[newController view] setBackgroundColor:color];
   [[self navigationController] kt_pushViewController:newController fadeInWithDuration:0.6];
   [newController release];
}

- (void)popFadeOut
{
   UIViewController *newController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
   [[self navigationController] kt_popViewController:newController fadeOutWithDuration:0.6];
   [newController release];
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
