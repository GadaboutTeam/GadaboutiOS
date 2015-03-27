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
        _friendsArray = [[NSMutableArray alloc] init];
    }

    return self;
}

@end
