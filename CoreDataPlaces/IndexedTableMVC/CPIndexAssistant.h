//
//  CPIndexAssistant.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/14/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CPRefinary;
@class CPDataIndexer;
@class CPTableViewHandler;
@class CPRefinedElement;

@interface CPIndexAssistant : NSObject

#pragma mark - Property

@property (retain) CPRefinary *refinary;
@property (retain) CPDataIndexer *dataIndexer;
@property (retain) CPTableViewHandler *tableViewHandler;
@property (retain) CPRefinedElement *refinedElementType;

#pragma mark - Initialization

- (id)initWithRefinary:(CPRefinary *)refinary dataIndexer:(CPDataIndexer *)dataIndexer tableViewHandler:(CPTableViewHandler *)tableViewHandler refinedElementType:(CPRefinedElement *)refinedElementType;

@end
