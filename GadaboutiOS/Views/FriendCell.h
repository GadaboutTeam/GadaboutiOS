//
//  FriendCell.h
//  GadaboutiOS
//
//  Created by David Barsky on 3/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKProfilePictureView.h>

@interface FriendCell : UICollectionViewCell
typedef NS_ENUM(NSInteger, CellState) {
    CellStateDeselected,
    CellStateSelected
};

@property (retain, nonatomic) FBSDKProfilePictureView *profilePicture;
@property (retain, nonatomic) IBOutlet UILabel *displayName;
@property (retain, nonatomic) IBOutlet UIImageView *profilePictureView;

@end
