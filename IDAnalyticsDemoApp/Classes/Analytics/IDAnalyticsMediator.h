//
//  IDAnalyticsManager.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/12/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDAnalyticsService.h"

@interface IDAnalyticsMediator : NSObject
<IDAnalyticsService>
{
    NSMutableArray * _services;
}

+ (instancetype)sharedMediator;

- (void)registerAnalyticsService:(id<IDAnalyticsService>)service;

@end
