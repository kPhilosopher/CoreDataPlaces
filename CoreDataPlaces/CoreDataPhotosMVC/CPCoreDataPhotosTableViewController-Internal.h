//
//  CPCoreDataPhotosTableViewController-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/16/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPCoreDataPhotosTableViewController.h"


@interface CPCoreDataPhotosTableViewController ()

#pragma mark - Property

@property (retain) NSArray *listOfRawElements;
@property (retain) NSMutableArray *refinedElementSections;
@property (retain) NSFetchRequest *fetchRequest;

#pragma mark - Internal method

- (void)CP_fetchListThenIndexData;

@end
