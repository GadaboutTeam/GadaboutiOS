//
//  Event.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 20/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "Event.h"

@implementation Event

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

@end
