//
//  IDAnalyticsEvent+ThermostatEvents.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsEvent.h"

/// Describes how the thermostat dial was adjusted
typedef NS_ENUM (NSInteger, IDAnalyticsThermostatAdjustmentInitiation)
{
    /// The user tapped the dial then with their finger held down, turned it to
    /// the desired position and released.
    IDAnalyticsThermostatAdjustmentSpinDialInitiation,
    /// The user tapped the dial then flicked to release the dial with enough
    /// velocity that it would have to decelerate before stopping on a value.
    IDAnalyticsThermostatAdjustmentFlingDialInitiation,
    /// The user tapped and released directly on the desired value.
    IDAnalyticsThermostatAdjustmentTapDialInitiation,
};

@interface IDAnalyticsEvent (ThermostatEvents)

#pragma mark - Initiations

/// Sets the initiation for the *Adjusted Thermostat* event.
///
/// @param initiation The initiation
+ (void)initiateThermostatAdjustment:(IDAnalyticsThermostatAdjustmentInitiation)initiation;

@end
