//
//  ActionButtons.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "ActionButton.h"

IB_DESIGNABLE
@implementation ActionButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // border
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = 3.0;
    
    // Text
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f];
    self.titleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

@end
