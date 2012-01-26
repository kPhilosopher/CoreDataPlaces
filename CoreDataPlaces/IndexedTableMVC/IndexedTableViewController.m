//
//  IndexedTableViewController.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/2/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "IndexedTableViewController.h"

@implementation IndexedTableViewController
@synthesize dataIndexer = _dataIndexer;

#pragma mark - Methods to override

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array;
{
	return;
}

- (NSMutableArray *)fetchTheElementSections;
{
	return nil;
}

- (NSArray *)fetchTheRawData;
{
	return nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setTheElementSectionsToTheFollowingArray:[self.dataIndexer returnTheIndexedSectionsOfTheGiven:[self fetchTheRawData]]];
}

- (void)dealloc
{
	[_dataIndexer release];
	[super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self fetchTheElementSections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[[self fetchTheElementSections] objectAtIndex:section] count];
}

#pragma mark - Helper method

//TODO: see if I can change the location of this method.
- (RefinedElement *)getTheRefinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;
{
	return [(NSArray *)[[self fetchTheElementSections] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}
@end
