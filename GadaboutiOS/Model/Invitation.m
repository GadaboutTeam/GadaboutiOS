//
//  Invitation.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 20/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "Invitation.h"

@implementation Invitation

+ (NSString *)primaryKey {
    return @"invitation_id";
}

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"id" : @"invitation_id",
             @"event_id" : @"event_id",
             @"user_id" : @"user_id",
             @"reply" : @"reply"
             };
}

+ (NSDictionary *)JSONOutboundMappingDictionary {
    return @{
             @"invitation_id" : @"id",
             @"event_id" : @"event_id",
             @"sender_id" : @"user_id",
             @"reply" : @"reply"
             };
}

@end
