//
//  IDAnalyticsEvent+Protected.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

@interface IDAnalyticsEvent ()

+ (instancetype)eventWithName:(NSString *)name;
+ (instancetype)eventWithName:(NSString *)name attributes:(NSDictionary *)attributes;
- (instancetype)initWithName:(NSString *)name attributes:(NSDictionary *)attributes;

- (void)setValue:(id)value forAttribute:(NSString *)attribute;
- (id)valueForAttribute:(NSString *)attribute;

- (BOOL)addAttributesForInitiation:(NSInteger *)initiationCodePtr labels:(NSArray *)initiationLabels;

@end
