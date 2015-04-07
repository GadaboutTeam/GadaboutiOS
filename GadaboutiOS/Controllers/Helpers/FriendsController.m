//
//  FriendsController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 27/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FriendsController.h"

// frameworks
#import <Realm/Realm.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "NetworkingManager.h"
#import "UserController.h"

@interface FriendsController ()

@property UserController *userController;
@property NSMutableArray *friendsArray;
@property NetworkingManager *networkingManager;

@end

@implementation FriendsController

+ (id)sharedFriendsController {
    static FriendsController *sharedFriendsController = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedFriendsController = [[self alloc] init];
    });

    return sharedFriendsController;
}

- (id)init {
    self = [super init];

    if (self) {
        _userController = [UserController sharedUserController];
        _networkingManager = [NetworkingManager sharedNetworkingManger];
        _friendsArray = [[NSMutableArray alloc] init];
    }

    return self;
}

// /users/auth_id/friends
- (void)getNearbyFriends {
    NSString *serviceString = [NSString stringWithFormat:@"/users/%@/friends",[[_userController getCurrentUser] authToken]];
    [[[FBSDKGraphRequest alloc] initWithGraphPath:serviceString parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched results: %@", result);
         } else {
             NSLog(@"Error: %@", error);
         }
     }];
}

- (void)getFacebookFriends {

}

@end
