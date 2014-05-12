//
//  IDAnalyticsEvent+Protected.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

@interface IDAnalyticsEvent ()

#pragma mark - Initialization
/// @name      Initialization

/// Creates a new event with the specified name and empty attributes.
///
/// @param name       The name of the event.
///
/// @return A new `IDAnalyticsEvent` with the specified name and empty
/// attributes.
+ (instancetype)eventWithName:(NSString *)name;

/// Creates a new event with the specified name and a shallow copy of the
/// specified attributes.
///
/// @param name       The name of the event.
/// @param attributes The attributes to record for the event.
///
/// @return A new `IDAnalyticsEvent` with the specified name and attributes.
+ (instancetype)eventWithName:(NSString *)name attributes:(NSDictionary *)attributes;

/// Creates a new event with the specified name and a shallow copy of the
/// specified attributes.
///
/// @param name       The name of the event.
/// @param attributes The attributes to record for the event.
///
/// @return A new `IDAnalyticsEvent` with the specified name and attributes.
- (instancetype)initWithName:(NSString *)name attributes:(NSDictionary *)attributes;

#pragma mark - Modifying Attributes
/// @name      Modifying Attributes

/// Updates the value for the specified attribute.
///
/// If the value is `nil`, the specified attribute will be removed from the
/// event. Set the value to `[NSNull null]` if a null value is intended.
///
/// @param value     The value to set.
/// @param attribute The name of the attribute of which to set the value.
- (void)setValue:(id)value forAttribute:(NSString *)attribute;

/// Returns the current value for the specified attribute.
///
/// @param attribute The name of the attribute.
///
/// @return The value of the attribute.
- (id)valueForAttribute:(NSString *)attribute;

/// Adds a standard `Initiated By` attribute with a value corresponding to the
/// label for the specified initiation.
///
/// The initiation code is provided as a pointer to allow this method to reset
/// the initiation to an invalid state (`IDAnalyticsUnknownInitiation`) after
/// using the initiation. Any actions that provide a default initiation must
/// check the value of the initiation code against `IDAnalyticsUnknownInitiation`
/// and apply the default value if necessary.
///
/// If the initiation code is `IDAnalyticsUnknownInitiation`, the `Initiated By`
/// attribute is not recorded.
///
/// @param initiationCodePtr A pointer to the initiation code for the event
/// @param initiationLabels  An array of strings indexed according to the
/// known initiation codes for the event.
///
/// @return A boolean indicating whether the `Initiated By` attribute was added.
- (BOOL)addAttributesForInitiation:(NSInteger *)initiationCodePtr labels:(NSArray *)initiationLabels;

@end
