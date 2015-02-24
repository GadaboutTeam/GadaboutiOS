//
//  GhostButton.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/24/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "GhostButton.h"

@implementation GhostButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupButtonBorder];
}

- (void)setupButtonBorder {
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.layer setCornerRadius: 4.0f];
}

@end
