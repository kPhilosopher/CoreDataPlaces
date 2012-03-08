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


@implementation CPFavoritesTableViewController

NSString *CPFavoritePlacesTableViewAccessibilityLabel = @"Favorite places table";

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext customSettingsDictionary:(NSDictionary *)customSettings;
{
    self = [self initWithStyle:style];
    if (self) {
        // Custom initialization
		self.tableView.accessibilityLabel = CPFavoritePlacesTableViewAccessibilityLabel;
		self.managedObjectContext = managedObjectContext;
		//		NSString *sectionNameKeyPath = [customSettings objectForKey:@"sectionNameKeyPath"];
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

		NSError *error;
		if (![localFetchedResultsController performFetch:&error])
		{
			NSLog(@"%@", [error localizedFailureReason]);
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
		
		[fetchRequest release]; fetchRequest = nil;

		self.fetchedResultsController = localFetchedResultsController;
		[localFetchedResultsController release];
		
		
		self.titleKey = @"title";
		self.subtitleKey = @"subtitle";
		self.searchKey = @"title";
		self.title = @"Favorites";
		
		//TODO: change the design. this is for testing
//		self.tableViewHandler = [[CPFavoritesTableViewHandler alloc] init];
//		self.dataIndexHandler = [Cp];
	}
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject;
{
	if ([managedObject isKindOfClass:[Place class]])
	{
		Place *chosenPlace = (Place *)managedObject;
		CPCoreDataPhotosTableViewController *coreDataPhotosTableViewController = [[CPCoreDataPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain managedObjectContext:self.managedObjectContext chosenPlace:chosenPlace];
		[self.navigationController pushViewController:coreDataPhotosTableViewController animated:YES];
		[coreDataPhotosTableViewController release];
	}
}

@end
