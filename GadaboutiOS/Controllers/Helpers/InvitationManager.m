//
//  InvitationController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 22/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "InvitationManager.h"

#import <Realm/Realm.h>

#import "NetworkingManager.h"
#import "Invitation.h"

@implementation InvitationManager

+ (void)getInvitationsForEvent:(Event *)event {
    [self getInvitationsForEvent:event withBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"[InvitationController] Could not retrieve users for event %ld: %@", (long)[event event_id], error);
        } else {
            [InvitationManager persistInvitations:response];
        }
    }];
}

+ (void)getInvitationsForEvent:(Event *)event withBlock:(void (^)(id, NSError *))block{
    long eventID = (long)[event event_id];
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithLong:eventID] forKey:@"event_id"];

    [[NetworkingManager sharedNetworkingManger]
     getRequestWithDictionary:requestDictionary
     fromService:[NSString stringWithFormat:@"%@/%ld/%@", LKEndPointCreateEvent, (long)eventID, LKEndPointUsersForEvent]
     completion:block];
}

+ (void)persistInvitations:(NSArray *)invitationsArray {
    [Invitation createOrUpdateInRealm:[RLMRealm defaultRealm] withJSONArray:invitationsArray];
}

@end
