//
//  KIFTestStep+PlacesAdditions.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Jinwoo Baek. All rights reserved.
//

#import "KIFTestStep+PlacesAdditions.h"


@implementation KIFTestStep (PlacesAdditions)

//#pragma mark - Jin's addition
//
//+ (id)stepToDeleteRowInTableViewWithAccessibilityLabel:(NSString*)tableViewLabel atIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *description = [NSString stringWithFormat:@"Step to tap row %d in tableView with label %@", [indexPath row], tableViewLabel];
//    return [KIFTestStep stepWithDescription:description executionBlock:^(KIFTestStep *step, NSError **error) {
//        UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:tableViewLabel];
//        KIFTestCondition(element, error, @"View with label %@ not found", tableViewLabel);
//        UITableView *tableView = (UITableView*)[UIAccessibilityElement viewContainingAccessibilityElement:element];
//        
//        KIFTestCondition([tableView isKindOfClass:[UITableView class]], error, @"Specified view is not a UITableView");
//        
//        KIFTestCondition(tableView, error, @"Table view with label %@ not found", tableViewLabel);
//        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        CGRect cellFrame = [cell.contentView convertRect:[cell.contentView frame] toView:tableView];
//		CGPoint pointWithDeletionControl = CGPointMake(cellFrame.origin.x - 30.0, cellFrame.origin.y + 30.0);
//        [tableView tapAtPoint:pointWithDeletionControl];
//        return KIFTestStepResultSuccess;
//    }];
//}
//
//+ (id)stepToExtractDeleteLabelOfRowInTableViewWithAccessibilityLabel:(NSString*)tableViewLabel atIndexPath:(NSIndexPath *)indexPath  toStringReference:(NSString **)stringReference;
//{
//	//	NSString **stringRef = stringReference;
//    NSString *description = [NSString stringWithFormat:@"Step to tap row %d in tableView with label %@", [indexPath row], tableViewLabel];
//    return [KIFTestStep stepWithDescription:description executionBlock:^(KIFTestStep *step, NSError **error) {
//        UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:tableViewLabel];
//        KIFTestCondition(element, error, @"View with label %@ not found", tableViewLabel);
//        UITableView *tableView = (UITableView*)[UIAccessibilityElement viewContainingAccessibilityElement:element];
//        
//        KIFTestCondition([tableView isKindOfClass:[UITableView class]], error, @"Specified view is not a UITableView");
//        
//        KIFTestCondition(tableView, error, @"Table view with label %@ not found", tableViewLabel);
//        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//		NSString *label = @"Delete ";
//		label = [label stringByAppendingString:cell.textLabel.text];
//		label = [label stringByAppendingString:@", "];
//		label = [label stringByAppendingString:cell.detailTextLabel.text];
//		*stringReference = label;
//        return KIFTestStepResultSuccess;
//    }];
//}
//
//+ (id)stepToSwipeRowInTableViewWithAccessibilityLabel:(NSString*)tableViewLabel atIndexPath:(NSIndexPath *)indexPath;
//{
//    NSString *description = [NSString stringWithFormat:@"Step to swipe row %d in tableView with label %@", [indexPath row], tableViewLabel];
//    return [KIFTestStep stepWithDescription:description executionBlock:^(KIFTestStep *step, NSError **error)
//			{
//				UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:tableViewLabel];
//				KIFTestCondition(element, error, @"View with label %@ not found", tableViewLabel);
//				UITableView *tableView = (UITableView*)[UIAccessibilityElement viewContainingAccessibilityElement:element];
//				
//				KIFTestCondition([tableView isKindOfClass:[UITableView class]], error, @"Specified view is not a UITableView");
//				
//				KIFTestCondition(tableView, error, @"Table view with label %@ not found", tableViewLabel);
//				
//				UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//				CGRect cellFrame = [cell.contentView convertRect:[cell.contentView frame] toView:tableView];
//				CGFloat QuarterOfTheWidth = cellFrame.size.width/4;
//				CGPoint centerPoint = CGPointCenteredInRect(cellFrame);
//				CGPoint leftPoint = CGPointMake(centerPoint.x-QuarterOfTheWidth, centerPoint.y);
//				CGPoint rightPoint = CGPointMake(centerPoint.x+QuarterOfTheWidth, centerPoint.y);
//				//this part doesn't work.
//				[tableView dragFromPoint:leftPoint toPoint:rightPoint];
//				return KIFTestStepResultSuccess;
//			}];
//}
//
//+ (id)stepToTapViewWithAccessibilityLabelInReferenceDictionary:(NSDictionary *)referenceDictionary key:(NSString *)key;
//{
//	NSString *label = @"";
//	NSString *value = nil;
//	UIAccessibilityTraits traits = UIAccessibilityTraitNone;
//	
//    NSString *description = nil;
//    if (value.length) {
//        description = [NSString stringWithFormat:@"Tap view with accessibility label \"%@\" and accessibility value \"%@\"", label, value];
//    } else {
//        description = [NSString stringWithFormat:@"Tap view with accessibility label \"%@\"", label];
//    }
//	
//    // After tapping the view we want to wait a short period to allow things to settle (animations and such). We can't do this using CFRunLoopRunInMode() because certain things, such as the built-in media picker, do things with the run loop that are not compatible with this kind of wait. Instead we leverage the way KIF hooks into the existing run loop by returning "wait" results for the desired period.
//    const NSTimeInterval quiesceWaitInterval = 0.5;
//    __block NSTimeInterval quiesceStartTime = 0.0;
//    
//    __block UIView *view = nil;
//    
//    return [self stepWithDescription:description executionBlock:^(KIFTestStep *step, NSError **error) {
//		
//        // If we've already tapped the view and stored it to a variable, and we've waited for the quiesce time to elapse, then we're done.
//		
//		NSString *stringLabel = [referenceDictionary objectForKey:key];
//		
//        if (view) {
//            KIFTestWaitCondition(([NSDate timeIntervalSinceReferenceDate] - quiesceStartTime) >= quiesceWaitInterval, error, @"Waiting for view to become the first responder.");
//            return KIFTestStepResultSuccess;
//        }
//		
//        UIAccessibilityElement *element = [self _accessibilityElementWithLabel:stringLabel accessibilityValue:value tappable:YES traits:traits error:error];
//        if (!element) {
//            return KIFTestStepResultWait;
//        }
//		
//        view = [UIAccessibilityElement viewContainingAccessibilityElement:element];
//        KIFTestWaitCondition(view, error, @"Failed to find view for accessibility element with label \"%@\"", stringLabel);
//		
//        if (![self _isUserInteractionEnabledForView:view]) {
//            if (error) {
//                *error = [[[NSError alloc] initWithDomain:@"KIFTest" code:KIFTestStepResultFailure userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"View with accessibility label \"%@\" is not enabled for interaction", stringLabel], NSLocalizedDescriptionKey, nil]] autorelease];
//            }
//            return KIFTestStepResultWait;
//        }
//		
//        CGRect elementFrame = [view.window convertRect:element.accessibilityFrame toView:view];
//        CGPoint tappablePointInElement = [view tappablePointInRect:elementFrame];
//		
//        // This is mostly redundant of the test in _accessibilityElementWithLabel:
//        KIFTestWaitCondition(!isnan(tappablePointInElement.x), error, @"The element with accessibility label %@ is not tappable", stringLabel);
//        [view tapAtPoint:tappablePointInElement];
//		
//        KIFTestCondition(![view canBecomeFirstResponder] || [view isDescendantOfFirstResponder], error, @"Failed to make the view %@ which contains the accessibility element \"%@\" into the first responder", view, stringLabel);
//		
//        quiesceStartTime = [NSDate timeIntervalSinceReferenceDate];
//		
//        KIFTestWaitCondition(NO, error, @"Waiting for the view to settle.");
//    }];
//}
//
//+ (id)stepToTapViewWithStringReference:(NSString **)stringReference;
//{
//	NSString *label = @"";
//	NSString *value = nil;
//	UIAccessibilityTraits traits = UIAccessibilityTraitNone;
//	
//    NSString *description = nil;
//    if (value.length) {
//        description = [NSString stringWithFormat:@"Tap view with accessibility label \"%@\" and accessibility value \"%@\"", label, value];
//    } else {
//        description = [NSString stringWithFormat:@"Tap view with accessibility label \"%@\"", label];
//    }
//	
//    // After tapping the view we want to wait a short period to allow things to settle (animations and such). We can't do this using CFRunLoopRunInMode() because certain things, such as the built-in media picker, do things with the run loop that are not compatible with this kind of wait. Instead we leverage the way KIF hooks into the existing run loop by returning "wait" results for the desired period.
//    const NSTimeInterval quiesceWaitInterval = 0.5;
//    __block NSTimeInterval quiesceStartTime = 0.0;
//    
//    __block UIView *view = nil;
//    
//    return [self stepWithDescription:description executionBlock:^(KIFTestStep *step, NSError **error) {
//		
//        // If we've already tapped the view and stored it to a variable, and we've waited for the quiesce time to elapse, then we're done.
//		
//		NSString *stringLabel = [NSString stringWithString:*stringReference];
//		
//        if (view) {
//            KIFTestWaitCondition(([NSDate timeIntervalSinceReferenceDate] - quiesceStartTime) >= quiesceWaitInterval, error, @"Waiting for view to become the first responder.");
//            return KIFTestStepResultSuccess;
//        }
//		
//        UIAccessibilityElement *element = [self _accessibilityElementWithLabel:stringLabel accessibilityValue:value tappable:YES traits:traits error:error];
//        if (!element) {
//            return KIFTestStepResultWait;
//        }
//		
//        view = [UIAccessibilityElement viewContainingAccessibilityElement:element];
//        KIFTestWaitCondition(view, error, @"Failed to find view for accessibility element with label \"%@\"", stringLabel);
//		
//        if (![self _isUserInteractionEnabledForView:view]) {
//            if (error) {
//                *error = [[[NSError alloc] initWithDomain:@"KIFTest" code:KIFTestStepResultFailure userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"View with accessibility label \"%@\" is not enabled for interaction", stringLabel], NSLocalizedDescriptionKey, nil]] autorelease];
//            }
//            return KIFTestStepResultWait;
//        }
//		
//        CGRect elementFrame = [view.window convertRect:element.accessibilityFrame toView:view];
//        CGPoint tappablePointInElement = [view tappablePointInRect:elementFrame];
//		
//        // This is mostly redundant of the test in _accessibilityElementWithLabel:
//        KIFTestWaitCondition(!isnan(tappablePointInElement.x), error, @"The element with accessibility label %@ is not tappable", stringLabel);
//        [view tapAtPoint:tappablePointInElement];
//		
//        KIFTestCondition(![view canBecomeFirstResponder] || [view isDescendantOfFirstResponder], error, @"Failed to make the view %@ which contains the accessibility element \"%@\" into the first responder", view, stringLabel);
//		
//        quiesceStartTime = [NSDate timeIntervalSinceReferenceDate];
//		
//        KIFTestWaitCondition(NO, error, @"Waiting for the view to settle.");
//    }];
//}

@end