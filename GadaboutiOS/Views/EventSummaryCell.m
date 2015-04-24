//
//  EventSummaryCell.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 22/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "EventSummaryCell.h"
#import "FriendStatusViewCell.h"

@interface EventSummaryCell()

@end

@implementation EventSummaryCell

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.friendStatusController = [[FriendStatusCollectionViewController alloc] init];
        [self.friendStatusCV setDelegate:self.friendStatusController];
        [self.friendStatusCV setDataSource:self.friendStatusController];
    }
    return self;
}

@end
