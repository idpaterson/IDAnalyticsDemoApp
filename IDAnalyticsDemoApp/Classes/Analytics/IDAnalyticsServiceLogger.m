//
//  IDAnalyticsServiceLogger.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/15/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsServiceLogger.h"

NSString * const IDAnalyticsServiceNameLogger = @"Analytics Logger";

@implementation IDAnalyticsServiceLogger

@synthesize debugLoggingEnabled = _debugLoggingEnabled;
@synthesize trackingEnabled     = _trackingEnabled;

+ (NSString *)serviceName
{
    return IDAnalyticsServiceNameLogger;
}

#pragma mark - Initialization

+ (id)sharedInstance
{
    // Thread-safe singleton
    static IDAnalyticsServiceLogger * sharedInstance = nil;

    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        sharedInstance = [IDAnalyticsServiceLogger new];
    });

    return sharedInstance;
}

- (id)init
{
    self = [super init];

    if (self)
    {
        _debugLoggingEnabled = YES;
        _trackingEnabled     = YES;
    }

    return self;
}


#pragma mark - IDAnalyticsService implementation

- (void)reset
{
    if (_debugLoggingEnabled)
    {
        IDLogAnalytics(@"Reset cached user info");
    }
}

- (void)trackEvent:(IDAnalyticsEvent *)event options:(NSDictionary *)options
{
    if (_trackingEnabled && _debugLoggingEnabled)
    {
        IDLogAnalytics(@"%@", event);
    }
}

- (void)trackScreen:(IDAnalyticsScreenEvent *)screenEvent options:(NSDictionary *)options
{
    if (_trackingEnabled && _debugLoggingEnabled)
    {
        IDLogAnalytics(@"%@", screenEvent);
    }
}

- (void)setTrackingEnabled:(BOOL)trackingEnabled
{
    [self willChangeValueForKey:@"trackingEnabled"];
    _trackingEnabled = trackingEnabled;
    [self didChangeValueForKey:@"trackingEnabled"];

    if (_debugLoggingEnabled)
    {
        IDLogAnalytics(@"Analytics tracking %@", trackingEnabled ? @"enabled" : @"disabled");
    }
}

- (void)setDebugLoggingEnabled:(BOOL)debugLoggingEnabled
{
    [self willChangeValueForKey:@"debugLoggingEnabled"];
    _debugLoggingEnabled = debugLoggingEnabled;
    [self didChangeValueForKey:@"debugLoggingEnabled"];

    IDLogAnalytics(@"Debug logging %@", debugLoggingEnabled ? @"enabled" : @"disabled");
}

@end
