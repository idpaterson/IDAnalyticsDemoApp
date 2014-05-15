//
//  IDAnalyticsServiceLogger.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/15/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDAnalyticsService.h"

/// The display name of the analytics logging service,
/// `IDAnalyticsServiceLogger`.
OBJC_EXPORT NSString * const IDAnalyticsServiceNameLogger;

///
/// A service compatible with <IDAnalayticsMediator> that simply logs any events
/// or screens sent to it to the console. Register this service with the
/// mediator to enable logging.
///
/// To enable or disable logging at any time, just toggle the
/// `debugLoggingEnabled` property.
///    [IDAnalyticsServiceLogger sharedInstance].debugLoggingEnabled = YES;
///
@interface IDAnalyticsServiceLogger : NSObject
<IDAnalyticsService>

/// Returns the singleton instance of this service, which is preferred over
/// initializing multiple instances to ensure that debugging can be toggled from
/// any point in the app via the shared instance.
///
/// @return The singleton instance of this service.
+ (instancetype)sharedInstance;

/// Controls whether logging is enabled or disabled.
///
/// Since the purpose of this class is quite clear, logging is enabled by
/// default.
@property (nonatomic, assign, getter=isDebugLoggingEnabled) BOOL debugLoggingEnabled;

@end
