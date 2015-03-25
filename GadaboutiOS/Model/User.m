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
    return @{@"displayName" : @"displayName", @"phoneNumber" : @"phoneNumber"};
}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"lat", @"lon"];
}

+ (NSString *)primaryKey {
    return @"authToken";
}

// username, auth_id, auth_token, lat, long
- (NSDictionary *)prepareDictionary {
    return @{@"username" : _displayName,
              @"auth_id" : _phoneNumber,
           @"auth_token" : _authToken,
                  @"lat" : [NSString stringWithFormat:@"%ld", (long)_lat],
                 @"long" : [NSString stringWithFormat:@"%ld", (long)_lon]};
}

@end
