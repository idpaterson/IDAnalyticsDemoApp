//
//  IDAnalyticsServiceSegmentIO.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/15/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDAnalyticsService.h"

/// The display name of the Segment.io service, `IDAnalyticsServiceSegmentIO`.
OBJC_EXPORT NSString * const IDAnalyticsServiceNameSegmentIO;

///
/// Provides standardized access to the Segment.io SDK for use with
/// <IDAnalyticsMediator>.
///
/// Care should be taken to avoid storing the secret key in any accessible
/// format. Any property lists bundled with the app are easily accessible to end
/// users; where possible the secret key should be compiled into the app. For
/// apps with multiple analytics configurations, the secret can be specified in
/// an `xcconfig` file in `GCC_PREPROCESSOR_DEFINITIONS`.
///
@interface IDAnalyticsServiceSegmentIO : NSObject
<IDAnalyticsService>

/// Sets the secret key for use with the Segment.io API.
///
/// This method should be called after enabling logging (if desired) and before
/// any further interaction with analytics.
///
/// @param secret The Segment.io API secret key
+ (void)initializeWithSecret:(NSString *)secret;

/// Returns the `IDAnalyticsServiceSegmentIO` singleton instance.
///
/// While this pattern should generally be avoided in `IDAnalyticsService`
/// implementations, the Segment.io SDK does not support multiple instances.
/// Therefore, similarly only one instance of this class should exist at any
/// given time.
///
/// @return A singleton `IDAnalyticsServiceSegmentIO` instance representing the
/// singleton Segment.io `Analytics` instance.
+ (instancetype)sharedInstance;

@end
