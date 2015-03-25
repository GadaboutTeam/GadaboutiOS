//
//  Person.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "User.h"

@implementation User

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"displayName" : @"displayName", @"authToken" : @"authToken"};
}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"lat", @"lon"];
}

+ (NSString *)primaryKey {
    return @"phoneNumber";
}

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"username" : @"displayName",
             @"auth_id"  : @"phoneNumber",
             @"auth_token" : @"authToken",
             @"lat" : @"lat",
             @"long" : @"lon"
             };
}

+ (NSDictionary *)JSONOutboundMappingDictionary {
    return @{
             @"displayName" : @"username",
             @"phoneNumber" : @"auth_id",
             @"authToken" : @"auth_token",
             @"lat" : @"lat",
             @"lon" : @"long"
             };
}

@end
