//
//  SignalsTableViewCell.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/14/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "SignalsTableViewCell.h"

@interface SignalsTableViewCell ()

@end

@implementation SignalsTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutProfilePicture];
}

- (void)layoutProfilePicture {
    self.profilePicture.backgroundColor = [UIColor blueColor];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
