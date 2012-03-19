//
//  CPFavoritesTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/30/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPFavoritesTableViewController.h"
#import "Place.h"
#import "CPCoreDataPhotosTableViewController.h"


@interface CPFavoritesTableViewController ()
{
	@private
	NSIndexPath *CP_selectedIndexPath;
}
@end

@implementation CPFavoritesTableViewController

NSString *CPFavoritePlacesTableViewAccessibilityLabel = @"Favorite places table";

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext customSettingsDictionary:(NSDictionary *)customSettings;
{
    self = [self initWithStyle:style];
    if (self) {
        // Custom initialization
		self.tableView.accessibilityLabel = CPFavoritePlacesTableViewAccessibilityLabel;
		NSString *sectionNameKeyPath = @"category";
		//TODO: make it so that the fetchrequest is made from a different object and given to this view controller.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
		fetchRequest.fetchBatchSize = 20;
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"hasFavoritePhoto == %@",[NSNumber numberWithBool:YES]];
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sectionNameKeyPath ascending:YES];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[fetchRequest setSortDescriptors:sortDescriptors];
		[sortDescriptors release];
		[sortDescriptor release];
	    
		NSFetchedResultsController *localFetchedResultsController = 
		[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
											managedObjectContext:managedObjectContext
											  sectionNameKeyPath:sectionNameKeyPath 
													   cacheName:nil];
		[fetchRequest release]; fetchRequest = nil;
		
		NSError *error;
		if (![localFetchedResultsController performFetch:&error])
		{
			NSLog(@"%@", [error localizedFailureReason]);
			//TODO: make sure all aborts are out.
			abort();
		}
		// test it
//		if ([localFetchedResultsController performFetch:&error]) {
//			NSLog(@"results");
//			NSLog(@"found %d objects", localFetchedResultsController.fetchedObjects.count);
//			for (Place *place in localFetchedResultsController.fetchedObjects) {
//				NSLog(@"%@", place);
//			}
//		}
//		else {
//			NSLog(@"%@", [error localizedFailureReason]);
//		}
		

		self.fetchedResultsController = localFetchedResultsController;
		[localFetchedResultsController release];
		
		
		self.titleKey = @"title";
		self.subtitleKey = @"subtitle";
		self.searchKey = @"title";
		self.title = @"Favorite Photos";
		[self.tableView reloadData];
	}
    return self;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject;
{
	if ([managedObject isKindOfClass:[Place class]])
	{
		Place *chosenPlace = (Place *)managedObject;
		CPCoreDataPhotosTableViewController *coreDataPhotosTableViewController = [CPCoreDataPhotosTableViewController coreDataPhotosTableViewControllerWithPlace:chosenPlace manageObjectContext:self.fetchedResultsController.managedObjectContext];
		[self.navigationController pushViewController:coreDataPhotosTableViewController animated:YES];
	}
}

#pragma mark - View lifecycle

- (void)dealloc;
{
	[CP_selectedIndexPath release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewDidAppear:animated];
	if (CP_selectedIndexPath != nil && [self.tableView cellForRowAtIndexPath:CP_selectedIndexPath])
	{
		[self.tableView scrollToRowAtIndexPath:CP_selectedIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
		[CP_selectedIndexPath release]; CP_selectedIndexPath = nil;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	CP_selectedIndexPath = [indexPath retain];
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeLeft));
}

@end
