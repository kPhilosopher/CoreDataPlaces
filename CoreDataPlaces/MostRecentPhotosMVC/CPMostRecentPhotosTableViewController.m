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

NSString *CPMostRecentPhotosTableViewAccessibilityLabel = @"Most recent photos table";

const int CPMaximumHoursForMostRecentPhoto = 48;

#pragma mark - Initialization

//TODO: erase this, this is here for testing.
- (NSNumber *)CP_timeLapseSinceDate:(NSDate *)date;
{
	NSDate *endDate = [NSDate date];
	NSDate *startDate = date;
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSUInteger unitFlags = NSHourCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate 
												 options:0];
	int number = [components hour];
	return [NSNumber numberWithInt:number];
}

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
    self = [self initWithStyle:style];
    if (self) {
        // Custom initialization
		self.tableView.accessibilityLabel = CPMostRecentPhotosTableViewAccessibilityLabel;
		self.managedObjectContext = managedObjectContext;
		//		NSString *sectionNameKeyPath = [customSettings objectForKey:@"sectionNameKeyPath"];
		NSString *sectionNameKeyPath = @"timeLapseSinceLastView";//change compare to CoreDataPhotosTableViewController
		
		//TODO: make it so that the fetchrequest is made from a different object and given to this view controller.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:managedObjectContext];
		fetchRequest.fetchBatchSize = 20;
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"timeLapseSinceLastView < %d",CPMaximumHoursForMostRecentPhoto];//changed
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
//			for (Photo *photo in localFetchedResultsController.fetchedObjects) {
//				NSLog(@"%@", photo.title);
//				NSLog(@"%@", [self CP_timeLapseSinceDate:photo.timeOfLastView]);
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
		//TODO: title of the given Place
		self.title = @"Recent Photos";
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

//TODO: create a file that has this method for all classes that use it, or create an inheritance or strategy re-architecture to reduce redundancy.
- (BOOL)RD_currentDeviceIsiPodOriPhoneWithImageController:(UIViewController *)imageController;
{
	return imageController.view.window == nil;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject;
{
	if ([managedObject isKindOfClass:[Photo class]])
	{
		Photo *chosenPhoto = (Photo *)managedObject;
		CPScrollableImageViewController *scrollableImageViewController = [CPScrollableImageViewController sharedInstance];
		scrollableImageViewController.title = chosenPhoto.title;
		[scrollableImageViewController setNewCurrentPhoto:chosenPhoto];
		if ([self RD_currentDeviceIsiPodOriPhoneWithImageController:scrollableImageViewController])
		{
			[scrollableImageViewController.navigationController popViewControllerAnimated:NO];
			[self.navigationController pushViewController:scrollableImageViewController animated:YES];
		}
	}
}

@end
