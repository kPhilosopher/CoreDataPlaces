//
//  CPTabBarController-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTabBarController.h"


@interface CPTabBarController ()

#pragma mark - Internal method

- (void)CP_setup;

#pragma mark - Readability method

- (void)RD_allocInitTheNavigationViewControllers;
- (void)RD_setupTheCustomTableViewControllers;
- (void)RD_pushViewControllersToNavigationViewControllers;
- (void)RD_setTabBarItemToSystemItems;
- (void)RD_allocInitThePlaceTableViewControllersWithTheSameFlickrDataSource;
- (void)RD_addTheNavigationControllersToThisTabBarController;

@end
