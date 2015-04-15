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
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreLocation/CoreLocation.h>

// app specific imports
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
        self.userController = [UserController sharedUserController];
        self.networkingManager = [NetworkingManager sharedNetworkingManger];
        self.friendsArray = [[NSMutableArray alloc] init];
    }

    return self;
}

- (NSArray *)getNearbyFriends {
    // initialziation
    RLMResults *results = [User objectsWhere:[NSString stringWithFormat:@"userType = %ld", UserTypeSelf]];
    User *me = [results firstObject];
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:me.lat longitude:me.lon];

    NSArray *sortedNearbyFriends;
    
    for (User *friend in self.friendsArray) {
        CLLocation *friendLocation = [[CLLocation alloc] initWithLatitude:friend.lat longitude:friend.lon];
        CLLocationDistance distance = [myLocation distanceFromLocation:friendLocation];
    }

    return sortedNearbyFriends;
}

// /users/auth_id/friends
- (void)getFacebookFriends {
    NSString *serviceString = @"/me/friends?fields=name,installed";
    [[[FBSDKGraphRequest alloc] initWithGraphPath:serviceString parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched results: %@", result);
             NSArray *friendsArray = [result valueForKey:@"data"];
             NSString *nextPage = [[result valueForKey:@"paging"] valueForKey:@"next"];
             [self persistFriends:friendsArray];
             
         } else {
             NSLog(@"Error: %@", error);
         }
     }];
}

- (void)persistFriends:(NSArray *)friends {
    for (NSDictionary *fbFriend in friends) {
        User *friend = [[User alloc] init];
        [friend setFacebookID:[fbFriend valueForKey:@"id"]];
        [friend setDisplayName:[fbFriend valueForKey:@"name"]];
        [friend setUserType:UserTypeFriend];

        long hasApp = [[fbFriend valueForKey:@"installed"] integerValue];
        if (hasApp == 1) {
            [friend setHasApp:true];
        } else {
            [friend setHasApp:false];
        }

        [[RLMRealm defaultRealm] beginWriteTransaction];
        [User createOrUpdateInDefaultRealmWithObject:friend];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        
    }
}


@end
