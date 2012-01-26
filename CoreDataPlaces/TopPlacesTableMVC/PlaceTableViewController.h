//
//  PlaceTableViewController.h
//  Places_09
//
//  Created by Jinwoo Baek on 12/2/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//
// !!!: This class is designed to be subclassed.

#import <UIKit/UIKit.h>
#import "PictureListTableViewController.h"
#import "IndexedTableViewController.h"
#import "PlacesDataIndexer.h"
#import "NSString+TitleExtraction.h"
#import "NSString+FindCharacterInSet.h"
#import "TableViewControllerDataReloading.h"

@interface PlaceTableViewController : IndexedTableViewController <TableViewControllerDataReloading>
{
	@private
	PLFlickrDataSource *_flickrDataSource;
	id <PictureListTableViewControllerDelegate> _delegateToTransfer;
}

extern NSString *PlacesTableViewAccessibilityLabel;

@property (retain) PLFlickrDataSource *flickrDataSource;
@property (assign) id <PictureListTableViewControllerDelegate> delegateToTransfer;

- (id)initWithStyle:(UITableViewStyle)style withTheFlickrDataSource:(PLFlickrDataSource *)theFlickrDataSource withTheDataIndexer:(DataIndexer *)dataIndexer;

@end
