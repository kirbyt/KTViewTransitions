//
//  UINavigationController+KTTransitions.h
//
//  Created by Kirby Turner on 4/11/11.
//  Copyright 2011 White Peak Software Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UINavigationController+KTTransitions.h"


@implementation UINavigationController (UINavigationController_KTTransitions)

#pragma mark -
#pragma mark Explode

- (void)kt_pushViewController:(UIViewController *)viewController explodeFromPoint:(CGPoint)fromPoint
{
   UIView *transitionToView = [viewController view];
   CGFloat transitionToAlpha = [transitionToView alpha];
   [transitionToView setAlpha:0.3];
   [transitionToView setFrame:CGRectMake(fromPoint.x, fromPoint.y, 0, 0)];
   
   UIViewController *topViewController = [self topViewController];
   UIView *transitionFromView = [topViewController view];
   [transitionFromView addSubview:transitionToView];

   CGRect bounds = [transitionFromView bounds];
   
   void (^animations)(void) = ^ {
      [transitionToView setFrame:bounds];
      [transitionToView setAlpha:transitionToAlpha];
   };
   
   void (^completion)(BOOL) = ^(BOOL finished) {
      if (finished) {
         [self pushViewController:viewController animated:NO];
      }
   };
   
   [UIView animateWithDuration:0.6 animations:animations completion:completion];
}

- (void)kt_popViewControllerImplodeToPoint:(CGPoint)toPoint
{
   UIViewController *transitionFromViewController = [self topViewController];
   UIView *transitionFromView = [transitionFromViewController view];
   
   [self popViewControllerAnimated:NO];
   
   UIViewController *transitionToViewController = [self topViewController];
   UIView *transitionToView = [transitionToViewController view];
   
   [transitionToView addSubview:transitionFromView];

   void (^animations)(void) = ^ {
      [transitionFromView setFrame:CGRectMake(toPoint.x, toPoint.y, 0, 0)];
      [transitionFromView setAlpha:0.0];
   };
   
   void (^completion)(BOOL) = ^(BOOL finished) {
      [transitionFromView removeFromSuperview];
   };

   [UIView animateWithDuration:0.6 animations:animations completion:completion];
}

#pragma mark -
#pragma mark Slide Up (and pop slide down)
- (void)kt_pushViewController:(UIViewController *)viewController slideUpWithDuration:(NSTimeInterval)duration;
{
   UIViewController *topViewController = [self topViewController];
   UIView *transitionFromView = [topViewController view];

   UIView *transitionToView = [viewController view];

   CGRect frame = [transitionToView frame];
   frame = CGRectOffset(frame, 0, [transitionToView frame].size.height);
   [transitionToView setFrame:frame];
   
   [transitionFromView addSubview:transitionToView];
   
   CGRect bounds = [transitionFromView bounds];
   
   void (^animations)(void) = ^ {
      [transitionToView setFrame:bounds];
   };
   
   void (^completion)(BOOL) = ^(BOOL finished) {
      if (finished) {
         [self pushViewController:viewController animated:NO];
      }
   };
   
   [UIView animateWithDuration:duration animations:animations completion:completion];
}

- (void)kt_popViewController:(UIViewController *)viewController slideDownWithDuration:(NSTimeInterval)duration
{
   UIViewController *transitionFromViewController = [self topViewController];
   UIView *transitionFromView = [transitionFromViewController view];
   
   [self popViewControllerAnimated:NO];
   
   UIViewController *transitionToViewController = [self topViewController];
   UIView *transitionToView = [transitionToViewController view];
   
   [transitionToView addSubview:transitionFromView];
   
   CGRect startFrame = [transitionFromView frame];
   CGRect endFrame = CGRectOffset(startFrame, startFrame.origin.x, startFrame.size.height);
   
   void (^animations)(void) = ^ {
      [transitionFromView setFrame:endFrame];
   };
   
   void (^completion)(BOOL) = ^(BOOL finished) {
      [transitionFromView removeFromSuperview];
   };
   
   [UIView animateWithDuration:duration animations:animations completion:completion];
}

#pragma mark -
#pragma mark Fade In and Out

- (void)kt_pushViewController:(UIViewController *)viewController fadeInWithDuration:(NSTimeInterval)duration
{
   UIViewController *topViewController = [self topViewController];
   UIView *transitionFromView = [topViewController view];
   
   UIView *transitionToView = [viewController view];
   [transitionToView setAlpha:0.0];

   [transitionFromView addSubview:transitionToView];
   
   void (^animations)(void) = ^ {
      [transitionToView setAlpha:1.0];
   };
   
   void (^completion)(BOOL) = ^(BOOL finished) {
      if (finished) {
         [self pushViewController:viewController animated:NO];
      }
   };
   
   [UIView animateWithDuration:duration animations:animations completion:completion];
}

- (void)kt_popViewController:(UIViewController *)viewController fadeOutWithDuration:(NSTimeInterval)duration
{
   UIViewController *transitionFromViewController = [self topViewController];
   UIView *transitionFromView = [transitionFromViewController view];
   
   [self popViewControllerAnimated:NO];
   
   UIViewController *transitionToViewController = [self topViewController];
   UIView *transitionToView = [transitionToViewController view];
   
   [transitionToView addSubview:transitionFromView];
   
   void (^animations)(void) = ^ {
      [transitionFromView setAlpha:0.0];
   };
   
   void (^completion)(BOOL) = ^(BOOL finished) {
      [transitionFromView removeFromSuperview];
   };
   
   [UIView animateWithDuration:duration animations:animations completion:completion];
}

@end
