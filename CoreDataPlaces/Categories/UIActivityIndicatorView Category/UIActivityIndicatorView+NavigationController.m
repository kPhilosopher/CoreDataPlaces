//
//  UIActivityIndicatorView+NavigationController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/17/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "UIActivityIndicatorView+NavigationController.h"
#import "CPConstants.h"


@implementation UIActivityIndicatorView (NavigationController)

#pragma mark - Class method

+ (UIActivityIndicatorView *)activityIndicatorOnKIFTestableViewWithNavigationController:(UINavigationController *)navigationController;
{
	UIView *theLabel = [[UIView alloc] init];
	theLabel.accessibilityLabel = CPActivityIndicatorMarkerForKIF;
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.color = [UIColor blueColor];
	activityIndicator.hidesWhenStopped = YES;
	activityIndicator.center = CGPointMake(navigationController.view.bounds.size.width/2, navigationController.view.bounds.size.height/2);
	theLabel.frame = activityIndicator.frame;
	activityIndicator.center = CGPointMake(theLabel.bounds.size.width/2, theLabel.bounds.size.height/2);
	activityIndicator.accessibilityLabel = @"Activity indicator";
	activityIndicator.hidesWhenStopped = YES;
	[navigationController.view addSubview:theLabel];
	[theLabel addSubview:activityIndicator];
	[theLabel release]; theLabel = nil;
	return [activityIndicator autorelease];
}

@end
