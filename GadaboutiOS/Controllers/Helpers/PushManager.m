//
//  PushController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 20/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "PushManager.h"

#import <Parse/Parse.h>

#import "UserManager.h"
#import "NetworkingManager.h"
#import "User.h"

@implementation PushManager

+ (void)sendParsePushNotificationTo:(NSArray<User> *)usersArray message:(NSString *)message block:(void (^)())block {
    for (User *user in usersArray) {
        PFQuery *friendQuery = [[PFQuery alloc] initWithClassName:@"User"];
        [friendQuery whereKey:@"auth_id" equalTo:[user facebookID]];
        [friendQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (object != nil) {
                NSString *deviceToken = [NSString stringWithFormat:@"%@", [object valueForKey:@"device_id"]];
                PFQuery *installationQuery = [[PFInstallation query] whereKey:@"deviceToken" equalTo:deviceToken];
                PFPush *push = [[PFPush alloc] init];
                [push setQuery:installationQuery];
                [push setMessage:message];
                [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError * __nullable error) {
                    if (succeeded) {
                        block();
                    }
                }];
            }
        }];
    }
}

+ (void)sendNotificationDictionary:(NSDictionary *)notificationDictionary toService:(NSString *)service
                   completionBlock:(void (^)(id, NSError *))block {
    [[NetworkingManager sharedNetworkingManger] requestWithDictionary:notificationDictionary fromService:service completion:block];
}

@end
