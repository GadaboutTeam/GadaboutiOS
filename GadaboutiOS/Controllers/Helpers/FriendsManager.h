//
//  FriendsController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 27/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface FriendsManager : NSObject

+ (id)sharedFriendsController;
- (NSArray *)getNearbyFriends;
- (void)getFacebookFriends;
- (void)getPictureForID:(User *)friend onCompletion:(void (^)())completionBlock;
+ (NSArray *)getFriendsFromInvitations:(NSArray *)invitations;

@end
