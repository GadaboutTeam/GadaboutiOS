//
//  InvitationView.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/13/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "InvitationView.h"

@implementation InvitationView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupColors];
}

- (void)setupColors {
    self.tintColor = [UIColor whiteColor];
//    self.backgroundColor = [UIColor colorWithRed:0.32 green:0.61 blue:0.93 alpha:1]; //81 155 237
    self.backgroundColor = [UIColor colorWithRed:0.659 green:0.808 blue:0.976 alpha:1.0]; //168 206 249
}

@end
