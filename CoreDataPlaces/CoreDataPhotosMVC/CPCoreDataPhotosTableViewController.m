//
//  CPCoreDataPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPCoreDataPhotosTableViewController.h"
#import "Photo.h"
#import "Place.h"
#import "CPScrollableImageViewController.h"


@implementation CPCoreDataPhotosTableViewController

#pragma mark - Initialization

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
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"itsPlace.placeID like %@",chosenPlace.placeID];
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

- (void)managedObjectSelected:(NSManagedObject *)managedObject;
{
	if ([managedObject isKindOfClass:[Photo class]])
	{
		Photo *chosenPhoto = (Photo *)managedObject;
		CPScrollableImageViewController *scrollableImageViewController = [[CPScrollableImageViewController alloc] initWithNibName:@"CPScrollableImageViewController-iPhone" bundle:nil managedObjectContext:self.managedObjectContext];
		scrollableImageViewController.title = chosenPhoto.title;
		scrollableImageViewController.currentPhoto = chosenPhoto;
		[self.navigationController pushViewController:scrollableImageViewController animated:YES];
		[scrollableImageViewController release];
	}
}

@end
