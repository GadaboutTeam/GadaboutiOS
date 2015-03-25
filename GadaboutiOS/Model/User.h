//
//  Person.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Realm/Realm.h>

@interface User : RLMObject

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeSelf,
    UserTypeFriend
};

@property (nonatomic) NSString *displayName;
@property (nonatomic) NSString *phoneNumber;
@property (nonatomic) NSString *authToken;
@property (nonatomic) UserType userType;

@end

// This protocol enables typed collections. i.e.:
RLM_ARRAY_TYPE(User)
