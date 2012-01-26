//
//  TopPlacesTableViewController.h
//  Places_09
//
//  Created by Jinwoo Baek on 12/19/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceTableViewController.h"
#import "TableViewControllerDataReloading.h"

@interface TopPlacesTableViewController : PlaceTableViewController
{
	@private
	id<TableViewControllerDataReloading> _delegateToUpdateMostRecentPlaces;
}

extern NSString *TopPlacesViewAccessibilityLabel;

@property (retain) id<TableViewControllerDataReloading> delegateToUpdateMostRecentPlaces;

@end
