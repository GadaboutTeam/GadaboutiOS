//
//  Person.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Realm/Realm.h>
#import <Atlas/Atlas.h>
#import <Realm+JSON/RLMObject+JSON.h>

@interface User : RLMObject <ATLParticipant>

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeSelf,
    UserTypeFriend
};

// ATLParticipant Protocol Adherence
@property (nonatomic) NSString *userID;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *fullName; // need to make displayName == fullName
@property (nonatomic, readonly) NSString *participantIdentifier; // needed for Atlas

// Facebook
@property (nonatomic) NSString *displayName;
@property (nonatomic) NSString *authToken;
@property (nonatomic) NSString *deviceID;
@property (nonatomic) NSString *facebookID;
@property (nonatomic) NSString *email;

// Us
@property (nonatomic) UserType userType;

// Location
@property (nonatomic) NSInteger lat;
@property (nonatomic) NSInteger lon;

@property (nonatomic) BOOL loggedIn;

@end

// This protocol enables typed collections. i.e.:
RLM_ARRAY_TYPE(User)
