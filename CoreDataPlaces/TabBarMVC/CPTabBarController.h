//
//  CPTabBarController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPTabBarController : UITabBarController

extern NSString *CPTabBarViewAccessibilityLabel;

//@property (retain) id <CPPictureListTableViewControllerDelegate> delegateToTransfer;

#pragma mark - Initialization

- (id)initWithDelegate:(id)delegate withManagedObjectContext:(NSManagedObjectContext *)managedContext;

@property (retain) NSManagedObjectContext *managedObjectContext;

@end