//
//  EventConversationViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 21/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "EventConversationViewController.h"

@implementation EventConversationViewController

- (void)viewDidAppear:(BOOL)animated {
    [self.eventTitleLabel setText:[self.event name]];
}

@end
