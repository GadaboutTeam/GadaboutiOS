//
//  Person.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "Friend.h"

@implementation Friend

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
