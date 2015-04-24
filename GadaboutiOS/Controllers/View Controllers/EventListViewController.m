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
#import "EventConversationViewController.h"
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
    [self loadUserEvents];
    
    __weak typeof(self) weakSelf = self;
    weakSelf.notification = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        if([[Event allObjects] count]!= 0) {
            weakSelf.events = [Event allObjects];
        }

        [weakSelf.tableView reloadData];
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)loadUserEvents {
    [EventController getUserEventsWithBlock:^(id object, NSError *error) {
        if (error) {
            NSLog(@"Error retrieving events for user: %@", [error description]);
        } else {
            NSLog(@"Events downloaded");
        }
    }];
}

- (IBAction)triggerTableRefresh:(id)sender {
    if ([self.refreshControl isRefreshing]) {
        [self loadUserEvents];
    }
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"EventListToConversation"]) {
        EventConversationViewController *eventVC = (EventConversationViewController *)[segue destinationViewController];
        Event *event = [self.events objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        [eventVC setEvent:event];
    }
}

@end
