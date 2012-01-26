//
//  CPSplitViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//

#import "CPSplitViewController.h"

@implementation CPSplitViewController

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end