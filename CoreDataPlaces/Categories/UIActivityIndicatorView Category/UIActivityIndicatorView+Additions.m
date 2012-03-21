//
//  UIActivityIndicatorView+NavigationController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/17/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "UIActivityIndicatorView+Additions.h"
#import "CPConstants.h"


@implementation UIActivityIndicatorView (Additions)

#pragma mark - Class method

+ (UIActivityIndicatorView *)activityIndicatorOnKIFTestableViewWithView:(UIView *)view;
{
	UIView *theLabel = [[UIView alloc] init];
	theLabel.accessibilityLabel = CPActivityIndicatorMarkerForKIF;
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.color = [UIColor blueColor];
	activityIndicator.hidesWhenStopped = YES;
	activityIndicator.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
	theLabel.frame = activityIndicator.frame;
	activityIndicator.center = CGPointMake(theLabel.bounds.size.width/2, theLabel.bounds.size.height/2);
	activityIndicator.accessibilityLabel = @"Activity indicator";
	activityIndicator.hidesWhenStopped = YES;
	[view addSubview:theLabel];
	[theLabel addSubview:activityIndicator];
	[theLabel release]; theLabel = nil;
	return [activityIndicator autorelease];
}

#pragma mark - Instance method

- (void)removeKIFAndActivityIndicatorView;
{
	[self retain]; [self autorelease];
	[self stopAnimating];
	UIView *KIFView = self.superview;
	[self removeFromSuperview];
	[KIFView removeFromSuperview];
}

@end
