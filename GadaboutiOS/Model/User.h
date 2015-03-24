//
//  Person.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Realm/Realm.h>

@interface User : RLMObject

@property NSInteger *userID;

// For ATLParticipant Protocol
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *fullName;
@property (nonatomic) NSString *participantIdentifier;

@property NSData *profilePhoto;

@end

// This protocol enables typed collections. i.e.:
RLM_ARRAY_TYPE(User)
