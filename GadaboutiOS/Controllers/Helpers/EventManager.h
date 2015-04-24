//
//  EventController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 21/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Event.h"

@interface EventManager : NSObject

+ (void)requestEventCreation:(Event *)event withParticipants:(NSArray *)participants andBlock:(void (^)(id, NSError *))block;
+ (void)getUserEventsWithBlock:(void (^)(id, NSError *))block;
+ (void)getInvitationsForEvent:(Event *)event withBlock:(void (^)(id, NSError *))block;

@end
