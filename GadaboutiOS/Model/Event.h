//
//  Event.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 20/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "RLMObject.h"

@interface Event : RLMObject

@property (nonatomic) NSString *event_id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *start_time;
@property (nonatomic) NSString *end_time;
@property (nonatomic) BOOL active;

@end
