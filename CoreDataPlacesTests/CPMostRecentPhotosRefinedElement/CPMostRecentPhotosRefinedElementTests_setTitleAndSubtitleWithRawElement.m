//
//  CPMostRecentPhotosRefinedElementTests_setTitleAndSubtitleWithRawElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/28/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPMostRecentPhotosRefinedElementTests_setTitleAndSubtitleWithRawElement.h"
#import <OCMock/OCMock.h>
#import "CPPhotoInterfacing.h"
#import "Photo.h"
#import "CPMostRecentPhotosRefinedElement.h"


@implementation CPMostRecentPhotosRefinedElementTests_setTitleAndSubtitleWithRawElement

#pragma mark - Tests

- (void)testMethod_setTitleAndSubtitleWithRawElement_01;
{
	//setup
	CPMostRecentPhotosRefinedElement *mostRecentPhotosRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	NSString *inputTitle = @"titleString";
	NSString *inputSubtitle = @"subtitleString";
	id mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterfacing)];
	BOOL yesValue = YES;
	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesValue)] isKindOfClass:[Photo class]];
	[[[mockPhoto stub] andReturn:inputTitle] title];
	[[[mockPhoto stub] andReturn:inputSubtitle] subtitle];
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//evaluate the outcome.
	STAssertTrue(([mostRecentPhotosRefinedElement.title isEqualToString:inputTitle]),@"the title is not set correctly.");
	STAssertTrue(([mostRecentPhotosRefinedElement.subtitle isEqualToString:inputSubtitle]),@"the subtitle is not set correctly.");
}

@end
