//
//  User.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 02/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "RLMObject.h"

@interface User : RLMObject

@property NSString *name;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<User>
RLM_ARRAY_TYPE(User)