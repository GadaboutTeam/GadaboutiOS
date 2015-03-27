//
//  UserController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 26/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "UserController.h"
#import <TwitterKit/TwitterKit.h>

@interface UserController()
@property (nonatomic, retain) User *currentUser;

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
        return [[User alloc] init];
    }
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

- (void)signUp {
    DGTAppearance *appearance = [[DGTAppearance alloc] init];

    appearance.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    appearance.accentColor = [UIColor colorWithRed:0.99 green:0.33 blue:0.33 alpha:1];

    Digits *digits = [Digits sharedInstance];
    [digits authenticateWithDigitsAppearance:appearance
                              viewController:nil
                                       title:nil
                                  completion:^(DGTSession *session, NSError *error) {
                                      if (session) {
                                          NSLog(@"Logged in!");

                                          [_currentUser setAuthToken:session.authToken];
                                          [_currentUser setPhoneNumber:session.phoneNumber];
                                          [_currentUser setAuthTokenSecret:session.authTokenSecret];
                                          [_currentUser setDigitsID:session.userID];
                                          [_currentUser setLoggedIn:YES];
                                      } else {
                                          NSLog(@"Digits error: %@", [error description]);
                                      }
                                  }];
}

- (BOOL)isLoggedIn {
    return [self getUserFromRealm] != nil;
}

- (void)persistCurrentUser {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [User createOrUpdateInDefaultRealmWithObject:_currentUser];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)persistUser:(User *)user {
    _currentUser = user;
    [self persistCurrentUser];

    // Recreate the in-memory copy with an unpersisted copy of the realm version
    _currentUser = [[User alloc] initWithObject:[self getUserFromRealm]];
}

@end
