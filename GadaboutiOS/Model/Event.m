//
//  Event.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 20/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)init {
    if (self = [super init]) {
        [self configureEvent];
    }
    return self;
}

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"title" : @"name",
             @"id" : @"event_id"
             };
}

+ (NSDictionary *)JSONOutboundMappingDictionary {
    return @{
             @"name" : @"title",
             @"event_id" : @"id"
             };
}

+ (NSString *)primaryKey {
    return @"event_id";
}

- (void)configureEvent {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'hh:mm:ssZZ"];

    [self setStart_time:[formatter stringFromDate:[NSDate date]]];
    [self setEnd_time:[formatter stringFromDate:[NSDate dateWithTimeInterval:60*60 sinceDate:[NSDate date]]]];
}

@end
