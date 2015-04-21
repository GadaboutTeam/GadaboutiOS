//
//  EventController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 21/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "EventController.h"
#import "NetworkingManager.h"
#import "UserManager.h"

@implementation EventController

+ (void)requestEventCreation:(Event *)event withParticipants:(NSArray *)participants andBlock:(void (^)(id, NSError *))block {
    NSDictionary *dictionary = [EventController prepareRequestDictionaryFromEvent:event andParticipants:participants];
    NSLog(@"jsonDictionary: %@", dictionary);
    [[NetworkingManager sharedNetworkingManger] requestWithDictionary:dictionary fromService:LKEndPointCreateEvent completion:block];
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
