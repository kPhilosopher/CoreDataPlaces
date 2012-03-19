//
//  UIActivityIndicatorView+Additions.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/17/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIActivityIndicatorView (Additions)

#pragma mark - Class method

+ (UIActivityIndicatorView *)activityIndicatorOnKIFTestableViewWithNavigationController:(UINavigationController *)navigationController;
+ (void)removeKIFAndActivityIndicatorView:(UIActivityIndicatorView *)activityIndicator;

@end
