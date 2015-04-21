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
@property (nonatomic) NSDate *start;
@property (nonatomic) NSDate *end;
@property (nonatomic) BOOL active;

@end
