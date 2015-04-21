//
//  Invitation.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 20/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "RLMObject.h"

@interface Invitation : RLMObject

typedef NS_ENUM(NSInteger, ReplyStatus) {
    ReplyStatusUnknown,
    ReplyStatusAccepted,
    ReplyStatusDenied
};

@property (nonatomic) NSString *invitation_id;
@property (nonatomic) NSString *event_id;
@property (nonatomic) NSString *user_id;
@property (nonatomic) ReplyStatus reply;

@end
