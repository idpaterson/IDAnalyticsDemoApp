//
//  IDAnalyticsService.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/14/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDAnalyticsEvent, IDAnalyticsScreenEvent;

///
/// Provides a consistent interface for adaptation to support multiple analytics
/// services. Classes conforming to this protocol can be registered with the
/// `IDAnalyticsMediator` to receive all events and other method calls.
///
@protocol IDAnalyticsService <NSObject>

/// A display name representing the service.
///
/// @return The service name
+ (NSString *)serviceName;

/// Resets any user state that is cached on the device.
///
/// This is useful when a user logs out and you want to clear the identity, or
/// for apps that include the option to fully disable tracking.
- (void)reset;

/// Sends the data for the specified event to the service API.
///
/// @param event   The event to record.
/// @param options Any options that the service supports when recording events.
- (void)trackEvent:(IDAnalyticsEvent *)event options:(NSDictionary *)options;

/// Sends the data for the specified screen view event to the service API.
///
/// @param screenEvent The screen event to record.
/// @param options     Any options that the service supports when recording
/// screen events.
- (void)trackScreen:(IDAnalyticsScreenEvent *)screenEvent options:(NSDictionary *)options;

/// Controls whether the service will log debug information to the console, for
/// services that support debug logging.
@property (nonatomic, assign, getter=isDebugLoggingEnabled) BOOL debugLoggingEnabled;

/// Enables or disables tracking to the analytics API.
///
/// When disabled, events cannot be recorded. Ensure that events are neither
/// submitted to the API nor recorded in a local cache.
///
/// The default value is `YES`; if tracking is disabled be sure to update this
/// property immediately after initializing the service.
@property (nonatomic, assign, getter=isTrackingEnabled) BOOL trackingEnabled;


@optional

/// Registers the given device to receive push notifications from services that
/// support push notification engagement.
///
/// For services that support push notifications, the device token will be
/// associated with the user such that notifications can be sent to any of their
/// devices. The device token must be as-received from
/// `-application:didRegisterForRemoteNotificationsWithDeviceToken:` after
/// registering for remote notifications.
///
/// @param deviceToken The token provided to the app delegate in
/// `-application:didRegisterForRemoteNotificationsWithDeviceToken:`
- (void)registerRemoteNotificationsDeviceToken:(NSData *)deviceToken;

@end
