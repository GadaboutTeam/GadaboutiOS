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
#import "User.h"
#import "UserManager.h"

@implementation InvitationManager

+ (void)getInvitationsForEvent:(Event *)event {
    [self getInvitationsForEvent:event withBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"[InvitationController] Could not retrieve invitations for event %ld: %@", (long)[event event_id], error);
        } else {
            [InvitationManager persistInvitations:response];
        }
    }];
}

+ (void)getInvitationsForEvent:(Event *)event withBlock:(void (^)(id, NSError *))block{
    NSString *eventID = [[event event_id] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *userID = [[[UserManager sharedUserController] currentUser] facebookID];
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithObject:userID forKey:@"auth_id"];
    NSLog(@"Sending GET request.");
    [[NetworkingManager sharedNetworkingManger]
     getRequestWithDictionary:requestDictionary
     fromService:[NSString stringWithFormat:@"%@/%@/%@", LKEndPointCreateEvent, eventID, LKEndPointInvitationsForEvent]
     completion:^(id response, NSError *error) {
         if (!error) {
             NSLog(@"Invitations response: %@", (NSArray *)response);
             [self persistInvitations:(NSArray *)response];
             if(block != nil) {
                 block(response, nil);
             }
         } else {
             NSLog(@"[InvitationController] Could not retrieve invitations for event %ld: %@", (long)[event event_id], error);
         }
     }];
}

+ (NSArray *)getInvitationsFromJSONDictionary:(NSArray *)jsonInvitations {
    NSMutableArray *invitationsArray = [[NSMutableArray alloc] init];
    for (NSDictionary *jsonInvitation in jsonInvitations) {
        Invitation *invitation = [[Invitation alloc] initWithJSONDictionary:jsonInvitation];
        [invitationsArray addObject:invitation];
    }
    return invitationsArray;
}

+ (void)persistInvitations:(NSArray *)invitationsArray {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [Invitation createOrUpdateInRealm:[RLMRealm defaultRealm] withJSONArray:invitationsArray];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

+ (User *)getUserForInvitation:(Invitation *)invitation {
    User *user = [User objectForPrimaryKey:[invitation user_id]];
    return user;
}

@end
