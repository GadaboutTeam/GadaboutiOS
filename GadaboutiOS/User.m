//
//  User.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 02/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "User.h"
#import <Foundation/Foundation.h>

@implementation User

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    // Placeholder profile image
    UIImage *image = [UIImage imageNamed:@"profile_placeholder"];
    NSData *imageData = UIImagePNGRepresentation(image);
    return @{@"profilePhoto" : imageData};
}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"facebookID", @"name", @"friends"];
}

+ (NSString *)primaryKey {
    return @"userID";
}

@end
