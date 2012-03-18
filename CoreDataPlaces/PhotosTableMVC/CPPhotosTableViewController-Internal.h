//
//  CPPhotosTableViewController-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/19/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewController.h"

@interface CPPhotosTableViewController ()

#pragma mark - Property

@property (retain) UIActivityIndicatorView *activityIndicator;

#pragma mark - Internal method

- (void)CP_setupPhotosListWithPlaceID:(NSString *)placeID;

@end
