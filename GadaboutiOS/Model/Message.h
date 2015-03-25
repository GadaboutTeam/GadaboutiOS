//
//  Message.h
//  GadaboutiOS
//
//  Created by David Barsky on 3/24/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Realm/Realm.h>
#import <JSQMessageData.h>

@interface Message : RLMObject <JSQMessageData>

// required for JSQMessageProtocol Adherence
@property NSString *senderId;                     // uniquly identifies user who send the message
@property NSDate *date;                           // time message was sent
@property NSString *senderDisplayName;            // display name for user who sent message
@property BOOL isMediaMessage;                    // used to determine if the message data contains text or media.
@property NSUInteger *messageHash;                // 

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Message>
RLM_ARRAY_TYPE(Message)
