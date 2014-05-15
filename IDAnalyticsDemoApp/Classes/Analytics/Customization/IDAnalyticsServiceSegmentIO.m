//
//  IDAnalyticsServiceSegmentIO.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/15/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsServiceSegmentIO.h"

// Segment.io
#import <Analytics/Analytics.h>

#import "IDAnalyticsEvent.h"
#import "IDAnalyticsScreenEvent.h"

NSString * const IDAnalyticsServiceNameSegmentIO = @"Segment.io";

@interface IDAnalyticsServiceSegmentIO ()

/// Provides access to an instance of this service's SDK.
///
/// This is a good pattern to follow because it allows (for services that allow
/// non-static initialization) multiple IDAnalyticsService instances for the
/// same service but with different identifiers.
///
/// Since Segment.io only has a static `+initializeWithSecret:` this property
/// is readonly, returning the shared instance.
@property (nonatomic, strong, readonly) Analytics * analyticsInstance;

@end

@implementation IDAnalyticsServiceSegmentIO

static BOOL _segmentIODebugLoggingEnabled = NO;

@synthesize trackingEnabled = _trackingEnabled;

+ (NSString *)serviceName
{
    return IDAnalyticsServiceNameSegmentIO;
}

#pragma mark - Initialization

+ (id)sharedInstance
{
    // Thread-safe singleton
    static IDAnalyticsServiceSegmentIO * sharedInstance = nil;

    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        sharedInstance = [IDAnalyticsServiceSegmentIO new];
    });

    return sharedInstance;
}

+ (void)initializeWithSecret:(NSString *)secret
{
    [Analytics initializeWithSecret:secret];
}

- (Analytics *)analyticsInstance
{
    return [Analytics sharedAnalytics];
}

#pragma mark - IDAnalyticsService implementation

- (void)reset
{
    [self.analyticsInstance reset];
}

- (void)trackEvent:(IDAnalyticsEvent *)event options:(NSDictionary *)options
{
    [self.analyticsInstance track:event.name
                       properties:event.attributes
                          options:options];
}

- (void)trackScreen:(IDAnalyticsScreenEvent *)screenEvent options:(NSDictionary *)options
{
    [self.analyticsInstance screen:screenEvent.screenName
                        properties:screenEvent.attributes
                           options:options];
}

- (void)setDebugLoggingEnabled:(BOOL)debugLoggingEnabled
{
    [self willChangeValueForKey:@"debugLoggingEnabled"];

    [Analytics debug:debugLoggingEnabled];
    _segmentIODebugLoggingEnabled = debugLoggingEnabled;

    [self didChangeValueForKey:@"debugLoggingEnabled"];
}

- (BOOL)isDebugLoggingEnabled
{
    // The Segment.io SDK does not allow us to test whether logging is enabled
    // and enabling it on one IDAnalyticsServiceSegmentIO would enable it on
    // all, so a static variable is used to track the value.
    return _segmentIODebugLoggingEnabled;
}

- (void)setTrackingEnabled:(BOOL)trackingEnabled
{
    [self willChangeValueForKey:@"trackingEnabled"];

    if (trackingEnabled)
    {
        [self.analyticsInstance enable];
    }
    else
    {
        [self.analyticsInstance disable];
    }

    _trackingEnabled = trackingEnabled;

    [self didChangeValueForKey:@"trackingEnabled"];
}

- (void)registerRemoteNotificationsDeviceToken:(NSData *)deviceToken
{
    [self.analyticsInstance registerPushDeviceToken:deviceToken];
}

@end
