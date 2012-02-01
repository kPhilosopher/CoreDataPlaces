//
//  CPFavoritesTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/30/12.
//

#import "CPFavoritesTableViewController.h"
#import "Place.h"

@implementation CPFavoritesTableViewController

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedContext customSettingsDictionary:(NSDictionary *)customSettings;
{
    self = [self initWithStyle:style];
    if (self) {
        // Custom initialization
		//		NSString *sectionNameKeyPath = [customSettings objectForKey:@"sectionNameKeyPath"];
		NSString *sectionNameKeyPath = @"title";
		
		
		//TODO: make it so that the fetchrequest is made from a different object and given to this view controller.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedContext];
		fetchRequest.fetchBatchSize = 20;
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"hasFavoritePhoto == NO"];
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sectionNameKeyPath ascending:YES];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[fetchRequest setSortDescriptors:sortDescriptors];
		[sortDescriptors release];
		[sortDescriptor release];
	    
		NSFetchedResultsController *localFetchedResultsController = 
		[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedContext
											  sectionNameKeyPath:sectionNameKeyPath 
													   cacheName:nil];

		// test it
		NSError *error;
		if ([localFetchedResultsController performFetch:&error]) {
			NSLog(@"results");
			NSLog(@"found %d objects", localFetchedResultsController.fetchedObjects.count);
			for (Place *place in localFetchedResultsController.fetchedObjects) {
				NSLog(@"%@", place);
			}
		}
		else {
			NSLog(@"%@", [error localizedFailureReason]);
		}
		
		[fetchRequest release]; fetchRequest = nil;

		self.fetchedResultsController = localFetchedResultsController;
		[localFetchedResultsController release];
		
		
		self.titleKey = @"title";
		self.subtitleKey = @"subtitle";
		self.searchKey = nil;
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

@end
