//
//  SetupView.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/24/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "SetupView.h"

@implementation SetupView

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self setBackgroundGradient];
}

- (void)setBackgroundGradient {

    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
}

@end
