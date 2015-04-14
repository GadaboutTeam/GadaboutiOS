//
//  SignalsTableViewCell.h
//  GadaboutiOS
//
//  Created by David Barsky on 4/14/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SignalsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
