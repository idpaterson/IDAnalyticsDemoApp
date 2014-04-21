//
//  IDAnalyticsEvent+ThermostatEvents.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsEvent+ThermostatEvents.h"

#import "IDAnalyticsEvent+Protected.h"

@implementation IDAnalyticsEvent (ThermostatEvents)

static IDAnalyticsThermostatAdjustmentInitiation _thermostatAdjustmentInitiation;

static NSArray * _thermostatAdjustmentInitiationLabels;

#pragma mark - Initialization

+ (void)initialize
{
    _thermostatAdjustmentInitiationLabels = @[@"Spun Dial",
                                              @"Flung Dial",
                                              @"Tapped Dial"];
}

#pragma mark - Events

+ (instancetype)eventForThermostatAdjustmentFromTemperature:(CGFloat)previousTemperature toTemperature:(CGFloat)temperature
{
    IDAnalyticsEvent * event = [IDAnalyticsEvent eventWithName:@"Adjusted Thermostat"];

    [event setValue:@(previousTemperature) forAttribute:@"Previous Temperature"];
    [event setValue:@(temperature) forAttribute:@"Temperature"];

    [event addAttributesForInitiation:&_thermostatAdjustmentInitiation
                               labels:_thermostatAdjustmentInitiationLabels];

    return event;
}

#pragma mark - Initiations

+ (void)initiateThermostatAdjustment:(IDAnalyticsThermostatAdjustmentInitiation)initiation
{
    _thermostatAdjustmentInitiation = initiation;
}

@end
