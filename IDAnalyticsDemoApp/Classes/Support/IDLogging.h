//
//  IDLogging.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 4/1/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#ifndef IDAnalyticsDemoApp_IDLogging_h
#define IDAnalyticsDemoApp_IDLogging_h

#define IDLogWithPrefix(enabled, prefix, fmt, ...) \
   if (enabled) NSLog(@"%9s: %@", [prefix UTF8String], [NSString stringWithFormat:fmt, ## __VA_ARGS__])

#define ID_LOG_INFO 1
#define IDLogInfo(fmt, ...) \
   IDLogWithPrefix(ID_LOG_INFO, @"INFO", fmt, ## __VA_ARGS__)

#define ID_LOG_DEBUG 1
#define IDLogDebug(fmt, ...) \
   IDLogWithPrefix(ID_LOG_DEBUG, @"DEBUG", fmt, ## __VA_ARGS__)

#define ID_LOG_WARN 1
#define IDLogWarn(fmt, ...) \
   IDLogWithPrefix(ID_LOG_WARN, @"WARN", fmt, ## __VA_ARGS__)

#define ID_LOG_ERROR 1
#define IDLogError(fmt, ...) \
   IDLogWithPrefix(ID_LOG_ERROR, @"ERROR", fmt, ## __VA_ARGS__)

#define ID_LOG_ANALYTICS 1
#define IDLogAnalytics(fmt, ...) \
   IDLogWithPrefix(ID_LOG_ANALYTICS, @"ANALYTICS", fmt, ## __VA_ARGS__)

#endif
