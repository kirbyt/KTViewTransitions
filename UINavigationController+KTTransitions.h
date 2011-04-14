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

#import <Foundation/Foundation.h>


@interface UINavigationController (UINavigationController_KTTransitions)

- (void)kt_pushViewController:(UIViewController *)viewController explodeFromPoint:(CGPoint)fromPoint;
- (void)kt_popViewControllerImplodeToPoint:(CGPoint)toPoint;

- (void)kt_pushViewController:(UIViewController *)viewController slideUpWithDuration:(NSTimeInterval)duration;
- (void)kt_popViewController:(UIViewController *)viewController slideDownWithDuration:(NSTimeInterval)duration;

- (void)kt_pushViewController:(UIViewController *)viewController fadeInWithDuration:(NSTimeInterval)duration;
- (void)kt_popViewController:(UIViewController *)viewController fadeOutWithDuration:(NSTimeInterval)duration;

@end
