//
//  SetupView.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/24/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "SetupView.h"
#import <PulsingHalo/PulsingHaloLayer.h>
#import <PulsingHalo/MultiplePulsingHaloLayer.h>

@implementation SetupView

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupBackground];
}

- (void)setupBackground {
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
   
    PulsingHaloLayer *halo = [PulsingHaloLayer layer];
    halo.position = self.center;
    [self.layer addSublayer:halo];
    
    UIColor *haloColor = [UIColor colorWithRed:0.25 green:0.62 blue:0.85 alpha:1];
    halo.backgroundColor = haloColor.CGColor;
}

@end
