//
//  Person.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "User.h"
#import "AppDelegate.h"

@implementation User

- (id)init {
    self = [super init];

    if (self != nil) {

    }

    return self;
}

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"displayName" : @"displayName", @"authToken" : @"authToken",
             @"deviceID" : @"" , @"email" : @"email",
             @"hasApp" : @false, @"loggedIn" : @false, @"pictureURL" : @"url"};
}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"lat", @"lon", @"loggedIn", @"relativeDistance"];
}

+ (NSString *)primaryKey {
    return @"facebookID";
}

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
             @"username" : @"displayName",
             @"auth_id"  : @"facebookID",
             @"auth_token" : @"authToken",
             @"lat" : @"lat",
             @"long" : @"lon"
             };
}

+ (NSDictionary *)JSONOutboundMappingDictionary {
    return @{
          @"facebookID" : @"auth_id",
          @"displayName" : @"username",
            @"authToken" : @"auth_token",
             @"deviceID" : @"device_id",
                  @"lat" : @"lat",
                  @"lon" : @"long",
             };
}

- (BOOL)isLoggedIn {
    return _loggedIn;
}

- (void)logIn {
    _loggedIn = true;
}

- (void)logOut {
    _loggedIn = false;
}

- (NSString *)getFirstName {
    return [[self.displayName componentsSeparatedByString:@" "] firstObject];
}

- (NSString *)getLastName {
    return [[self.displayName componentsSeparatedByString:@" "] lastObject];
}

@end
