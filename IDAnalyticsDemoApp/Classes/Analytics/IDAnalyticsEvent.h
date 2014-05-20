//
//  IDAnalyticsEvent.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import <Foundation/Foundation.h>

/// The default value of all initiations, this specifies that there was no
/// initiation recorded for a particular event.
OBJC_EXPORT NSInteger const IDAnalyticsUnknownInitiation;

typedef id (^IDAnalyticsEventAttributeTransformingBlock)(NSString * name, id value);

///
/// Represents an event with a name and attributes.
///
/// Categories on `IDAnalyticsEvent` can provide specific event initializers as
/// necessary; this class is meant to remain clean.
///
/// The `Protected` category provides access to the mutable interface of
/// `IDAnalyticsEvent`. This should only be used inside the analytics classes;
/// all events must be immutable to the app to avoid recurrence of the problems
/// that this approach attempts to solve.
///
@interface IDAnalyticsEvent : NSObject
{
@private
    NSMutableDictionary * _attributes;
    NSString            * _name;
}

/// The name that will be recorded for the event.
@property (nonatomic, strong, readonly) NSString * name;

/// Provides read-only access to the attributes that will be recorded for the
/// event
@property (nonatomic, strong, readonly) NSDictionary * attributes;

#pragma mark - Transformations
/// @name      Transformations

/// Creates a copy of the event with all attribute values of the designated
/// class transformed according to the return value of the block.
///
/// @param class          The class, members of which will be transformed
/// @param transformBlock A block that, given a property name and value, returns
/// a new value for the property
///
/// @return An event of the same type as the receiver
- (instancetype)eventWithAttributesOfClass:(Class)class transformedBy:(IDAnalyticsEventAttributeTransformingBlock)transformBlock;

#pragma mark - Events
/// @name      Events

/// Convenience method to submit the event to be tracked.
- (void)track;

@end
