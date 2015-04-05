//
//  FriendCell.h
//  GadaboutiOS
//
//  Created by David Barsky on 3/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *firstName;

@end
