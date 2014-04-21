//
//  IDAnalyticsEvent+ThermostatEvents.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsEvent.h"

typedef NS_ENUM (NSInteger, IDAnalyticsThermostatAdjustmentInitiation)
{
    IDAnalyticsThermostatAdjustmentSpinDialInitiation,
    IDAnalyticsThermostatAdjustmentFlingDialInitiation,
    IDAnalyticsThermostatAdjustmentTapDialInitiation,
};

@interface IDAnalyticsEvent (ThermostatEvents)

#pragma mark - Initiations

+ (void)initiateThermostatAdjustment:(IDAnalyticsThermostatAdjustmentInitiation)initiation;

@end
