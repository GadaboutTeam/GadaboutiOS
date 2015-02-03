//
//  Invitation.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/1/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Realm/Realm.h>
#import "Friend.h"

@interface Invitation : RLMObject

@property NSString *name;
@property NSDate *timeOfOccurance;
@property NSString *location;
@property RLMArray<Friend> *invitedPeople;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Invitation>
RLM_ARRAY_TYPE(Invitation)
