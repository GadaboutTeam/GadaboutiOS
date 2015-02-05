//
//  Person.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Realm/Realm.h>

@interface Friend : RLMObject

@property NSInteger *userID;
@property NSString *facebookID;
@property NSString *name;
@property NSData *profilePhoto;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Person>
RLM_ARRAY_TYPE(Friend)
