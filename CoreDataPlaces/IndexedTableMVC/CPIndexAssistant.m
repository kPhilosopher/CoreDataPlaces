//
//  CPIndexAssistant.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPIndexAssistant.h"
#import "CPRefinary.h"
#import "CPDataIndexer.h"
#import "CPTableViewHandler.h"
#import "CPRefinedElement.h"


@interface CPIndexAssistant()
{
@private
	CPRefinary *CP_refinary;
	CPDataIndexer *CP_dataIndexer;
	CPTableViewHandler *CP_tableViewHandler;
	CPRefinedElement *CP_refinedElementType;
}
@end

#pragma mark -

@implementation CPIndexAssistant

#pragma mark - Synthesize

@synthesize refinary = CP_refinary;
@synthesize dataIndexer = CP_dataIndexer;
@synthesize tableViewHandler = CP_tableViewHandler;
@synthesize refinedElementType = CP_refinedElementType;

#pragma mark - Intialization

- (id)initWithRefinary:(CPRefinary *)refinary dataIndexer:(CPDataIndexer *)dataIndexer tableViewHandler:(CPTableViewHandler *)tableViewHandler refinedElementType:(CPRefinedElement *)refinedElementType;
{
	self = [self init];
	if (self)
	{
		self.refinary = refinary;
		self.dataIndexer = dataIndexer;
		self.tableViewHandler = tableViewHandler;
		self.refinedElementType = refinedElementType;
	}
	return self;
}

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_refinary release];
	[CP_dataIndexer release];
	[CP_tableViewHandler release];
	[CP_refinedElementType release];
	[super dealloc];
}

@end
