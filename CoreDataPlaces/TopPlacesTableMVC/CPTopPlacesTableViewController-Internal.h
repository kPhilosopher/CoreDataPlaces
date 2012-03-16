//
//  CPTopPlacesTableViewController-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTopPlacesTableViewController.h"


@interface CPTopPlacesTableViewController ()

#pragma mark - Property

@property (retain) NSArray *listOfPlaces;
@property (retain) NSMutableArray *indexedListOfPlaces;

#pragma mark - Internal method

- (void)CP_setupTopPlacesList;
- (void)CP_refreshTheTopPlacesList;

@end
