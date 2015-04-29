//
//  PushController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 20/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "User.h"

@interface PushManager : NSObject

+ (void)sendParsePushNotificationTo:(NSArray *)usersArray message:(NSString *)message block:(void (^)())block;
+ (void)sendNotificationDictionary:(NSDictionary *)notificationDictionary toService:(NSString *)service
                   completionBlock:(void (^)(id, NSError *))block;
+ (void)handlePushNotification:(NSDictionary *)userInfo navController:(UINavigationController *)rootNavController;
@end
