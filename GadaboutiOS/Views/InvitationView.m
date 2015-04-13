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
    
    self.tintColor = [UIColor whiteColor];
}

- (void)setupColors {
    self.tintColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithRed:0.32 green:0.61 blue:0.93 alpha:1];
}

@end
