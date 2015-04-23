//
//  UserController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 26/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

// Framework Imports
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Realm/Realm.h>
#import <Parse/Parse.h>

// App Imports
#import "UserManager.h"
#import "NetworkingManager.h"
#import "Event.h"
#import "Invitation.h"

@interface UserManager()

@property (nonatomic) User *user;
@property (nonatomic) NSArray *permissions;
@property (nonatomic) NetworkingManager *networkManager;

@end

@implementation UserManager

+ (id)sharedUserController {
    static UserManager *sharedUserControler = nil;
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
            self.permissions = @[@"public_profile", @"email", @"user_friends"];

            [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];

            self.networkManager = [NetworkingManager sharedNetworkingManger];

            [self createInMemoryCopy];
        }
        @catch (NSException *exception) {
            @throw exception;
        }
    }

    return self;
}

- (User *)currentUser {
    if (self.user != nil) {
        return self.user;
    } else {
        @throw [NSException exceptionWithName:@"Fatal: cannot return user" reason:@"In memory copy of user does not exist" userInfo:nil];
    }

}

// Instantiates a new or cached version of the current user.
- (void)createInMemoryCopy {
    User *persistedUser;

    @try {
        persistedUser = [self getUserFromRealm];
    } @catch (NSException *exception) {
        NSLog(@"UserController: Error retrieving user from realm: %@", [exception description]);
        @throw exception;
    }

    if (persistedUser != nil) {
        NSLog(@"UserController: Loading cached data.");
        [self setCurrentUser:persistedUser];
        [[self currentUser] setLoggedIn:YES];
    } else {
        NSLog(@"UserController: Creating new user.");
        User *newUser = [[User alloc] init];
        [newUser setLoggedIn:NO];
        [self setCurrentUser:newUser];
    }
}

- (void)setCurrentUser:(User *)user {
    self.user = [[User alloc] initWithObject:user];
}

- (User *)getUserFromRealm {
    User *realmUser;
    RLMResults *userArray = [User objectsWhere:@"userType = 0"];

    if ([userArray count] == 0) {
        NSLog(@"UserController: User has not yet been stored.");
        return nil;
    } else if ([userArray count] > 1) {
        [NSException raise:@"MULTIPLE_USERS_STORED" format:@"There should only be one primary user in Realm."];
    } else {
        realmUser = [userArray firstObject];
    }

    return realmUser;
}

- (void)login {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:_permissions handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {

        } else if (result.isCancelled) {

        } else {
            NSLog(@"UserController: User logged in.");
            NSLog(@"Access Token: %@", result.token);
            if ([result.grantedPermissions containsObject:@"email"]) {
                [self.user setAuthToken:result.token.tokenString];
                // Wait for FBSDKProfile to retrieve user information
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAndPersistFacebookProfile) name:FBSDKProfileDidChangeNotification object:nil];
            }
        }
    }];
}

- (void)setAndPersistFacebookProfile {
    [self.user setFacebookID:[[FBSDKProfile currentProfile] userID]];
    [self.user setDisplayName:[[FBSDKProfile currentProfile] name]];
    [self.user setHasApp:YES];
    [self.user setLoggedIn:YES];

    [self persistCurrentUser];
    [self registerWithParse];

    //Send user to server
    [self.networkManager sendDictionary:[[self getUserFromRealm] JSONDictionary] toService:@"users"];
}

- (BOOL)isLoggedIn {
    return [[self currentUser] loggedIn];
}

- (void)persistCurrentUser {
    [self persistUser:[self currentUser]];
}

- (void)persistUser:(User *)user {
    @try {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [User createOrUpdateInDefaultRealmWithObject:[[User alloc] initWithObject:user]];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
    @catch (NSException *exception) {
        NSLog(@"User could not be persisted. Exception: %@", [exception description]);
    }
}

- (NSDictionary *)getUserAuthDetailsDictionary {
    return nil;
}

// Parse data
- (void)registerWithParse {
    NSLog(@"Sending dictionary to parse: %@", [[self currentUser] JSONDictionary]);

    PFQuery *query = [[PFQuery alloc] initWithClassName:@"User"];
    [query whereKey:@"auth_id" equalTo:[[self currentUser] facebookID]];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (error == nil) {
            PFObject *userObject;
            if (count == 0) {
                userObject = [PFObject objectWithClassName:@"User" dictionary:[[self currentUser] JSONDictionary]];
                [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"User %@ sent to Parse.", [self description]);
                    } else {
                        NSLog(@"User %@ could not be saved. Error: %@", [self description], [error description]);
                    }
                }];
            } else {
                [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                    if (object != nil) {
                        PFObject *userObject = [PFObject objectWithClassName:@"User" dictionary:[[self currentUser] JSONDictionary]];
                        [userObject setValue:[object objectId] forKey:@"objectId"];
                        [userObject saveInBackground];
                    }
                }];
            }
        }
    }];
}

- (void)downloadEvents {
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithObjects:@[[[self currentUser] facebookID]] forKeys:@[@"auth_id"]];

    [[NetworkingManager sharedNetworkingManger] requestWithDictionary:requestDictionary fromService:LKEndPointEventsForUser completion:^(id response, NSError *error) {
        if (error) {
            NSLog(@"Failed to download events: %@", [error description]);
        } else {
            [Event createOrUpdateInRealm:[RLMRealm defaultRealm] withJSONArray:(NSArray *)response];
        }
    }];
}

@end
