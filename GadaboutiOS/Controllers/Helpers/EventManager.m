//
//  EventController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 21/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "EventManager.h"
#import "NetworkingManager.h"
#import "UserManager.h"
#import "InvitationManager.h"

@implementation EventManager

+ (void)requestEventCreation:(Event *)event withParticipants:(NSArray *)participants andBlock:(void (^)(id, NSError *))block {
    NSDictionary *dictionary = [EventManager prepareRequestDictionaryFromEvent:event andParticipants:participants];
    NSLog(@"jsonDictionary: %@", dictionary);
    [[NetworkingManager sharedNetworkingManger] requestWithDictionary:dictionary fromService:LKEndPointCreateEvent completion:block];
}

+ (void)getUserEventsWithBlock:(void (^)(id, NSError *))block {
    NSString *authID = [[[UserManager sharedUserController] currentUser] facebookID];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjects:@[authID] forKeys:@[@"auth_id"]];

    [[NetworkingManager sharedNetworkingManger] getRequestWithDictionary:requestDict fromService:LKEndPointEventsForUser completion:^(id response, NSError *error) {
        if (block != nil) {
            block(response, error);
        }
        if (error) {
            NSLog(@"[Event Controller] Error retrieving events for user %@: %@", authID, [error description]);
        } else {
            [EventManager persistEvents:(NSArray *)response];

            RLMResults *events = [Event allObjects];
            NSLog(@"Events: %@", response);
            for (Event *event in events) {
                [InvitationManager getInvitationsForEvent:event withBlock:^(id response, NSError *error) {
                    NSLog(@"Invitations Response: %@", (NSArray *)[response description]);
                    [[RLMRealm defaultRealm] beginWriteTransaction];
                    [event setInvitations:(RLMArray<Invitation> *)[Invitation objectsInRealm:[RLMRealm defaultRealm] where:@"event_id = '%@'", [event event_id]]];
                    [[RLMRealm defaultRealm] commitWriteTransaction];
                }];
            }

        }
    }];
}

+ (NSArray *)eventsWithJSONArray:(NSArray *)eventsJSONArray {
    NSMutableArray *eventsArray = [[NSMutableArray alloc] init];
    for (NSDictionary *eventDictionary in eventsJSONArray) {
        Event *event = [[Event alloc] initWithJSONDictionary:eventDictionary];
        [eventsArray addObject:event];
    }
    return eventsArray;
}

+ (void)persistEvents:(NSArray *)events {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    for (NSDictionary *eventDict in events) {
        NSString *event_id = [eventDict objectForKey:@"id"];
        NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:eventDict];
        [md setObject:[NSString stringWithFormat:@"%@ ", event_id] forKey:@"id"];
        Event *event = [[Event alloc] initWithJSONDictionary:md];
        [Event createOrUpdateInDefaultRealmWithObject:event];
    }
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

+ (void)getInvitationsForEvent:(Event *)event withBlock:(void (^)(id, NSError *))block{
    [InvitationManager getInvitationsForEvent:event withBlock:^(id response, NSError *error) {
        if (!error) {
            NSLog(@"[EventManager]Received invitations for event: %@", event);
            RLMResults *invitations = [Invitation objectsWhere:[NSString stringWithFormat:@"event_id = '%@'", [event event_id]]];
            [EventManager persistInvitations:(RLMArray<Invitation> *)invitations forEvent:event];
            if (block!=nil) {
                block(response, nil);
            }
        } else {
            NSLog(@"Failed to get invitations for event: %@", event);
        }
    }];
}

+ (void)persistInvitations:(RLMArray<Invitation> *)invitationsArray forEvent:(Event *)event {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [event setInvitations:invitationsArray];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

+ (NSDictionary *)prepareRequestDictionaryFromEvent:(Event *)event andParticipants:(NSArray *)participants {
    User *user = [[UserManager sharedUserController] currentUser];
    NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc] init];

    //Add authentication details
    [requestDictionary addEntriesFromDictionary:
     [NSDictionary dictionaryWithObjects:@[[user facebookID], [user authToken]]
                                 forKeys:@[@"auth_id", @"auth_token"]]];

    //Add events details
    [requestDictionary addEntriesFromDictionary:
     [NSDictionary dictionaryWithObjects:@[[event name], [event start_time], [event end_time], [NSString stringWithFormat:@"%ld", (long)[event active]]]
                                 forKeys:@[@"title", @"start_time", @"end_time", @"active"]]];


    //Add user details
    NSMutableArray *participantIDs = [[NSMutableArray alloc] init];
    for (User *user in participants) {
        [participantIDs addObject:[NSString stringWithFormat:@"'%@'", [user facebookID]]];
    }
    NSString *participantIDsArrayString = [[participantIDs valueForKey:@"description"] componentsJoinedByString:@","];
    participantIDsArrayString = [NSString stringWithFormat:@"[%@]", participantIDsArrayString];

    [requestDictionary addEntriesFromDictionary:
     [NSDictionary dictionaryWithObject:participantIDsArrayString forKey:@"users_array"]];

    return requestDictionary;
}

@end
