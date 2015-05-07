//
//  InvitationController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 22/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "Invitation.h"

@interface InvitationManager : NSObject

+ (void)getInvitationsForEvent:(Event *)event;
+ (void)getInvitationsForEvent:(Event *)event withBlock:(void (^)(id, NSError *))block;
+ (void)persistInvitations:(NSArray *)invitationsArray;
+ (NSArray *)getInvitationsFromJSONDictionary:(NSArray *)jsonInvitations;
+ (Invitation *)getInvitationFromJSONDictionary:(NSDictionary *)jsonInvitation;
+ (void)sendReply:(Invitation *)invitation withSuccess:(void (^)())successBlock;

@end
