//
//  IDAnalyticsEvent.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsEvent.h"

#import "IDAnalyticsEvent+Protected.h"
#import "IDAnalyticsMediator.h"

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

#pragma mark - Logging

- (NSString *)modelName
{
    NSString * className = NSStringFromClass([self class]);

    // Strip the IDAnalytics prefix
    if ([className hasPrefix:@"IDAnalytics"])
    {
        return [className substringFromIndex:11];
    }

    return className;
}

- (NSString *)description
{
    NSDictionary     * attributes = self.attributes;
    NSMutableArray   * lines      = [NSMutableArray arrayWithCapacity:2 + attributes.count];
    __block NSString * line;
    NSUInteger         maxNameLength = 0;

    // The max length is used to align the attribute names
    for (NSString * name in attributes)
    {
        if (name.length > maxNameLength)
        {
            maxNameLength = name.length;
        }
    }

    // Add the name of the event following the native description
    line = [super description];
    [lines addObject:line];
    line = [NSString stringWithFormat:@"%@ Name: %@", self.modelName, self.name];
    [lines addObject:line];

    // Add one line for each attribute with the names left-aligned in one column
    // and all values left-aligned in a second column.
    [attributes enumerateKeysAndObjectsUsingBlock:^(NSString * name, id value, BOOL * stop) {
        line = [NSString stringWithFormat:@"\t%-*s : %@", maxNameLength, name.UTF8String, value];
        [lines addObject:line];
    }];

    return [lines componentsJoinedByString:@"\n"];
}

#pragma mark - Transformations

- (instancetype)eventWithAttributesOfClass:(Class)class transformedBy:(IDAnalyticsEventAttributeTransformingBlock)transformBlock
{
    if (!transformBlock)
    {
        return self;
    }

    id event = [[self class] eventWithName:self.name];

    [self.attributes enumerateKeysAndObjectsUsingBlock:^(NSString * name, id value, BOOL *stop) {
        id newValue = value;

        if ([value isKindOfClass:class])
        {
            newValue = transformBlock(name, value);
        }

        if (newValue)
        {
            [event setValue:newValue forAttribute:name];
        }
    }];

    return event;
}

#pragma mark - Events

- (void)track
{
    [[IDAnalyticsMediator sharedMediator] trackEvent:self options:nil];
}

@end
