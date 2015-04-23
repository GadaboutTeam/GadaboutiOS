//
//  EventConversationViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 21/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "EventConversationViewController.h"

#import <Realm/Realm.h>

#import "Invitation.h"
#import "InvitationController.h"

@interface EventConversationViewController ()

@property (nonatomic, retain) RLMResults *invitations;
@property (nonatomic, retain) RLMNotificationToken *notification;

@end

@implementation EventConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [InvitationController getInvitationsForEvent:self.event];

    __weak typeof(self) weakSelf = self;
    weakSelf.notification = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        weakSelf.invitations = [Invitation objectsWhere:[NSString stringWithFormat:@"event_id = '%@'", [self.event event_id]]];
        RLMArray<Invitation> *invitationsArray = [[RLMArray alloc] initWithObjectClassName:@"Invitation"];
        [invitationsArray addObjects:weakSelf.invitations];
        [weakSelf.event setInvitations:invitationsArray];
        NSLog(@"User status: %@", self.invitations);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.eventTitleLabel setText:[self.event name]];
}

@end
