//
//  FriendsController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 27/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FriendsController.h"
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

//
// /users/auth_id/friends
- (NSArray *)getNearbyFriends {
//    NSArray *nearbyFriends = [[NSArray alloc] init];
    NSString *serviceString = [NSString stringWithFormat:@"/users/%@/friends",[[_userController getCurrentUser] authToken]];

    [_networkingManager requestWithDictionary:nil
                                  fromService:serviceString
                                   completion:^(id response, NSError *error) {
                                       if (error == nil) {
                                           NSError *serializationError;
                                           NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&serializationError];
                                           if (!error) {
                                                NSLog(@"Friends array: %@", @"ugh");
                                           } else {
                                               NSLog(@"JSON parsing error: %@", [error description]);
                                           }
                                       }
                                }];

    return nil;
}

@end
