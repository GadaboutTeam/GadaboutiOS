//
//  EventSummaryCell.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 22/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventSummaryCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *particpantsLabel;

@end
