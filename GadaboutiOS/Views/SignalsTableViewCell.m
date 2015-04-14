//
//  SignalsTableViewCell.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/14/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "SignalsTableViewCell.h"

@interface SignalsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SignalsTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutProfilePicture];
}

- (void)layoutProfilePicture {
    self.profilePicture.layer.masksToBounds = YES;
    self.profilePicture.layer.cornerRadius = 30;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
