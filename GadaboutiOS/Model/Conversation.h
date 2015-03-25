//
//  Conversation.h
//  
//
//  Created by David Barsky on 3/23/15.
//
//

#import <Realm/Realm.h>
#import "User.h"
#import "Message.h"

@interface Conversation : RLMObject

@property NSString *converationName;
@property RLMArray<User> *participants;
@property RLMArray<Message> *messages;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Conversation>
RLM_ARRAY_TYPE(Conversation)
