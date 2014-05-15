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

///
/// <#class description#>
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

/// Convenience method to submit the event to be tracked.
- (void)track;

#pragma mark - Events
/// @name      Events

#pragma mark Session Events

+ (instancetype)eventForSessionStart;
+ (instancetype)eventForSessionEnd;

@end
