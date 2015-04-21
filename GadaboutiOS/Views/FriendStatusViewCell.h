//
//  FriendStatusViewCell.h
//  GadaboutiOS
//
//  Created by David Barsky on 4/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface FriendStatusViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIView *friendStatus;

@end
