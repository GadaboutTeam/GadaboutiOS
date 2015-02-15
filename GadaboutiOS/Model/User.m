//
//  User.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 02/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "User.h"

@implementation User

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{};
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

+ (NSString *)primaryKey {
    return @"userID";
}

@end
