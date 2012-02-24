//
//  PlacesCoreDataTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/21/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "PlacesCoreDataTableViewController.h"

@interface PlacesCoreDataTableViewController ()

@end

@implementation PlacesCoreDataTableViewController

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
