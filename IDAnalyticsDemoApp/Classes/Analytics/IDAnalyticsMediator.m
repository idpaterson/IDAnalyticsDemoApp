//
//  IDAnalyticsManager.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/12/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsMediator.h"

#import "IDAnalyticsService.h"

@implementation IDAnalyticsMediator

@synthesize debugLoggingEnabled = _debugLoggingEnabled;
@synthesize trackingEnabled = _trackingEnabled;

+ (instancetype)sharedMediator
{
    // Thread-safe singleton
    static IDAnalyticsMediator * sharedMediator = nil;
    static dispatch_once_t       oncePredicate;

    dispatch_once(&oncePredicate, ^{
        sharedMediator = [IDAnalyticsMediator new];
    });

    return sharedMediator;
}

- (id)init
{
    self = [super init];

    if (self)
    {
        _services = [NSMutableArray array];
    }

    return self;
}

- (void)registerAnalyticsService:(id<IDAnalyticsService>)service
{
    if (!service || ![service conformsToProtocol:@protocol(IDAnalyticsService)])
    {
        IDLogWarn(@"Attempted to register an invalid analytics service: %@", service);
        return;
    }

    @synchronized(_services)
    {
        if (![_services containsObject:service])
        {
            [_services addObject:service];
        }
    }
}

- (void)trackEvent:(IDAnalyticsEvent *)event
{

}

- (void)trackScreen:(IDAnalyticsScreenEvent *)screenEvent
{

}

#pragma mark - IDAnalyticsService implementation

- (void)reset
{
    @synchronized(_services)
    {
        [_services makeObjectsPerformSelector:@selector(reset)];
    }
}

- (void)trackEvent:(IDAnalyticsEvent *)event options:(NSDictionary *)options
{
    @synchronized(_services)
    {
        for (id<IDAnalyticsService> service in _services)
        {
            [service trackEvent:event options:options];
        }
    }
}

- (void)trackScreen:(IDAnalyticsScreenEvent *)screenEvent options:(NSDictionary *)options
{
    @synchronized(_services)
    {
        for (id<IDAnalyticsService> service in _services)
        {
            [service trackScreen:screenEvent options:options];
        }
    }
}

- (void)setDebugLoggingEnabled:(BOOL)debugLoggingEnabled
{
    [self willChangeValueForKey:@"debugLoggingEnabled"];

    _debugLoggingEnabled = debugLoggingEnabled;

    @synchronized(_services)
    {
        for (id<IDAnalyticsService> service in _services)
        {
            [service setDebugLoggingEnabled:debugLoggingEnabled];
        }
    }

    [self didChangeValueForKey:@"debugLoggingEnabled"];
}

- (void)setTrackingEnabled:(BOOL)trackingEnabled
{
    [self willChangeValueForKey:@"trackingEnabled"];

    _trackingEnabled = trackingEnabled;

    @synchronized(_services)
    {
        for (id<IDAnalyticsService> service in _services)
        {
            [service setTrackingEnabled:trackingEnabled];
        }
    }

    [self didChangeValueForKey:@"trackingEnabled"];
}

@end
