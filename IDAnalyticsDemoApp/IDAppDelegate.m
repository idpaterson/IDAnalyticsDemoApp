//
//  IDAppDelegate.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAppDelegate.h"

#import "IDAnalyticsEvent.h"
#import "IDAnalyticsEvent+SessionEvents.h"
#import "IDAnalyticsMediator.h"
#import "IDAnalyticsServiceLogger.h"
#import "IDAnalyticsServiceSegmentIO.h"

@implementation IDAppDelegate

- (void)setupAnalytics
{
    [IDAnalyticsServiceSegmentIO initializeWithSecret:@"sample-secret"];

    IDAnalyticsServiceLogger    * loggerService    = [IDAnalyticsServiceLogger sharedInstance];
    IDAnalyticsServiceSegmentIO * segmentIOService = [IDAnalyticsServiceSegmentIO sharedInstance];
    IDAnalyticsMediator         * mediator         = [IDAnalyticsMediator sharedMediator];

    [mediator registerAnalyticsService:loggerService];
    [mediator registerAnalyticsService:segmentIOService];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupAnalytics];

    [[IDAnalyticsEvent eventForSessionStart] track];

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // This is pretty naive, it's better to use
    // -[UIApplication beginBackgroundTaskWithExpirationHandler:] to keep the
    // app running for 30 or 60 seconds before recording the session end so that
    // toggling quickly between apps to complete a task within your app does not
    // result in a new session.
    [[IDAnalyticsEvent eventForSessionEnd] track];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[IDAnalyticsEvent eventForSessionStart] track];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[IDAnalyticsEvent eventForSessionEnd] track];
}

@end
