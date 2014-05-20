//
//  IDAnalyticsEvent+SessionEvents.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/20/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsEvent.h"

@interface IDAnalyticsEvent (SessionEvents)

#pragma mark - Session Events

/// Records the start of a session.
///
/// This generally corresponds to a fresh launch of the app, or returning to the
/// app after being in the background for a certain length of time or longer.
///
/// @return The event or `nil` if a session was still active
+ (instancetype)eventForSessionStart;

/// Records the end of a session.
///
/// This could be done any time the app goes into the background, but it is
/// probably best to wait until the app has been in the background for a certain
/// length of time before actually tracking the event.
///
/// @return The event or `nil` if a session was not started
+ (instancetype)eventForSessionEnd;

@end
