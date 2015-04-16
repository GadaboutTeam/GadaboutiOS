//
//  UserController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 26/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "UserController.h"
#import "NetworkingManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface UserController()
@property (nonatomic, retain) User *currentUser;
@property (nonatomic, retain) NSArray *permissions;
@property (nonatomic, retain) NetworkingManager *networkManager;
@end

@implementation UserController

+ (id)sharedUserController {
    static UserController *sharedUserControler = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedUserControler = [[self alloc] init];
    });

    return sharedUserControler;
}

- (id)init {
    self = [super init];

    if (self != nil) {
        @try {
            _currentUser = [self getCurrentUser];
            // Remove the line below once we solve the registration issue with Fabric
            [_currentUser setLoggedIn:YES];
            self.permissions = @[@"public_profile", @"email", @"user_friends"];

            [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];

            self.networkManager = [NetworkingManager sharedNetworkingManger];
        }
        @catch (NSException *exception) {
            @throw exception;
        }
    }

    return self;
}

- (User *)getCurrentUser {
    User *persistedUser;

    if (_currentUser != nil) {
        return _currentUser;
    } else {
        @try {
            persistedUser = [self getUserFromRealm];
        }
        @catch (NSException *exception) {
            NSLog(@"UserController: %@", [exception description]);
            @throw exception;
        }
    }

    if (persistedUser != nil) {
        return [[User alloc] initWithObject:persistedUser];
    } else {
        User *user = [[User alloc] init];
        [user setLoggedIn:NO];
        return user;
    }
}

- (void)setCurrentUser:(User *)user {
    self.currentUser = user;
}

- (User *)getUserFromRealm {
    User *user;
    RLMResults *userArray = [User objectsWhere:@"userType = 0"];

    if ([userArray count] == 0) {
        return nil;
    } else if ([userArray count] > 1) {
        [NSException raise:@"MULTIPLE_USERS_STORED" format:@"There should only be one primary user in Realm."];
    } else {
        user = [userArray firstObject];
    }

    return user;
}

- (void)login {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:_permissions handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {

        } else if (result.isCancelled) {

        } else {
            NSLog(@"User logged in.");
            NSLog(@"Access Token: %@", result.token);
            if ([result.grantedPermissions containsObject:@"email"]) {
                [self.currentUser setFacebookID:[[FBSDKProfile currentProfile] userID]];
                [self.currentUser setDisplayName:[[FBSDKProfile currentProfile] name]];
                [self.currentUser setAuthToken:result.token.tokenString];
                [self.currentUser setHasApp:true];

                #warning Need to setup aps-environment entitlement string as specified in the documentation: https://developer.apple.com/library/ios/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/EnablingLocalAndPushNotifications.html
                [self.currentUser setDeviceID:@"woof_woof"];

                //Persist user
                [self persistUser:self.currentUser];

                //Send user to server
                [self.networkManager sendDictionary:[[self getUserFromRealm] JSONDictionary] toService:@"users"];
            }
        }
    }];
}

- (BOOL)isLoggedIn {
    return [[self getCurrentUser] loggedIn];
}

- (void)persistCurrentUser {
    @try {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [User createOrUpdateInDefaultRealmWithObject:_currentUser];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
    @catch (NSException *exception) {
        NSLog(@"User could not be persisted: %@", [exception description]);
    }

}

- (void)persistUser:(User *)user {
    _currentUser = user;
    [self persistCurrentUser];

    // Recreate the in-memory copy with an unpersisted copy of the realm version
    _currentUser = [[User alloc] initWithObject:[self getUserFromRealm]];
}

- (NSDictionary *)getUserAuthDetailsDictionary {
    return nil;
}

@end
