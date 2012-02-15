//
//  CPCoreDataPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPCoreDataPhotosTableViewController.h"
#import "Photo+Logic.h"
#import "Place.h"
#import "CPScrollableImageViewController.h"
#import "NSDate+HourComparator.h"


@implementation CPCoreDataPhotosTableViewController

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext fetchedResultsController:(NSFetchedResultsController *)localFetchedResultsController;
{
	self = [self initWithStyle:style];
    if (self) {
        // Custom initialization
		self.managedObjectContext = managedObjectContext;
		self.fetchedResultsController = localFetchedResultsController;
		
		self.titleKey = @"title";
		self.subtitleKey = @"subtitle";
		self.searchKey = nil;
		//TODO: title of the given Place
		//		self.title = @"";
	}
    return self;
}

//TODO: might delete this method
- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext chosenPlace:(Place *)chosenPlace;
{
    self = [self initWithStyle:style];
    if (self) {
        // Custom initialization
		self.managedObjectContext = managedObjectContext;
//		NSString *sectionNameKeyPath = [customSettings objectForKey:@"sectionNameKeyPath"];
		NSString *sectionNameKeyPath = @"timeLapseSinceUpload";

		//TODO: make it so that the fetchrequest is made from a different object and given to this view controller.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:managedObjectContext];
		fetchRequest.fetchBatchSize = 20;
//		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"itsPlace.placeID like %@",chosenPlace.placeID];
		fetchRequest.predicate = [NSPredicate
								  predicateWithFormat:@"(isFavorite == %@) AND (itsPlace.placeID like %@)", [NSNumber numberWithBool:YES], chosenPlace.placeID];
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
		
		// test it
		NSError *error;
		if ([localFetchedResultsController performFetch:&error]) {
			NSLog(@"results");
			NSLog(@"found %d objects", localFetchedResultsController.fetchedObjects.count);
			for (Photo *photo in localFetchedResultsController.fetchedObjects) {
				NSLog(@"%@", photo);
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
		//TODO: title of the given Place
//		self.title = @"";
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
	NSString *returningString = nil;
	id <NSFetchedResultsSectionInfo> sectionInfo = [fetchedResultsController.sections objectAtIndex:section];
	
	if ([sectionInfo.objects count] > 0)
	{
		//TODO: create an interface to return a string.
		//after checking key-value coding to see if:
		Photo *photo = [sectionInfo.objects lastObject];
//		NSString *elapsedHours = [NSString stringWithFormat:@"%d",[photo.timeLapseSinceUpload intValue]];

		if ([photo.timeLapseSinceUpload intValue] == 0) 
			returningString = @"Right Now";
		else
			returningString = [[NSString stringWithFormat:@"%d",[photo.timeLapseSinceUpload intValue]] stringByAppendingString:@" Hour(s) Ago"];
	}
    return returningString;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return nil;
}

#pragma mark UITableViewDelegate methods


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return 0;
}


- (void)managedObjectSelected:(NSManagedObject *)managedObject;
{
	if ([managedObject isKindOfClass:[Photo class]])
	{
//		NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
//		NSLog(@"%@",[NSString stringWithFormat:@"%d",[[self.fetchedResultsController sections] count]]);
//		NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
		Photo *chosenPhoto = (Photo *)managedObject;
		CPScrollableImageViewController *scrollableImageViewController = [[CPScrollableImageViewController alloc] initWithNibName:@"CPScrollableImageViewController-iPhone" bundle:nil managedObjectContext:self.managedObjectContext];
		scrollableImageViewController.title = chosenPhoto.title;
		scrollableImageViewController.currentPhoto = chosenPhoto;
		[self.navigationController pushViewController:scrollableImageViewController animated:YES];
		[scrollableImageViewController release];
	}
}

@end
