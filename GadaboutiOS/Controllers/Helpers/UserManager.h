//
//  UserController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 26/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

+ (id)sharedUserController;
- (void)login;

- (User *)currentUser;
- (void)persistCurrentUser;

//- (void)setCurrentUser:(User *)user;
- (BOOL)isLoggedIn;
@end
