//
//  IDAnalyticsManager.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/12/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDAnalyticsService.h"

///
/// Dispatches analytics calls to all registered services and provides a
/// foundation for higher-level analytics concepts.
///
/// For example, a combination of methods `startSession`, `pauseSession`,
/// `resumeSession`, and `endSession` could be implemented to manage the
/// background task concept where the Session Ended event is only tracked after
/// the app has been in the background for a certain length of time. It would be
/// cleaner to implement that logic here than in the app delegate, which can
/// simply call these 4 high-level methods.
///
@interface IDAnalyticsMediator : NSObject
<IDAnalyticsService>
{
    NSMutableArray * _services;
}

+ (instancetype)sharedMediator;

/// Adds the specified service to receive all events and other tracking calls.
///
/// @param service A service that has already been initialized with any API keys
/// or other initial setup
- (void)registerAnalyticsService:(id<IDAnalyticsService>)service;

@end
