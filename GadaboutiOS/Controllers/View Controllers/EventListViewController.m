//
//  EventListViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 22/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "EventListViewController.h"

#import <Realm/Realm.h>

#import "EventController.h"
#import "EventSummaryCell.h"
#import "Event.h"

@interface EventListViewController ()

@property (nonatomic, retain) RLMResults *events;
@property (nonatomic, retain) RLMNotificationToken *notification;

@end

@implementation EventListViewController

static NSString * const reuseIdentifier = @"EventCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    //DummyEvent
//    Event *dummyEvent = [[Event alloc] init];
//    [dummyEvent setValue:@"42" forKey:@"event_id"];
//    [dummyEvent setName:@"Dummy Event"];
//    [EventController getInvitationsForEvent:dummyEvent withBlock:^(id response, NSError *error) {
//        NSLog(@"Response: %@", response);
//        RLMArray<Invitation> *invArray = (RLMArray<Invitation> *)[[RLMArray alloc] initWithObjectClassName:@"Invitation"];
//        [invArray addObjects:invArray];
//        [dummyEvent setInvitations:invArray];
//    }];
//
//    self.events = [[RLMArray alloc] initWithObjectClassName:@"Event"];
//    [self.events addObject:dummyEvent];

    __weak typeof(self) weakSelf = self;
    weakSelf.notification = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        if([[Event allObjects] count]!= 0) {
            weakSelf.events = [Event allObjects];
        }


        [weakSelf.tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [EventController getUserEventsWithBlock:^(id object, NSError *error) {
        if (error) {
            NSLog(@"Error retrieving events for user: %@", [error description]);
        } else {
            NSLog(@"Events downloaded");
        }
    }];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventSummaryCell *cell = (EventSummaryCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

    Event *event = [self.events objectAtIndex:[indexPath row]];
    [cell.eventTitleTextField setText:[event name]];

    return cell;
}

@end
