//
//  IndexedTableViewController.h
//  Places_09
//
//  Created by Jinwoo Baek on 12/2/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//
// !!!: This class is designed to be subclassed along with the Model classes (DataIndexer and RefinedElement) for specific needs

#import <UIKit/UIKit.h>
#import "PLFlickrDataSource.h"
#import "DataIndexer.h"

@interface IndexedTableViewController : UITableViewController
{
	@private
	DataIndexer *_dataIndexer;
}

#pragma mark - Properties

@property (retain) DataIndexer *dataIndexer;

#pragma mark - Methods to override

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array;
- (NSMutableArray *)fetchTheElementSections;
- (NSArray *)fetchTheRawData;

#pragma mark - Helper method

- (RefinedElement *)getTheRefinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;

@end
