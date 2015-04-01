//
//  Person.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Realm/Realm.h>
#import <Realm+JSON/RLMObject+JSON.h>

@interface User : RLMObject

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeSelf,
    UserTypeFriend
};

@property (nonatomic) NSString *displayName;
@property (nonatomic) NSString *authToken;
@property (nonatomic) NSString *deviceID;
@property (nonatomic) NSString *facebookID;
@property (nonatomic) NSString *email;
@property (nonatomic) UserType userType;
@property (nonatomic) NSInteger lat;
@property (nonatomic) NSInteger lon;

@property (nonatomic) BOOL loggedIn;

@end

// This protocol enables typed collections. i.e.:
RLM_ARRAY_TYPE(User)
