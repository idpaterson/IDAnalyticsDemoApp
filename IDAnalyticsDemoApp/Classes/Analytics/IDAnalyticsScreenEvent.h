//
//  IDAnalyticsScreenEvent.h
//  IDAnalyticsDemoApp
//
//  Created by Ian Paterson on 5/13/14.
//  Copyright (c) 2014 Ian Paterson. All rights reserved.
//

#import "IDAnalyticsEvent.h"

///
/// Tracks screen views and any associated attributes that are relevant to the
/// screen.
///
/// It is important to provide consistent, human readable, and adequately
/// precise naming for screens. For example, while it may be easy to use the
/// name of the view controller class as the screen name, this will certainly
/// bewilder anyone lacking an intimate understanding of the code.
///
/// Furthermore, screens that are configured based on an object may be better
/// represented by the name of the object than a generic name like
/// "Topic Screen". This is a judgment call, if there are going to be 10,000
/// variations of this screen it is probably better to record a generic name and
/// represent the topic name as an attribute. If the universe of possible values
/// numbers less than 20 or 30 it might be easiest for analysis to record each
/// screen with the name of its topic.
///
/// Finally, be mindful of translated text. If the same screen appears in both
/// the Spanish and English versions of your app, you probably don't want to
/// record that screen with two separate names. Try to maintain a consistent
/// language for all text sent to analytics services. This will probably require
/// use of `-[NSBundle URLForResource:withExtension:subdirectory:localization:]`
/// followed by `+[NSDictionary dictionaryWithContentsOfURL:]`, which can be
/// held in memory to avoid re-reading that entire file for every string.
///
/// Not all analytics services support screen events. Your implementation may
/// vary depending on the target analytis service. If a service does not support
/// screen tracking, it is better to mediate that in the corresponding
/// <IDAnalayticsService>-conforming class than to simply not record
/// `IDAnalyticsScreenEvent` at all.
///
@interface IDAnalyticsScreenEvent : IDAnalyticsEvent

/// The name that will be recorded for the screen.
@property (nonatomic, strong, readonly) NSString * screenName;

@end
