//
//  Message.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/24/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "Message.h"

@implementation Message

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{};
}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[];
}

@end
