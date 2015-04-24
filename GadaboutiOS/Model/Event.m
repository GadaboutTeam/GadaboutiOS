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

+ (NSDictionary *)defaultPropertyValues {
    return @{@"invitations" : [[RLMArray alloc] initWithObjectClassName:@"Invitation"]};
}

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"title" : @"name",
             @"id" : @"event_id",
             @"start_time" : @"start_time",
             @"end_time" : @"end_time",
             @"active" : @"active"
             };
}

+ (NSDictionary *)JSONOutboundMappingDictionary {
    return @{
             @"name" : @"title",
             @"event_id" : @"id",
             @"start_time" : @"start_time",
             @"end_time" : @"end_time",
             @"active" : @"active"
             };
}

+ (NSString *)primaryKey {
    return @"event_id";
}

- (void)configureEvent {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];

    [self setStart_time:[formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60]]];
    [self setEnd_time:[formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*2]]];

    [self setActive:YES];
}

@end
