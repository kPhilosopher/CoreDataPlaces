//
//  CPMostRecentPhotosTableViewController-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosTableViewController.h"

@interface CPMostRecentPhotosTableViewController ()

#pragma mark - Property

@property (retain) NSArray *listOfRawElements;
@property (retain) NSMutableArray *refinedElementSections;
@property (retain) NSFetchRequest *fetchRequest;

@end