//
//  User.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 02/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Realm/Realm.h>
#import "Friend.h"

@interface User : RLMObject

@property NSUInteger *userID;
@property NSString *facebookID;
@property NSString *authToken;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *email;
@property RLMArray<Friend> *friends;
@property NSData *profilePhoto;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<User>
RLM_ARRAY_TYPE(User)