//
//  IDAnalyticsScreenEvent.m
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/13/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsScreenEvent.h"

#import "IDAnalyticsMediator.h"

@implementation IDAnalyticsScreenEvent

- (NSString *)screenName
{
    return self.name;
}

- (void)track
{
    [[IDAnalyticsMediator sharedMediator] trackScreen:self options:nil];
}

@end
