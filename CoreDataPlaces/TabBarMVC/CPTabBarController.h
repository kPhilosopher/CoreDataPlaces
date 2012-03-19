//
//  CPTabBarController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CPTabBarController : UITabBarController

extern NSString *CPTabBarViewAccessibilityLabel;

#pragma mark - Property

@property (retain) NSManagedObjectContext *managedObjectContext;

#pragma mark - Initialization

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end