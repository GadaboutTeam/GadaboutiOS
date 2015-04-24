//
//  EventSummaryCell.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 22/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendStatusCollectionViewController.h"

@interface EventSummaryCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UICollectionView *friendStatusCV;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (nonatomic, retain) FriendStatusCollectionViewController *friendStatusController;

@end
