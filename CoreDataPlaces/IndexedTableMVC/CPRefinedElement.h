//
//  CPRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

// !!!:This is an abstract class. It must be subclassed with appropriate implementation.

#import <Foundation/Foundation.h>
#import "CPRefinedElementInterfacing.h"


//TODO: make changes to tableViewHandlers to allow to just handle RefinedElements, not managed objects as well.
@interface CPRefinedElement : NSObject <NSCopying, CPRefinedElementInterfacing>

@end
