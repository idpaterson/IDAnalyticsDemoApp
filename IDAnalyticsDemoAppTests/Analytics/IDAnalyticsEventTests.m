//
//  IDAnalyticsEventTests.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/12/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "IDAnalyticsEvent.h"
#import "IDAnalyticsEvent+Protected.h"

@interface IDAnalyticsEventTests : XCTestCase

/// <#description#>
@property (nonatomic, strong) IDAnalyticsEvent * event;

@end

@implementation IDAnalyticsEventTests

NSString * const _defaultAttributeKey = @"Key";
NSString * const _defaultAttributeValue = @"Value";

- (void)setUp
{
    [super setUp];

    self.event = [[IDAnalyticsEvent alloc] initWithName:@"Sample Event"
                                             attributes:@{ _defaultAttributeKey: _defaultAttributeValue }];
}

- (void)tearDown
{
    [super tearDown];

    self.event = nil;
}

#pragma mark - Attributes

- (void)testStrictMutabilityOfAttributes
{
    XCTAssert(![self.event.attributes isKindOfClass:[NSMutableDictionary class]], @"");
    XCTAssert([self.event.attributes isKindOfClass:[NSDictionary class]], @"");
}

- (void)testStrictCopyOfInitializationAttributes
{
    NSMutableDictionary * attributes = [NSMutableDictionary dictionaryWithObject:_defaultAttributeValue
                                                                          forKey:_defaultAttributeKey];
    IDAnalyticsEvent * event = [[IDAnalyticsEvent alloc] initWithName:@"Sample Event"
                                                           attributes:attributes];

    XCTAssertEqualObjects(event.attributes[_defaultAttributeKey], _defaultAttributeValue, @"");

    NSString * newKey = @"Key2";
    NSString * newValue = @"Value2";

    // If attributes were assigned rather than copied this could update the event
    attributes[newKey] = newValue;

    XCTAssertEqualObjects(event.attributes[_defaultAttributeKey], _defaultAttributeValue, @"");
    XCTAssertNil(event.attributes[newKey], @"");
}

- (void)testAttributesSetAtInitialization
{
    XCTAssertEqualObjects(self.event.attributes[_defaultAttributeKey], _defaultAttributeValue, @"");
}

- (void)testAttributesSetAfterInitialization
{
    NSString * newKey = @"Key2";
    NSString * newValue = @"Value2";
    [self.event setValue:newValue forAttribute:newKey];

    XCTAssertEqualObjects(self.event.attributes[_defaultAttributeKey], _defaultAttributeValue, @"");
    XCTAssertEqualObjects(self.event.attributes[newKey], newValue, @"");
}

- (void)testSetReplacesAttribute
{
    NSString * newValue = @"Value2";
    XCTAssertEqualObjects(self.event.attributes[_defaultAttributeKey], _defaultAttributeValue, @"");

    [self.event setValue:newValue forAttribute:_defaultAttributeKey];

    XCTAssertEqualObjects(self.event.attributes[_defaultAttributeKey], newValue, @"");
}

- (void)testSetNilRemovesAttribute
{
    XCTAssertEqualObjects(self.event.attributes[_defaultAttributeKey], _defaultAttributeValue, @"");

    [self.event setValue:nil forAttribute:_defaultAttributeKey];

    XCTAssertNil(self.event.attributes[_defaultAttributeKey], @"");
}

@end
