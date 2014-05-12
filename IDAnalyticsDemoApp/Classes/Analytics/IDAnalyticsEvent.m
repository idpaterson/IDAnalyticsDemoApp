//
//  IDAnalyticsEvent.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsEvent.h"

#import "IDAnalyticsEvent+Protected.h"

NSInteger const IDAnalyticsUnknownInitiation = -1;

@implementation IDAnalyticsEvent

static NSString * const IDAnalyticsEventInitiatedByAttribute = @"Initiated By";

#pragma mark - Initialization

- (instancetype)initWithName:(NSString *)name attributes:(NSDictionary *)attributes
{
    self = [super init];

    if (self)
    {
        _name       = [name copy];
        _attributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
    }

    return self;
}

+ (instancetype)eventWithName:(NSString *)name attributes:(NSDictionary *)attributes
{
    return [[self alloc] initWithName:name attributes:attributes];
}

+ (instancetype)eventWithName:(NSString *)name
{
    return [[self alloc] initWithName:name attributes:nil];
}

#pragma mark - Attributes

- (NSDictionary *)attributes
{
    // Immutable non-nil copy
    return [NSDictionary dictionaryWithDictionary:_attributes];
}

- (void)setValue:(id)value forAttribute:(NSString *)attribute
{
    if (attribute)
    {
        if (value)
        {
            [_attributes setObject:value forKey:attribute];
        }
        else
        {
            [_attributes removeObjectForKey:attribute];
        }
    }
}

- (id)valueForAttribute:(NSString *)attribute
{
    if (attribute)
    {
        return _attributes[attribute];
    }
    return nil;
}

- (void)addDefaultAttributes
{
    NSString * attributeName;
    id         value;

    attributeName = @"Device Orientation";
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        value = @"Landscape";
    }
    else
    {
        value = @"Portrait";
    }
    _attributes[attributeName] = value;
}

- (BOOL)addAttributesForInitiation:(NSInteger *)initiationCodePtr labels:(NSArray *)initiationLabels
{
    NSInteger initiationCode = *initiationCodePtr;

    if ((initiationCode < 0) || (initiationCode >= initiationLabels.count))
    {
        IDLogWarn(@"%@ event has no recorded initiation", self.name);
        return NO;
    }

    [_attributes setValue:[initiationLabels objectAtIndex:initiationCode]
                   forKey:IDAnalyticsEventInitiatedByAttribute];

    // Reset to unknown to avoid carrying over past initiations
    *initiationCodePtr = IDAnalyticsUnknownInitiation;

    return YES;
}

#pragma mark - Events

#pragma mark Session Events

+ (instancetype)eventForSessionStart
{
    return [IDAnalyticsEvent eventWithName:@"Session Started"
                                attributes:nil];
}

+ (instancetype)eventForSessionEnd
{
    return [IDAnalyticsEvent eventWithName:@"Session Ended"
                                attributes:nil];
}

@end
