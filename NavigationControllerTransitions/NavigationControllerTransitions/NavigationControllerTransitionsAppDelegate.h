//
//  NavigationControllerTransitionsAppDelegate.h
//  NavigationControllerTransitions
//
//  Created by Kirby Turner on 4/14/11.
//  Copyright 2011 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationControllerTransitionsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
