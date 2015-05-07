//
//  EventConversationViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 21/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

// Frameworks
#import <Realm/Realm.h>

//
#import "EventConversationViewController.h"
#import "Invitation.h"
#import "InvitationManager.h"
#import "User.h"
#import "UserManager.h"

@interface EventConversationViewController ()

@property (nonatomic, retain) RLMResults *invitations;
@property (nonatomic, retain) RLMNotificationToken *notification;

@end

@implementation EventConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [InvitationManager getInvitationsForEvent:self.event];

    __weak typeof(self) weakSelf = self;
    weakSelf.notification = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        weakSelf.invitations = [Invitation objectsWhere:[NSString stringWithFormat:@"event_id = '%@ '", [self.event event_id]]];

        RLMArray<Invitation> *invitationsArray = [[RLMArray alloc] initWithObjectClassName:@"Invitation"];
        [invitationsArray addObjects:weakSelf.invitations];
        [weakSelf.event setInvitations:invitationsArray];
        [weakSelf populateTextViewsWithData:invitationsArray];
        NSLog(@"User status: %@", self.invitations);
    }];
}

- (void)populateTextViewsWithData:(RLMArray<Invitation> *)invitationsArray {
    [self.confirmedTextView setText: @""];
    [self.waitingTextView setText:@""];

    NSMutableArray *confirmedUsers = [[NSMutableArray alloc] init];
    NSMutableArray *waitingUsers = [[NSMutableArray alloc] init];
    for (Invitation *invitation in invitationsArray) {
        User *user = [User objectForPrimaryKey:[[invitation user_id] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if (![[[invitation user_id] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:[[[UserManager sharedUserController] currentUser] facebookID]]) {
            switch ([invitation reply]) {
                case ReplyStatusAccepted:
                    [confirmedUsers addObject:user];
                    break;
                case ReplyStatusUnknown:
                    [waitingUsers addObject:user];
                    break;
                default:
                    break;
            }
        }

    }
    for (User *user in confirmedUsers) {
        [self.confirmedTextView insertText:[NSString stringWithFormat:@"%@\n", [user displayName]]];
    }

    for (User *user in waitingUsers) {
        [self.waitingTextView insertText:[NSString stringWithFormat:@"%@\n", [user displayName]]];
    }

    NSLog(@"textView text: %@", [self.waitingTextView text]);
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.eventTitleLabel setText:[self.event name]];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
