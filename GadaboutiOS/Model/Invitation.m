//
//  Invitation.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 20/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "Invitation.h"

@implementation Invitation

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"title" : @"name",
             @"id" : @"invitation_id"
             };
}

+ (NSDictionary *)JSONOutboundMappingDictionary {
    return @{
             @"name" : @"title",
             @"invitation_id" : @"id"
             };
}

+ (NSString *)primaryKey {
    return @"invitation_id";
}

@end
