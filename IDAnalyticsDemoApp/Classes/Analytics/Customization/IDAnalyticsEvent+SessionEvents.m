//
//  IDAnalyticsEvent+SessionEvents.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/20/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsEvent+SessionEvents.h"

#import "IDAnalyticsEvent+Protected.h"

@implementation IDAnalyticsEvent (SessionEvents)

static NSDate * _sessionStartDate = nil;

#pragma mark - Session Events

+ (instancetype)eventForSessionStart
{
    IDAnalyticsEvent * event = nil;

    @synchronized(self)
    {
        // Avoid starting a session without ending the previous one first
        if (!_sessionStartDate)
        {
            _sessionStartDate = [NSDate date];

            // Could track the time since the previous session
            event = [IDAnalyticsEvent eventWithName:@"Session Started"
                                         attributes:nil];
        }
    }
    return event;
}

+ (instancetype)eventForSessionEnd
{
    IDAnalyticsEvent * event = nil;

    @synchronized(self)
    {
        if (_sessionStartDate)
        {
            event = [IDAnalyticsEvent eventWithName:@"Session Ended"
                                         attributes:nil];

            [event setValue:@(-[_sessionStartDate timeIntervalSinceNow])
               forAttribute:@"Session length (seconds)"];
            
            _sessionStartDate = nil;
        }
    }
    return event;
}


@end
