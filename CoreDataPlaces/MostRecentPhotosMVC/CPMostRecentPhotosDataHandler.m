//
//  CPMostRecentPhotosDataHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/4/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPMostRecentPhotosDataHandler.h"
#import "CPMostRecentPhotosRefinedElement.h"
#import "CPMostRecentPhotosRefinary.h"
#import "CPMostRecentPhotosDataIndexer.h"


@interface CPMostRecentPhotosDataHandler()
{
	@private
	CPMostRecentPhotosRefinedElement *CP_refinedElementType;
	CPMostRecentPhotosRefinary *CP_refinary;
	CPMostRecentPhotosDataIndexer *CP_dataIndexer;
}
@end

#pragma mark -

@implementation CPMostRecentPhotosDataHandler

#pragma mark - Synthesize

@synthesize refinedElementType = CP_refinedElementType;
@synthesize refinary = CP_refinary;
@synthesize dataIndexer = CP_dataIndexer;

#pragma mark - Intialization

- (id)initWithRefinedElementType:(CPMostRecentPhotosRefinedElement *)refinedElementType refinary:(CPMostRecentPhotosRefinary *)refinary dataIndexer:(CPMostRecentPhotosDataIndexer *)dataIndexer;
{
	self = [self init];
	if (self)
	{
		self.refinedElementType = refinedElementType;
		self.refinary = refinary;
		self.dataIndexer = dataIndexer;
	}
	return self;
}

@end
