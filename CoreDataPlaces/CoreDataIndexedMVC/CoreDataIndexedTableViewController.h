//
//  CoreDataIndexedTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/5/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "CPTableViewControllerDataMutating.h"

@protocol CPDataIndexHandling;
@protocol CPTableViewHandling;
@interface CoreDataIndexedTableViewController : CoreDataTableViewController <CPTableViewControllerDataMutating>

#pragma mark - Properties

@property (retain) id<CPDataIndexHandling> dataIndexHandler;
@property (retain) id<CPTableViewHandling> tableViewHandler;

#pragma mark - Intialization

- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler;

@end
