//
//  CPMostRecentPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosTableViewController.h"
#import "Photo+Logic.h"
#import "CPScrollableImageViewController.h"

@implementation CPMostRecentPhotosTableViewController

const int CPMaximumHoursForMostRecentPhoto = 48;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
    self = [self initWithStyle:style];
    if (self) {
        // Custom initialization
		self.managedObjectContext = managedObjectContext;
		//		NSString *sectionNameKeyPath = [customSettings objectForKey:@"sectionNameKeyPath"];
		NSString *sectionNameKeyPath = @"timeLapseSinceLastView";//change compare to CoreDataPhotosTableViewController
		
		//TODO: make it so that the fetchrequest is made from a different object and given to this view controller.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:managedObjectContext];
		fetchRequest.fetchBatchSize = 20;
		//TODO: fix the predicate to actually filter out older photos. and allow the const to be the number of maximum.
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"timeLapseSinceLastView < 51"];//change
//		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"timeLapseSinceLastView < %@",[NSString stringWithFormat:@"%d",CPMaximumHoursForMostRecentPhoto]];
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sectionNameKeyPath ascending:YES];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[fetchRequest setSortDescriptors:sortDescriptors];
		[sortDescriptors release];sortDescriptors = nil;
		[sortDescriptor release];sortDescriptor = nil;
	    
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
		if ([photo.timeLapseSinceLastView intValue] == 0) //change
			returningString = @"Right Now";
		else
			returningString = [[NSString stringWithFormat:@"%d",[photo.timeLapseSinceLastView intValue]] stringByAppendingString:@" Hour(s) Ago"];//change
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
