//
//  CPMostRecentPhotosDataHandler.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/4/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CPMostRecentPhotosRefinedElement;
@class CPMostRecentPhotosRefinary;
@class CPMostRecentPhotosDataIndexer;

@interface CPMostRecentPhotosDataHandler : NSObject

#pragma mark - Property

@property (retain) CPMostRecentPhotosRefinedElement *refinedElementType;
@property (retain) CPMostRecentPhotosRefinary *refinary;
@property (retain) CPMostRecentPhotosDataIndexer *dataIndexer;

#pragma mark - Initialization

- (id)initWithRefinedElementType:(CPMostRecentPhotosRefinedElement *)refinedElementType refinary:(CPMostRecentPhotosRefinary *)refinary dataIndexer:(CPMostRecentPhotosDataIndexer *)dataIndexer;

@end
