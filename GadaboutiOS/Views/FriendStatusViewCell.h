//
//  FriendStatusViewCell.h
//  GadaboutiOS
//
//  Created by David Barsky on 4/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendStatusCollectionViewController.h"

IB_DESIGNABLE
@interface FriendStatusViewCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UIImageView *profilePicture;
@property (nonatomic, retain) IBOutlet UIView *friendStatus;

@end
