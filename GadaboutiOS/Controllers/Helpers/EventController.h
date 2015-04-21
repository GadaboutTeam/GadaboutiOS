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

@interface EventController : NSObject

+ (void)requestEventCreation:(Event *)event withParticipants:(NSArray *)participants andBlock:(void (^)(id, NSError *))block;

@end
